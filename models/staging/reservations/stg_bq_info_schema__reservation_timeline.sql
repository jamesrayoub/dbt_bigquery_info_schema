{{ config(enabled=(var('flat_rate_pricing_enabled', false))) }}

select
    /* primary keys */
    reservation_name,
    period_start,
    /* reservation info */
    slots_assigned,
    slots_max_assigned,
    ignore_idle_slots,
    reservation_id,
    /* project info */
    project_id,
    project_number,

from {{ info_schema_source('RESERVATION_TIMELINE') }}