with numbered as (
    select 
        productid id
        , product name
        , category category
        , segment segment
        , row_number() over (
            partition by  
                productid, 
                product,
                category,
                segment
        ) rn
    from {{source("sales", "sales")}}
)

, deduplicated as (
    select 
        id
        , name
        , category 
        , segment
    from numbered
    where rn = 1
    order by id
)

, final as (
    select * from deduplicated
)

select * from final