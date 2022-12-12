with cte as (
    select 
        productid
        , date(Date) date
        , customerid
        , units units
        , `Unit Cost` unit_cost
        , `Unit Price` unit_price 
        , manufacturerid
    from {{source("sales", "sales")}}
)

, final as (
    select * from cte
)

select * from final