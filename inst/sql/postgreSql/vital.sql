with uric_acid as
(
select
    ie.icustay_id
  , 'uric_acid' as covariate_id
  , le.valuenum as covariate_value
  from icustays ie
  left join labevents le
    on ie.subject_id = le.subject_id
    and le.ITEMID = 51007
    and le.VALUENUM is not null
    and le.CHARTTIME between (ie.intime - interval '6' hour) and (ie.intime + interval '48' hour)
  order by le.charttime
) 
select * from uric_acid limit 10;