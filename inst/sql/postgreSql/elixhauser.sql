with comorbidity as
(
    select t2.icu_id
    ,t.elixhauser_vanwalraven
    ,t.elixhauser_sid29
    ,t.elixhauser_sid30
    from elixhauser_ahrq_score t 
    inner join cr7days_pivot t2 on t.subject_id=t2.subject_id
    inner join icustays t3 on t2.icu_id=t3.icustay_id
)
select 
    icu_id
    , 'elixhauser_vanwalraven_avg' as covariate_id
    , avg(elixhauser_vanwalraven) as covariate_value
from comorbidity
group by icu_id
union all
select 
    icu_id
    , 'elixhauser_vanwalraven_min' as covariate_id
    , min(elixhauser_vanwalraven) as covariate_value
from comorbidity
group by icu_id
union all
select 
    icu_id
    , 'elixhauser_vanwalraven_max' as covariate_id
    , max(elixhauser_vanwalraven) as covariate_value
from comorbidity
group by icu_id

