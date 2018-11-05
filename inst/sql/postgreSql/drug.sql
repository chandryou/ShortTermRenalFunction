select t1.icustay_id, t1.drug as covariateId, 1 as covariateValue
from prescriptions t1
join cohort t2 on t1.icustay_id=t2.icu_id and t1.subject_id=t2.subject_id
where t1.drug is not null and t1.startdate <=  (t2.icu_start_date + interval '48' hour)