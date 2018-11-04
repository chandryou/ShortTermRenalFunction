with cr as
(
select
    ie.icustay_id
  , ie.intime, ie.outtime
  , le.valuenum as creat
  , le.charttime
  from icustays ie
  left join labevents le
    on ie.subject_id = le.subject_id
    and le.ITEMID = 50912
    and le.VALUENUM is not null
    and le.CHARTTIME between (ie.intime - interval '6' hour) and (ie.intime + interval '7' day)
)
, cr_3day as
(
select
    cr.icustay_id
  , cr.creat
  , cr.charttime
  -- Create an index that goes from 1, 2, ..., N
  -- The index represents how early in the patient's stay a creatinine value was measured
  -- Consequently, when we later select index == 1, we only select the first (admission) creatinine
  -- In addition, we only select the first stay for the given subject_id
--   , ROW_NUMBER ()
--           OVER (PARTITION BY cr.icustay_id
--                 ORDER BY cr.charttime
--               ) as rn
  from cr
  -- limit to the first 72 hours (source table has data up to 7 days)
  where cr.charttime <= cr.intime + interval '72' hour 
)
select icustay_id, creat, date(charttime)
from cr_3day 
limit 20;

group by icustay_id, date(charttime) limit 20;


and cr.charttime >= cr.intime + interval '48' hour