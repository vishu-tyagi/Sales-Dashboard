{{ config(materialized="table") }}

with ranked as (
    select 
        ZipCode zipcode,
        City city, 
        State state, 
        Region region,
        District district,
        Country country,
        rank() over (
            partition by ZipCode, City, State, Region, District, Country
            order by date desc
        ) rnk
    from {{source("sales", "sales")}}
)

, deduplicated as (
    select zipcode, city, state, region, district, country
    from ranked 
    where rnk = 1
    order by zipcode
)

, final as (
    select * from deduplicated
)

select * from final