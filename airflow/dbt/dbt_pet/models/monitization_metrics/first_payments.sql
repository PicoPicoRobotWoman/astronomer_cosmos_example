    
select
    uniq(uid)
from
    {{ ref('paing_uids_total') }}
where    
    {{ data_filter('first_event', var('start_date'), var('end_date')) }}

