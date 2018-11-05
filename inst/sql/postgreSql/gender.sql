with gd as (
    select t2.icu_id 
    , 'gender' as covariate_id
    , t1.gender as covariate_value
    from patients t1 
    inner join cr7days_pivot t2
    on t1.subject_id=t2.subject_id
)
select * from gd;