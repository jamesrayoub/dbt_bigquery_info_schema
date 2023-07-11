{{ config(enabled=(var('capacity_compute_pricing_enabled', false))) }}

select
    /* primary keys */
    reservation_name,
    change_timestamp as changed_at,
    /* reservation change info */
    action,
    user_email,
    slot_capacity,
    autoscale,
    ignore_idle_slots,
    /* project info */
    project_id,
    project_number,

from {{ info_schema_source('RESERVATION_CHANGES') }}