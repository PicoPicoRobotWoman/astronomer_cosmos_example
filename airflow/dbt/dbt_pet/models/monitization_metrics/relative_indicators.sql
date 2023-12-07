select 
    (select sum(sum_revenue) from ( {{ sum_revenue('Day') }} ) where {{ data_filter('Day', var('start_date'), var('end_date')) }}) 
    / 
    (select uniq(uid) from finance where {{ data_filter('event_time', var('start_date'), var('end_date')) }} ) as ARPPU,
    (select uniq(uid) from finance where {{ data_filter('event_time', var('start_date'), var('end_date')) }}) 
    /
    (select sum(DAU) from {{ ref('DAU') }} where {{ data_filter('date', var('start_date'), var('end_date')) }} )  as Paying_Share,
    (select sum(sum_revenue) from ( {{ sum_revenue('Day') }} ) where {{ data_filter('Day', var('start_date'), var('end_date')) }})
    /
    (select uniq(uid) from login where {{ data_filter('event_time', var('start_date'), var('end_date')) }}) as ARPDAU
