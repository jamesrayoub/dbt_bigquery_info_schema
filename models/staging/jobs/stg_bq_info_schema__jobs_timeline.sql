select
    /* primary keys */
    job_id,
    period_start as period_started_at,
    /* timestamps */
    job_creation_time as job_created_at,
    job_start_time as job_started_at,
    job_end_time as job_ended_at,
    /* foreign keys */ 
    reservation_id,
    /* job details */
    state as job_state,
    user_email,
    job_type,
    statement_type,
    cache_hit as is_cache_hit,
    project_id,
    project_number,
    error_result,
    /* period details */
    period_shuffle_ram_usage_ratio,
    period_estimated_runnable_units,
    /* quantitative values */
    period_slot_ms,
    total_bytes_processed,

from {{ info_schema_source('JOBS_TIMELINE') }}