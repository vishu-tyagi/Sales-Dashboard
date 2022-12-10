with cte as (
    select 
        ProductID productid,
        date(Date) date, 
        CustomerID customerid, 
        Units units
    from {{source("sales", "sales")}}
)

, final as (
    select * from cte
)

select * from final