{{ config(materialized='table') }}

with source_data as (

    select * from   DBT_ANALYTICS.DBT_TRANSFORMATIONS.GA_SESSIONS

)

select *
from source_data