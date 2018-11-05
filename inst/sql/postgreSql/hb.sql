with uric_acid as
(
select
    ie.icustay_id as icu_id
  , 'hb' as covariate_id
  , avg(le.valuenum) as covariate_value
  from icustays ie
  left join labevents le
    on ie.subject_id = le.subject_id
    and le.ITEMID = 51222
    and le.VALUENUM is not null
    and le.CHARTTIME between (ie.intime - interval '6' hour) and (ie.intime + interval '48' hour)
  group by icu_id
) 
select t1.*
from uric_acid t1 
inner join cr7days_pivot t2
on t1.icu_id=t2.icu_id
where t1.covariate_value is not null;