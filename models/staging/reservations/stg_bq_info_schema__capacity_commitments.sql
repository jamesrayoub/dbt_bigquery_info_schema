{{ config(enabled=(var('capacity_compute_pricing_enabled', false))) }}

select
    /* primary keys */
    capacity_commitment_id
    /* capacity commitment info */
    commitment_plan,
    slot_count,
    state,
    ddl,
    /* project info */
    project_id,
    project_number,

from {{ info_schema_source('CAPACITY_COMMITMENTS') }}