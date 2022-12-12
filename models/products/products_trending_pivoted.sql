{{ config(materialized="table") }}


with pivot_orders as (
    select 
        period
        , productid id
        , "orders" pivot_name
        , orders pivot_value
    from {{ref("products_trending")}} 
)

, pivot_revenue as (
    select 
        period
        , productid id
        , "revenue" pivot_name 
        , revenue pivot_value
    from {{ref("products_trending")}} 
)

, unioned as (
    select * 
    from pivot_orders
    union 
    select *
    from pivot_revenue
)

, final as (
    select
        u.period
        , u.id
        , u.pivot_name
        , u.pivot_value 
        , p.name
        , p.category
        , p.segment
    from 
        unioned u 
        join {{ref("source_products")}} p 
        on u.id = p.id
)

select * from final