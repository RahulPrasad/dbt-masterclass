{{
    config(
        materialized='table',
        database='dbt-masterclass',
        schema='materializations',
        alias='customers_table',
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
    insertion_timestamp
FROM {{ref('2_customers')}}
