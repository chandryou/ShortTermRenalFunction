#!/bin/bash

export PGPASSWORD=mimic
# Genereate cohort
# ref: https://github.com/MIT-LCP/mimic-code/blob/master/concepts/organfailure/kdigo-creatinine.sql

# psql -h 127.0.0.1 -p 5555 -U postgres -d mimic -t -A -F"," -f cr7days.sql > cr7days.csv
# python db.py
# psql -h 127.0.0.1 -p 5555 -U postgres -d mimic -c  "copy cr7days_pivot from STDIN with delimiter as ',';" < crydays_pivot.csv

# all AKI cohort
psql -h 127.0.0.1 -p 5555 -U postgres -d mimic -t -A -F"," -c "select * from cohort" > cohort.csv
sed -i '1icohortId,subjectId,icuId,icuStartDate,icuEndDate,deathDate,cr1,cr2,cr3,cr4,cr5,cr6,cr7,cr8,cr9' cohort.csv
# AKI stage = 1 cohort
psql -h 127.0.0.1 -p 5555 -U postgres -d mimic -t -A -F"," -c "select * from cohort_1" > cohort_1.csv
sed -i '1icohortId,subjectId,icuId,icuStartDate,icuEndDate,deathDate,cr1,cr2,cr3,cr4,cr5,cr6,cr7,cr8,cr9' cohort_1.csv
# AKI stage >= 2 cohort
psql -h 127.0.0.1 -p 5555 -U postgres -d mimic -t -A -F"," -c "select * from cohort_2" > cohort_2.csv
sed -i '1icohortId,subjectId,icuId,icuStartDate,icuEndDate,deathDate,cr1,cr2,cr3,cr4,cr5,cr6,cr7,cr8,cr9' cohort_2.csv

# extract covariates
covariates=(
    "uric_acid" 
    "sodium"
    "protein"
    "potassium"
    "chloride"
    "co2"
    "lactate"
    "glucose"
    "wbc"
    "hb"
    "lymphocyte"
    "platelet"
    "age"
    "ethnicity"
    "gender"
    "rr"
    "heartrate"
    "height"
    "weight"
    "oxygensaturation"
    "sbp"
    "dbp"
    "temperature"
    "elixhauser"
    "drug"

)

for cov in "${covariates[@]}"
do
   echo "$cov"
   psql -h 127.0.0.1 -p 5555 -U postgres -d mimic -t -A -F"," -f "${cov}.sql" > "co_${cov}.csv"
   sed -i '1iicuId,covariateId,covariateValue' "co_${cov}.csv"
done
