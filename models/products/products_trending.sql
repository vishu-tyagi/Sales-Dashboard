with trend_period as (
    select left(date, 7) month
    from {{ref("base_date")}}
    group by left(date, 7)
    order by month desc 
    limit 2
)

, current as (
    select * from trend_period order by month desc limit 1 
)

, sales as (
    select 
        left(date, 7) month
        , productid
        , sum(units) orders
        , sum(units * unit_price) revenue
    from {{ref("base_transactions")}}
    where left(date, 7) in (select * from trend_period)
    group by left(date, 7), productid
)

, trending_products as (
    select productid
    from sales s
    where month = (select * from current)
    order by orders desc 
    limit 10
)

, final as (
    select
        (case 
            when month = (select * from current) then "current"
            else "previous"
        end) period,
    productid, orders, revenue
    from sales
    where productid in (select * from trending_products)
)

select * from final