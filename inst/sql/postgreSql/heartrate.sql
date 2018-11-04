with vital as
(
select
    ie.icustay_id as icu_id
  , 'heartrate' as covariate_id
  , avg(le.valuenum) as covariate_value
  from icustays ie
  left join chartevents le
    on ie.subject_id = le.subject_id
    and le.ITEMID in (220045)
    and le.VALUENUM is not null
    and le.CHARTTIME between (ie.intime - interval '6' hour) and (ie.intime + interval '48' hour)
  group by icu_id
) 
select t1.*
from vital t1 
inner join cr7days_pivot t2
on t1.icu_id=t2.icu_id
where t1.covariate_value is not null;
