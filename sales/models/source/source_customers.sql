{{ config(materialized="table") }}

with ranked as (
    select 
        CustomerID id,
        `Email Name` email,
        ZipCode zipcode,
        rank() over (partition by CustomerID order by date desc) rnk
    from {{source("sales", "sales")}}
)

, deduplicated as (
    select 
        id,
        substring_index(substring_index(substring_index(email, ":", 1), "(", -1), ")", 1) email,
        substring_index(substring_index(email, ": ", -1), ",", 1) first_name,
        substring_index(substring_index(email, ":", -1), ", ", -1) second_name,
        zipcode
    from ranked
    where rnk = 1
    order by id
)

, final as (
    select * from deduplicated
)

select * from final