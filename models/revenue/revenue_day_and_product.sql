{{ config(materialized="table") }}

with cte as (
    select
        t.date,
        t.productid,
        p.name,
        p.category,
        p.segment,
        t.units * p.unit_price revenue,
        t.units * p.unit_cost cost
    from 
        {{ref("source_transactions")}} t
        left join {{ref("source_products")}} p
        on t.productid = p.id 
        and t.date = p.date
)

, final as (
    select * from cte
)

select * from final
