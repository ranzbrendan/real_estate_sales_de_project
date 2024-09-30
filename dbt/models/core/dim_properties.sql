{{
    config(
        materialized='table'
    )
}}

WITH
    property_data AS (
        SELECT 
            ROW_NUMBER() OVER(PARTITION BY town, address, location) AS row_num,
            property_type,
            residential_type,
            town,
            address,
            location
        FROM 
            {{ ref("stg_source_table") }}
 )

SELECT
    -- identifier
    {{ dbt_utils.generate_surrogate_key(["town", "address", "location"]) }} AS property_id,
    CASE WHEN property_type IN ('Condo', 'Single Family', 'Two Family', 'Three Family', 'Four Family') THEN 'Residential'
        ELSE property_type END AS property_type,
    residential_type,
    town,
    address,
    location
FROM 
    property_data
WHERE
    row_num = 1