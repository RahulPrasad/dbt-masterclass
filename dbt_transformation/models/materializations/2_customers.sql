{{
    config(
        materialized='ephemeral',
        database='dbt-masterclass',
        schema='materializations',
        alias='customers_ephemeral',
        tags='materializations'
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
