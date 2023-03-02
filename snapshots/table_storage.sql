{% snapshot orders_snapshot_timestamp %}

    {{
        config(
          target_schema='snapshots',
          strategy='timestamp',
          unique_key='table_name',
          updated_at='storage_last_modified_time'
        )
    }}

    select * from {{ info_schema_source('TABLE_STORAGE') }}

{% endsnapshot %}