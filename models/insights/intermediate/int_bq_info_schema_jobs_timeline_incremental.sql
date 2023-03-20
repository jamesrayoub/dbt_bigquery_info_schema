{% set partitions_to_replace = [
  'timestamp(current_date)',
  'timestamp(date_sub(current_date, interval 1 day))'
] %}

{{
  config(
    materialized = 'incremental',
    incremental_strategy = 'insert_overwrite',
    partition_by = {'field': 'job_created_at', 'data_type': 'timestamp'},
    partitions = partitions_to_replace,
    cluster_by = ['user_email','job_type']
  )
}}

select * from {{ ref('stg_bq_info_schema__jobs_timeline') }}

{% if is_incremental() %}
-- recalculate yesterday + today
where timestamp_trunc(job_created_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}