{{ config(materialized="table") }}

with cte as (
    select
        max(date) date,
        sum(revenue) revenue,
        sum(cost) cost
    from {{ref("revenue_day_and_product")}}
    group by left(date, 7) 
)

, rolling as (
    select 
        date,
        sum(revenue) over (order by date rows between unbounded preceding and 0 following) rolling_revenue,
        sum(cost) over (order by date rows between unbounded preceding and 0 following) rolling_cost
    from cte
)

, final as (
    select 
        *,
        (rolling_revenue - rolling_cost) rolling_margin
    from rolling
)

select * from final
