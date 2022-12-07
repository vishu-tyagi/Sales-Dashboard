{{ config(materialized="table") }}

with ranked as (
    select 
        ProductID id,
        Product name,
        Category category,
        Segment segment,
        `Unit Cost` unit_cost,
        `Unit Price` unit_price,
        rank() over (
            partition by 
                ProductID, Product, Category, Segment, `Unit Cost`, `Unit Price`
            order by date desc
        ) rnk
    from 
        {{source("sales", "sales")}}
)

, deduplicated as (
    select id, name, category, segment, unit_cost, unit_price
    from ranked
    where rnk = 1
    order by id
)

, final as (
    select * from deduplicated
)

select * from final