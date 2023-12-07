SELECT
    toStartOfMonth(toDate(event_time)) as month,
    uniq(uid) as MAU
FROM
    login
GROUP BY 
    month    

