
with dau_sum as (
    select
        sum(DAU) as dau_total
    from 
        {{ ref('DAU') }}
    where
        {{ data_filter('date', var('start_date'), var('end_date')) }}
)

select
    (select dau_total from dau_sum) / sum(MAU)  as factor
from 
    {{ ref('MAU') }}
where
    {{ data_filter('month', var('start_date'), var('end_date')) }}
