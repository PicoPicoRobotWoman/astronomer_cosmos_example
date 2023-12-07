select
    toStartOfWeek(toDate(event_time)) as week,
    uniq(uid) as WAU
from
    login
group by
    week