{{
  config(
    materialized = 'incremental',
    incremental_strategy = 'insert_overwrite',
    partition_by = {'field': 'created_at', 'data_type': 'timestamp'},
    cluster_by = ['user_email','job_type']
  )
}}

select * 
from {{ ref('stg_bq_info_schema__jobs') }}

{% if is_incremental() %}
-- recalculate latest day's data + previous
where date(created_at) >= date_sub(date(_dbt_max_partition), interval 1 day)
{% endif %}