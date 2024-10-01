{{
    config(
        materialized='table'
    )
}}

SELECT
    s.serial_number,
    s.list_year,
    COALESCE(p.property_type, "Unknown") AS property_type,
    p.residential_type,
    p.town,
    p.address,
    CONCAT( RTRIM(SPLIT(p.location, " ")[2], ")") , "," , SPLIT(LTRIM(p.location, "POINT ("), " ")[0] ) AS location1,
    ST_GEOGFROMTEXT(p.location) AS location2,
    s.sale_amount
FROM 
    {{ ref("fact_sales")}} AS s
    LEFT JOIN {{ ref("dim_properties") }} AS p 
    ON p.property_id = s.property_id 
WHERE
    location IS NOT NULL