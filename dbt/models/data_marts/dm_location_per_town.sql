{{
    config(
        materialized='table'
    )
}}

WITH data AS (
    SELECT
        p.town,
        CAST(AVG(CAST(RTRIM(SPLIT(p.location, " ")[2], ")") AS FLOAT64)) AS STRING) AS latitude,
        CAST(AVG(CAST(SPLIT(LTRIM(p.location, "POINT ("), " ")[0] AS FLOAT64)) AS STRING) AS longitude,
        AVG(s.sale_amount) AS avg_sale_amount
    FROM 
        {{ ref("fact_sales")}} AS s
        LEFT JOIN {{ ref("dim_properties") }} AS p 
        ON p.property_id = s.property_id 
    WHERE
        location IS NOT NULL
        AND sale_amount IS NOT NULL
    GROUP BY
        1
)   

SELECT
    town,
    CONCAT(latitude, ", ", longitude) AS location1,
    ST_GEOGFROMTEXT(CONCAT("POINT (", longitude, " ", latitude, ")")) AS location2,
    avg_sale_amount
FROM
    data
    