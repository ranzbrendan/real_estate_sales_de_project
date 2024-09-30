{{ config(materialized="table") }}

WITH
    date_data AS (
        SELECT DISTINCT SAFE_CAST(date_recorded AS DATE) AS date
        FROM {{ ref("stg_source_table") }}
        ORDER BY date ASC
 )

SELECT
    -- identifier
    {{ dbt_utils.generate_surrogate_key(["date"]) }} AS date_id,
    SAFE_CAST(date AS DATE) AS date,
    EXTRACT(year FROM SAFE_CAST(date AS DATE)) AS year,
    EXTRACT(month FROM SAFE_CAST(date AS DATE)) AS month,
    EXTRACT(day FROM SAFE_CAST(date AS DATE)) AS day
FROM date_data
