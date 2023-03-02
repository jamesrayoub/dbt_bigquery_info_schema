{{ config(enabled=(var('flat_rate_pricing_enabled', false))) }}

select
    /* primary keys */
    capacity_commitment_id,
    change_timestamp as changed_at,
    /* capacity commitment change info */
    action,
    user_email,
    commitment_plan,
    renewal_plan,
    slot_count,
    state,
    failure_status,
    commitment_start_time as commitment_start_at,
    commitment_end_time as commitment_end_at,
    /* project info */
    project_id,
    project_number,

from {{ info_schema_source('CAPACITY_COMMITMENT_CHANGES') }}