{{
    config(
        materialized='incremental',
        incremental_strategy='insert_overwrite',
        database='dbt-masterclass',
        schema='materializations',
        alias='customers_insert_overwrite',
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
WHERE DATE(partition_timestamp) >= DATE(_dbt_max_partition)
{% endif %}
