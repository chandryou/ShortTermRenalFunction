with ethnicity AS
(
  SELECT DISTINCT ON (1)
  t2.icu_id
  , 'ethnicity' as covariate_id
  , ad.ethnicity as covariate_value

  FROM admissions ad
  inner join cr7days_pivot t2
  ON ad.subject_id = t2.subject_id
  where ad.ethnicity is not null
)
select * from ethnicity;