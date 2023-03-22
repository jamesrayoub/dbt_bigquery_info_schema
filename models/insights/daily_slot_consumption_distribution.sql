{% set partitions_to_replace = [
  'timestamp(current_date)',
  'timestamp(date_sub(current_date, interval 1 day))'
] %}

{{
  config(
    materialized = 'incremental',
    incremental_strategy = 'insert_overwrite',
    partition_by = {'field': 'period_date', 'data_type': 'date'},
    partitions = partitions_to_replace,
  )
}}

with minute_slot_aggregation as (
  
    select
        timestamp_trunc(period_started_at, minute) as period_start_minute,
        sum(period_slot_ms)/(1000 * 60) as avg_slot_consumption
    
    from {{ ref('int_bq_info_schema_jobs_timeline_incremental') }}

    {% if is_incremental() %}
    -- recalculate yesterday + today
    where timestamp_trunc(job_created_at, day) in ({{ partitions_to_replace | join(',') }})
    {% endif %}
    
    {{ dbt_utils.group_by(n=1) }}

)

select
  date(period_start_minute) as period_date,
  floor(avg_slot_consumption/100) * 100 as avg_slot_consumption_lower_bound,
  count(*) as total_minutes

from minute_slot_aggregation

{{ dbt_utils.group_by(n=2) }}
