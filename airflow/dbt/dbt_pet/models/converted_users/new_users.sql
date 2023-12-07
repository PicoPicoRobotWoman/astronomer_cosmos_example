select
    min(toDate(event_time)) AS first_login_date,
    uid
from
    login
where
    {{ data_filter('event_time', var('start_date'), var('end_date')) }}    
group by
    uid