select
    /* primary keys */
    project_id,
    table_schema as dataset_id,
    table_name as table_id,
    /* table details */
    creation_time as created_at,
    storage_last_modified_time,
    total_rows,
    total_partitions,
    total_logical_bytes,
    active_logical_bytes,
    long_term_logical_bytes,
    total_physical_bytes,
    active_physical_bytes,
    long_term_physical_bytes

from {{ info_schema_source('TABLE_STORAGE') }}