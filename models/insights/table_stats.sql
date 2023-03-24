select 
    tables.project_id,
    tables.dataset_id,
    tables.table_id,
    table_storage.created_at,
    table_storage.storage_last_modified_time,
    table_storage.total_rows,
    table_storage.total_partitions,
    table_storage.total_logical_bytes,
    table_storage.active_logical_bytes,
    table_storage.long_term_logical_bytes,
    table_storage.total_physical_bytes,
    table_storage.active_physical_bytes,
    table_storage.long_term_physical_bytes,
    ((table_storage.active_logical_bytes / power(1024, 3) * {{ var('logical_active_rate') }})
      + (table_storage.long_term_logical_bytes / power(1024, 3) * {{ var('logical_long_term_rate') }})
      + (table_storage.active_physical_bytes / power(1024, 3) * {{ var('physical_active_rate') }})
      + (table_storage.long_term_physical_bytes / power(1024, 3) * {{ var('physical_long_term_rate') }})
    ) as estimated_monthly_storage_cost,
    coalesce(table_references.last_30_day_query_references,0) as last_30_day_query_references,
    coalesce(table_references.last_90_day_query_references,0) as last_90_day_query_references,
    coalesce(table_references.last_180_day_query_references,0) as last_180_day_query_references

from {{ ref('stg_bq_info_schema__tables') }} as tables

inner join {{ ref('stg_bq_info_schema__table_storage') }} as table_storage
    on tables.project_id = table_storage.project_id
    and tables.dataset_id = table_storage.dataset_id
    and tables.table_id = table_storage.table_id

left join {{ ref('int_bq_info_schema_table_query_references') }} as table_references
    on tables.project_id = table_references.project_id
    and tables.dataset_id = table_references.dataset_id
    and tables.table_id = table_references.table_id

where tables.table_type = 'BASE TABLE'