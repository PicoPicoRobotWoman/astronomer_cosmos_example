select top 1
    time,
    MAX(CCU) over (order by time) as PCU
from
    {{ ref('CCU')}}
order by
    PCU DESC