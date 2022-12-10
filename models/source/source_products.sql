with numbered as (
    select 
        ProductID id,
        Product name,
        Category category,
        Segment segment,
        ManufacturerID manufacturerid,
        Manufacturer manufacturer,
        `Unit Cost` unit_cost,
        `Unit Price` unit_price,
        row_number() over (
            partition by ProductID, Product, Category, Segment, `Unit Cost`, `Unit Price`
            order by date desc
        ) rn
    from {{source("sales", "sales")}}
)

, deduplicated as (
    select id, name, category, segment, manufacturerid, manufacturer, unit_cost, unit_price
    from numbered
    where rn = 1
    order by id
)

, final as (
    select * from deduplicated
)

select * from final