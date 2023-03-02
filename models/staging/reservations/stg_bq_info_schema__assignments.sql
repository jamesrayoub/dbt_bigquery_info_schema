{{ config(enabled=(var('flat_rate_pricing_enabled', false))) }}

select
    /* primary key */
    assignment_id,
    /* assignment info */
    job_type,
    reservation_name,
    ddl,
    assignee_id,
    assignee_number,
    assignee_type,
    /* project info */
    project_id,
    project_number,

from {{ info_schema_source('ASSIGNMENT_CHANGES') }}