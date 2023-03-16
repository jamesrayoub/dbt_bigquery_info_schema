{{ config(enabled=(var('flat_rate_pricing_enabled', false))) }}

select
    /* primary key */
    reservation_name,
    /* reservation info */
    slot_capacity,
    autoscale,
    ddl,
    ignore_idle_slots,
    /* project info */
    project_id,
    project_number,

from {{ info_schema_source('RESERVATIONS') }}