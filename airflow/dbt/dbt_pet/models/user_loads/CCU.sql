select
    {{ var('ccu_duration_function') }}(event_time) as time,
    uniq(uid) as CCU
from
    login
where
    {{ data_filter('event_time', var('start_date'), var('end_date')) }}
group by
    time
