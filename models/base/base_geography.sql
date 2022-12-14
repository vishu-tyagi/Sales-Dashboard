with numbered as (
    select 
        zipcode zipcode,
        city city, 
        state state, 
        region region,
        district district,
        country country,
        row_number() over (
            partition by zipcode, city, state, region, district, country
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