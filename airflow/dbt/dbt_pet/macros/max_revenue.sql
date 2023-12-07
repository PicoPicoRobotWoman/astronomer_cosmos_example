{% macro max_revenue(duration) %}

    (select top 1 
        {{ duration }}
    from 
        ( {{ sum_revenue(duration) }} )
     where 
        {{ data_filter( duration , var('start_date') , var('end_date') ) }}
    order by 
        sum_revenue desc) as {{ duration }}

{% endmacro %}