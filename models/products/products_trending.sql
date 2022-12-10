with period as (
    select left(date, 7) month
    from {{ref("source_date")}}
    group by left(date, 7)
    order by month desc 
    limit 2
)

, current as (
    select * from period order by month desc limit 1 
)

, previous as (
    select * from period order by month limit 1
)

, current_sales as (
    select 
        t.productid
        , sum(t.units) orders
        , sum(t.units * p.unit_price) revenue
        , max(p.name) name
        , max(p.category) category
        , max(p.segment) segment
    from 
        {{ref("source_transactions")}} t
        join {{ref("source_products")}} p
        on t.date = p.date and t.productid = p.id
    where left(t.date, 7) in (select * from current)
    group by t.productid
)

, previous_sales as (
    select 
        t.productid
        , sum(t.units) orders
        , sum(t.units * p.unit_price) revenue
        , max(p.name) name
        , max(p.category) category
        , max(p.segment) segment
    from 
        {{ref("source_transactions")}} t
        join {{ref("source_products")}} p
        on t.date = p.date and t.productid = p.id
    where left(t.date, 7) in (select * from previous)
    group by t.productid
)

, final as (
    select 
        c.productid
        , c.orders orders
        , (c.orders - p.orders) diff_orders
        , c.revenue revenue
        , (c.revenue - p.revenue) diff_revenue
        , c.name
        , c.category
        , c.segment
    from 
        current_sales c 
        join previous_sales p 
        on c.productid = p.productid
    order by orders desc 
    limit 10
)

select * from final