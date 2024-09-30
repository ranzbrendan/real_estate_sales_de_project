{{
    config(
        materialized='table'
    )
}}

WITH data AS (
    SELECT
        *
    FROM
        {{ ref("stg_source_table") }} AS s
    LEFT JOIN
        {{ ref("dim_dates_recorded") }} AS d
        ON d.date = SAFE_CAST(s.date_recorded AS DATE)
    LEFT JOIN
        {{ ref("dim_properties") }} AS p 
        ON COALESCE(p.town, '') = COALESCE(s.town, '')
        AND COALESCE(p.address, '') = COALESCE(s.address, '')
        AND COALESCE(p.location, '') = COALESCE(s.location, '')
    LEFT JOIN 
        {{ ref("dim_remarks") }} AS r
        ON COALESCE(r.assessor_remark, '') = COALESCE(s.assessor_remarks, '')
        AND COALESCE(r.opm_remark, '') = COALESCE(s.opm_remarks, '')
)

SELECT
    sale_id,
    serial_number,
    list_year,
    date_id AS date_recorded_id,
    remark_id,
    property_id,
    assessed_value,
    sale_amount,
    sales_ratio,
    non_use_code
FROM
    data