--on_schema_change options are ignore, fail, append_new_columns, sync_all_columns
{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key='id',
        on_schema_change='ignore', 
        database='dbt-masterclass',
        schema='materializations',
        alias='customers_merge_on_schema_change',
        tags='materializations',
        partition_by={
            "field":"partition_timestamp",
            "data_type":"TIMESTAMP",
            "granularity":"DAY"
        }
    )
}}

SELECT
    id,
    company,
    last_name,
    first_name,
    email_address,
    job_title,
    partition_timestamp,
    CURRENT_TIMESTAMP() AS insertion_timestamp
FROM {{ source('dl_northwind','customer_new')}}
{% if is_incremental() %}
WHERE DATE(partition_timestamp) >= {{ get_max_partition() }}
{% endif %}

