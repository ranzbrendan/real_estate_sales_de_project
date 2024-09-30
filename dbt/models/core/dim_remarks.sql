 {{
    config(
        materialized='table'
    )
}}

WITH remarks_data AS (
    SELECT
        assessor_remarks,
        opm_remarks
    FROM
        {{ ref("stg_source_table") }}
    GROUP BY
        assessor_remarks,
        opm_remarks
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['assessor_remarks', 'opm_remarks']) }} AS remark_id,
    assessor_remarks AS assessor_remark,
    opm_remarks AS opm_remark
FROM
    remarks_data