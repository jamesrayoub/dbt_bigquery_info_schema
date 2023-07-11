select
	/* primary key */
	job_id,
	/* timestamps */
    creation_time as created_at,
    start_time as started_at,
    end_time as ended_at,
    /* foreign keys */
    parent_job_id,
    reservation_id,
    transaction_id,
    /* job details */
    state as job_state,
    user_email,
    job_type,
    statement_type,
    priority,
    cache_hit as is_cache_hit,
    query,
    project_id,
    project_number,
    destination_table,
    dml_statistics,
    error_result,
	/* records */
    labels,
    referenced_tables,
    job_stages,
    timeline,
	/* quantitative values */
    total_slot_ms,
    total_bytes_billed,
    total_bytes_processed,
    transferred_bytes as total_bytes_transferred,
    total_modified_partitions as total_partitions_modified,
  
from {{ info_schema_source('JOBS') }}