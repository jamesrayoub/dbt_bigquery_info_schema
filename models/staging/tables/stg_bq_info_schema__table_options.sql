select
    /* primary keys */
    table_catalog as project_id,
    table_schema as dataset_id,
    table_name as table_id,
    option_name,
    /* options */
    option_type,
    option_value

from {{ info_schema_source('TABLE_OPTIONS') }}