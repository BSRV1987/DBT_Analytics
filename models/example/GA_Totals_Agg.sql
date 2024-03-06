
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with source_data as (

SELECT   date,
    SUM(TOTALS:bounces::INT) AS bounces,
    SUM(TOTALS:hits::INT) AS hits,
    SUM(TOTALS:newVisits::INT) AS newVisits,
    SUM(TOTALS:pageviews::INT) AS pageviews,
    SUM(TOTALS:screenviews::INT) AS screenviews,
    SUM(TOTALS:sessionQualityDim::INT) AS sessionQualityDim,
    SUM(TOTALS:timeOnScreen::INT) AS timeOnScreen,
    SUM(TOTALS:timeOnSite::INT) AS timeOnSite,
    SUM(TOTALS:totalTransactionRevenue::INT) AS totalTransactionRevenue,
    SUM(TOTALS:transactionRevenue::INT) AS transactionRevenue,
    SUM(TOTALS:transactions::INT) AS transactions,
    SUM(TOTALS:uniqueScreenviews::INT) AS uniqueScreenviews,
    SUM(TOTALS:visits::INT) AS visits
FROM
  DBT_ANALYTICS.DBT_TRANSFORMATIONS.GA_SESSIONS
  group by date

)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
