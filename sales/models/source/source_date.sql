{{ config(materialized="table") }}

with cte as (
    select 
        date(date) date,
        year(date) year,
        monthname(date) month,
        day(date) day,
        quarter(date) quarter,
        week(date) week,
        dayofweek(date) day_of_week
    from {{source("sales", "sales")}}
    group by date
)

, final as (
    select * from cte
    order by date
)

select * from final