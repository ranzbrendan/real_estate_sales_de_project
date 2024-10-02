{{
    config(
        materialized='table'
    )
}}

WITH loc AS (
    SELECT
        town,
        CAST(AVG(CAST(RTRIM(SPLIT(location, " ")[2], ")") AS FLOAT64)) AS STRING) AS latitude,
        CAST(AVG(CAST(SPLIT(LTRIM(location, "POINT ("), " ")[0] AS FLOAT64)) AS STRING) AS longitude
    FROM
        {{ ref("dim_properties") }}
    WHERE
        location IS NOT NULL
    GROUP BY
        town
),

sale AS (
    SELECT
        s.list_year,
        p.town,
        AVG(s.sale_amount) AS avg_sale_amount
    FROM 
        {{ ref("fact_sales")}} AS s
        LEFT JOIN {{ ref("dim_properties") }} AS p 
        ON p.property_id = s.property_id 
    WHERE
        sale_amount IS NOT NULL
    GROUP BY
        1, 2
)   

SELECT
    s.list_year,
    s.town,
    CONCAT(l.latitude, ", ", l.longitude) AS location1,
    ST_GEOGFROMTEXT(CONCAT("POINT (", l.longitude, " ", l.latitude, ")")) AS location2,
    s.avg_sale_amount
FROM
    sale AS s
    INNER JOIN loc AS l 
    ON l.town = s.town
ORDER BY
    1, 2
    