{{
    config(
        materialized='table'
    )
}}

SELECT
    COALESCE(p.property_type, "Unknown") AS property_type,
    s.list_year,
    AVG(s.sale_amount) AS avg_sale_amount,
    AVG(s.assessed_value) AS avg_assessed_value,
    APPROX_QUANTILES(s.sale_amount, 100)[OFFSET(50)] AS median_sale_amount,
    APPROX_QUANTILES(s.assessed_value, 100)[OFFSET(50)] AS median_assessed_value
FROM
    {{ ref("fact_sales") }} AS s
LEFT JOIN {{ ref("dim_properties") }} AS p
    ON p.property_id = s.property_id
LEFT JOIN {{ ref("dim_dates_recorded") }} AS d 
    ON d.date_id = s.date_recorded_id
WHERE
    s.sale_amount IS NOT NULL
    AND s.sale_amount >= 2000
GROUP BY
    1, 2
ORDER BY
    1, 2
