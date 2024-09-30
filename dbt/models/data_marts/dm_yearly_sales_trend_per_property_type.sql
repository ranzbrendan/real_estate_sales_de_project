{{
    config(
        materialized='table'
    )
}}

SELECT
    p.property_type,
    d.year,
    d.month,
    AVG(s.list_year) AS list_year,
    AVG(s.sale_amount) AS avg_sale_amount,
    AVG(s.assessed_value) AS avg_assessed_value,
    (AVG(s.sale_amount) / NULLIF(AVG(s.assessed_value), 0)) AS avg_sales_ratio
FROM
    {{ ref("fact_sales") }} AS s
LEFT JOIN {{ ref("dim_properties") }} AS p
    ON p.property_id = s.property_id
LEFT JOIN {{ ref("dim_dates_recorded") }} AS d 
    ON d.date_id = s.date_recorded_id
GROUP BY
    1, 2, 3
ORDER BY
    1, 2, 3
