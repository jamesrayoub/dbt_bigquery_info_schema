select
  ref_tables.project_id,
  ref_tables.dataset_id,
  ref_tables.table_id,
  countif(date(created_at) >= date_sub(current_date, interval 30 day)) as last_30_day_query_references,
  countif(date(created_at) >= date_sub(current_date, interval 90 day)) as last_90_day_query_references,
  countif(date(created_at) >= date_sub(current_date, interval 180 day)) as last_180_day_query_references

from {{ ref('int_bq_info_schema_jobs_incremental') }},

unnest(referenced_tables) as ref_tables

where date(created_at) >= date_sub(current_date, interval 180 day)
    and job_type = 'QUERY'
    {%- if var('target_query_users',false) %}
    and user_email in (
      {%- for user in var('target_query_users') %}
        '{{ user }}' {%- if not loop.last -%} , {%- endif -%}
      {%- endfor %}
    )
    {%- endif %}

{{ dbt_utils.group_by(n=3) }}