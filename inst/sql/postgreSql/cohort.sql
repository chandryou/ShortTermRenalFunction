create table cohort as 
with death as
(
    select distinct subject_id, date(deathtime) as death_date 
    from admissions
    where deathtime is not null
)
select 1 as cohort_id, t2.subject_id, t1.icu_id, date(t2.intime) as icu_start_date, date(t2.outtime) as icu_end_date, 
    t3.death_date,
    t1.cr1, t1.cr2, t1.cr3, t1.cr4, t1.cr5, t1.cr6,t1.cr7, t1.cr8, t1.cr9
from cr7days_pivot t1 
left join kdigo_stages_48hr t4 on t1.icu_id=t4.icustay_id
left join icustays t2 on t1.icu_id=t2.icustay_id and t1.subject_id=t2.subject_id
left join death t3 on t1.subject_id=t3.subject_id;

create table cohort_2 as 
with death as
(
    select distinct subject_id, date(deathtime) as death_date 
    from admissions
    where deathtime is not null
)
select 1 as cohort_id, t2.subject_id, t1.icu_id, date(t2.intime) as icu_start_date, date(t2.outtime) as icu_end_date, 
    t3.death_date,
    t1.cr1, t1.cr2, t1.cr3, t1.cr4, t1.cr5, t1.cr6,t1.cr7, t1.cr8, t1.cr9
from cr7days_pivot t1 
left join kdigo_stages_48hr t4 on t1.icu_id=t4.icustay_id
left join icustays t2 on t1.icu_id=t2.icustay_id and t1.subject_id=t2.subject_id
left join death t3 on t1.subject_id=t3.subject_id
where t4.aki_stage_48hr >= 2;

create table cohort_1 as 
with death as
(
    select distinct subject_id, date(deathtime) as death_date 
    from admissions
    where deathtime is not null
)
select 1 as cohort_id, t2.subject_id, t1.icu_id, date(t2.intime) as icu_start_date, date(t2.outtime) as icu_end_date, 
    t3.death_date,
    t1.cr1, t1.cr2, t1.cr3, t1.cr4, t1.cr5, t1.cr6,t1.cr7, t1.cr8, t1.cr9
from cr7days_pivot t1 
left join kdigo_stages_48hr t4 on t1.icu_id=t4.icustay_id
left join icustays t2 on t1.icu_id=t2.icustay_id and t1.subject_id=t2.subject_id
left join death t3 on t1.subject_id=t3.subject_id
where t4.aki_stage_48hr = 1;