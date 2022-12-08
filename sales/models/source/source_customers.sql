with numbered as (
    select 
        CustomerID id,
        `Email Name` email,
        ZipCode zipcode,
        row_number() over (partition by CustomerID order by date desc) rn
    from {{source("sales", "sales")}}
)

, deduplicated as (
    select 
        id,
        substring_index(substring_index(substring_index(email, ":", 1), "(", -1), ")", 1) email,
        substring_index(substring_index(email, ": ", -1), ",", 1) first_name,
        substring_index(substring_index(email, ":", -1), ", ", -1) second_name,
        zipcode
    from numbered
    where rn = 1
    order by id
)

, final as (
    select * from deduplicated
)

select * from final