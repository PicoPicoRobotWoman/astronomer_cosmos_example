
{% set durations = ['Day', 'Week', 'Month'] %}

select 
{% for dur in durations %}
    {{ max_revenue(dur) }}
    {% if not loop.last %},{% endif %}
{% endfor %}
  