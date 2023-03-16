select
    /* primary keys */
    table_catalog as project_id,
    table_schema as dataset_id,
    table_name as table_id,
    /* table details */
    creation_time as created_at,
    table_type,
    is_insertable_into = 'YES' as is_insertable_into,
    ddl,

from {{ info_schema_source('TABLES') }}