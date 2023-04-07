{{
  config(
    materialized = 'incremental',
    incremental_strategy = 'insert_overwrite',
    partition_by = {'field': 'jobs_started_at', 'data_type': 'timestamp'}
  )
}}

select
  labels.value as dbt_invocation_id,
  any_value(user_email) as user_email,
  array_agg(job_id) as jobs,
  min(created_at) as jobs_started_at,
  max(ended_at) as jobs_ended_at,
  sum(total_bytes_billed) as total_bytes_billed,
  sum(total_bytes_processed) as total_bytes_processed,
  sum(total_slot_ms) as total_slot_ms,

from {{ ref('int_bq_info_schema_jobs_incremental') }}

inner join unnest(labels) as labels

where labels.key = 'dbt_invocation_id'

{%- if is_incremental() %}
    -- recalculate latest day's data + previous
    where date(created_at) >= date_sub(date(_dbt_max_partition), interval 1 day)
{%- endif %}

{{ dbt_utils.group_by(n=1) }}