{% macro sum_revenue(duration) %}

select 
    sum(revenue_usd) as sum_revenue,
    toStartOf{{ duration }}(toDate(event_time)) as {{ duration }}
from    
    finance
Group by 
   {{ duration }}

{% endmacro %}