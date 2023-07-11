{{
  config(
    materialized = 'incremental',
    incremental_strategy = 'insert_overwrite',
    partition_by = {'field': 'period_date', 'data_type': 'date'}
  )
}}

with minute_slot_aggregation as (
  
    select
        timestamp_trunc(period_started_at, minute) as period_start_minute,
        sum(period_slot_ms)/(1000 * 60) as slot_hour_rate
    
    from {{ ref('int_bq_info_schema_jobs_timeline_incremental') }}

    {% if is_incremental() %}
    -- recalculate latest day's data + previous
    where date(job_created_at) >= date_sub(date(_dbt_max_partition), interval 1 day)
    {% endif %}
    
    {{ dbt_utils.group_by(n=1) }}

)

select
  date(period_start_minute) as period_date,
  floor(slot_hour_rate/100) * 100 as slot_hour_rate_lower_bound,
  count(*) as total_minutes

from minute_slot_aggregation

{{ dbt_utils.group_by(n=2) }}
