{{
    config(
        materialized='table'
    )
}}

WITH ratio AS (
    SELECT
        SUM(sale_amount) / SUM(assessed_value) AS avg_sales_ratio
    FROM
        {{ ref("fact_sales") }}
    WHERE 
        sale_amount >= 2000
        AND sale_amount IS NOT NULL
        AND assessed_value IS NOT NULL
),

sale AS (
    SELECT
    SUM(sale_amount) AS total_volume,
    COUNT(1) AS number_of_sales,
    AVG(sale_amount) AS avg_sale_amount,
    APPROX_QUANTILES(sale_amount, 100)[OFFSET(50)] AS median_sale_amount
FROM
    {{ ref("fact_sales") }}
WHERE
    sale_amount >= 2000
    AND sale_amount IS NOT NULL
)

SELECT
    sale.total_volume,
    sale.number_of_sales,
    sale.avg_sale_amount,
    sale.median_sale_amount,
    ratio.avg_sales_ratio
FROM
    sale
JOIN ratio
    ON 1 = 1


