select
    /* primary keys */
    table_catalog as project_id,
    table_schema as dataset_id,
    table_name as table_id,
    column_name,
    /* column details */
    ordinal_position,
    data_type,
    is_nullable = 'YES' as is_nullable,
    is_hidden = 'YES' as is_hidden,
    is_system_defined = 'YES' as is_system_defined,
    is_partitioning_column = 'YES' as is_partitioning_column,
    clustering_ordinal_position

from {{ info_schema_source('COLUMNS') }}