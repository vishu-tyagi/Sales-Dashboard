with numbered as (
    select 
        manufacturerid id,
        manufacturer name,
        row_number() over(
            partition by manufacturerid, manufacturer
        ) rn 
    from {{source("sales", "sales")}}
)

, deduplicated as (
    select id, name 
    from numbered 
    where rn = 1
)

, final as (
    select * from deduplicated
)

select * from final