
{% macro data_filter(date, start_date, end_date) %}

    toDate({{ date }}) between '{{ start_date }}' and '{{ end_date }}'

{% endmacro %}
