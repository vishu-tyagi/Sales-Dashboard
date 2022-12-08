with numbered as (
    select 
        ZipCode zipcode,
        City city, 
        State state, 
        Region region,
        District district,
        Country country,
        row_number() over (
            partition by ZipCode, City, State, Region, District, Country
            order by date desc
        ) rn
    from {{source("sales", "sales")}}
)

, deduplicated as (
    select zipcode, city, state, region, district, country
    from numbered 
    where rn = 1
    order by zipcode
)

, final as (
    select * from deduplicated
)

select * from final