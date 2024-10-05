{{
    config(
        materialized='view'
    )
}}

with source as (
    select * from {{ source('staging', 'source_table') }}
),

renamed as (
    select
        sale_id,
        serial_number,
        list_year,
        SAFE_CAST(date_recorded AS DATE) AS date_recorded,
        town,
        address,
        assessed_value,
        sale_amount,
        sales_ratio,
        property_type,
        residential_type,
        non_use_code,
        assessor_remarks,
        opm_remarks,
        location
    from source
)

select * from renamed
