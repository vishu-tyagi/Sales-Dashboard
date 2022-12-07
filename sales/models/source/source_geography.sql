{{ config(materialized="table") }}

with ranked as (
    select 
        Category category,
        Segment segment,
        rank() over (
            partition by Category, Segment
        ) rnk
    from {{source("sales", "sales")}}
)

, deduplicated as (
    select category, segment
    from ranked 
    where rnk = 1
    order by category, segment
)

, final as (
    select * from deduplicated
)

select * from final