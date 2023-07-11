{{ config(enabled=(var('capacity_compute_pricing_enabled', false))) }}

select
    /* primary key */
    assignment_id,
    change_timestamp as changed_at,
    /* assignment change info */
    action,
    user_email,
    job_type,
    reservation_name,
    state,
    assignee_id,
    assignee_number,
    assignee_type,
    /* project info */
    project_id,
    project_number,

from {{ info_schema_source('ASSIGNMENT_CHANGES') }}