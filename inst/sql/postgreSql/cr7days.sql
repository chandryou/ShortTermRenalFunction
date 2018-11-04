
with cr as
(
select
    ie.icustay_id
, ie.subject_id
, ie.intime, ie.outtime
, le.valuenum as creat
, le.charttime

from icustays ie
left join labevents le
    on ie.subject_id = le.subject_id
    and le.ITEMID = 50912
    and le.VALUENUM is not null
    and le.CHARTTIME between (ie.intime - interval '6' hour) and (ie.intime + interval '7' day)
), cr7days as 
(
    select icustay_id
        , subject_id
        , avg(creat) as creat
        , date(charttime) as charttime
        , ROW_NUMBER ()
        OVER (PARTITION BY icustay_id
            ORDER BY date(charttime)
            ) as rn
    from cr 
    group by icustay_id, subject_id, date(charttime)
)
select * from cr7days;
