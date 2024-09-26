e{{ config(materialized="view") }}

with
    date_data as (
        select distinct safe_cast(date_recorded as date) as date
        from {{ ref("stg_source_table") }}
        order by date asc
 )

select
    -- identifier
    {{ dbt_utils.generate_surrogate_key(["date"]) }} as date_id,
    safe_cast(date) as date,
    extract(year from date) as year,
    extract(month from date) as month,
    extract(day from date) as day
from date_data
