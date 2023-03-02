select
    /* primary keys */
    table_catalog as project_id,
    table_schema as dataset_id,
    table_name as table_id,
    /* view details */
    view_definition,
    use_standard_sql = 'YES' as uses_standard_sql

from {{ info_schema_source('VIEWS') }}