with agetbl AS
(
  SELECT ie.icustay_id as icu_id
  , 'age' as covariate_id
  , EXTRACT(EPOCH FROM (ie.intime - p.dob))/60.0/60.0/24.0/365.242 as covariate_value

  FROM icustays ie
  inner join cr7days_pivot t2
  on ie.icustay_id=t2.icu_id
  INNER JOIN patients p
  ON ie.subject_id = p.subject_id
)
select * from agetbl;