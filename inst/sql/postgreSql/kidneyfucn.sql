select 
icustay_id as icu_id
, aki_48hr 
, lowcreat48hr 
, highcreat48hr 
, lowcreat48hrtimeelapsed 
, highcreat48hrtimeelapsed 
, uo6_48hr 
, uo12_48hr 
, uo24_48hr 
from kdigo_stages_48hr
where AKI_48hr = 1;