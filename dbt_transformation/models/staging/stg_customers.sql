SELECT
    id AS customer_id,
    company AS company_name,
    last_name,
    first_name,
    email_address,
    job_title
FROM {{ source('dl_northwind','customer')}}
