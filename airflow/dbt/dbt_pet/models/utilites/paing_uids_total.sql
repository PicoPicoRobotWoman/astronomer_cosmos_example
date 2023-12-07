select
    uid,
    min(toDate(event_time)) AS first_event
from
    finance
where
    is_test !=1
group by 
    uid    