select 
    uniqIf(uid, uid in (select uid from {{ ref('paing_uids_total') }})) as uniq
from 
    {{ ref('new_users') }}