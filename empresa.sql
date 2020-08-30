 with quiz_funnel as(
  select question,
         count(distinct user_id) as responses
  from survey
  group by 1
  order by 2 desc
)
select * from quiz_funnel;

with funnel as (
  select distinct q.user_id as 'quiz',
       h.user_id is not null as 'is_home_try_on',
       h.number_of_pairs,
       p.user_id is not null as 'is_purchase'
from quiz as q
left join home_try_on as h
  on q.user_id = h.user_id
left join purchase as p
  on p.user_id = q.user_id
)
select count(quiz) as 'quiz_num',
       sum(is_home_try_on) as 'home_try_on_num',
       sum(is_purchase) as 'purchase_num'
from funnel;

select num_pairs, round(1.0 * sum(is_purchase)/sum(is_home_try_on),2) as purchase_rate
from funnel where num_pairs is '3 pairs' or num_pairs is '5 pairs' group by num_pairs;

select style,
 count(user_id) as responses
from quiz 
group by 1 order by 2 desc;

select style,
 count(*) as purchases 
from purchase 
group by 1 order by 2 desc;

