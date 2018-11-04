select t1.icustay_id, t3.label as covariateId, 1 as covariateValue
from procedureevents_mv t1
join cohort t2 on t1.icustay_id=t2.icu_id and t1.subject_id=t2.subject_id
join d_items t3 on t1.itemid=t3.itemid
where t1.itemid in (
   221214, -- CT Scan
   225401, -- Blood culture
   225470 -- OR 
) and t1.starttime <=  (t2.icu_start_date + interval '48' hour)
group by t1.icustay_id, t3.label
