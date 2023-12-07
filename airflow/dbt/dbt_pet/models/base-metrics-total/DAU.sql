SELECT
    toDate(event_time) as date,
    uniq(uid) as DAU
FROM
    login
GROUP BY
    date


