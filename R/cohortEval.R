#Load Cohort
cohort<-read.csv("/Users/Chan/OneDrive/OHDSI/MIMIC/data/cohort_ike_updated.csv")

head(cohort)
nrow(cohort)
##71684

cohort<-read.csv("/Users/Chan/OneDrive/OHDSI/MIMIC/data/cohort_ike_updated.csv")
library("dplyr")
#extract distinct cohort
cohort<-cohort %>% distinct (cohortId, subjectId, icuId, icuStartDate, icdEndDate, deathDate, cr1,cr2,cr3,cr4,cr5,cr6,cr7)

#NA proportion evaluation
NaProp<-c(sum(is.na(cohort$cr1)),sum(is.na(cohort$cr2)),sum(is.na(cohort$cr3)),sum(is.na(cohort$cr4)),sum(is.na(cohort$cr5)),sum(is.na(cohort$cr6)),sum(is.na(cohort$cr7)))/nrow(cohort)
plot(NaProp,type = "b", main  = "Proportion of Missing values in Cr", xlab = "days of creatinine measured",ylab = "Missing proportion")

exam<-cohort[cohort$icuId == 200001,c("cr1", "cr2","cr3","cr4","cr5","cr6","cr7")]
plot(as.numeric(exam),type = "b")

exam<-cohort[cohort$icuId == 200003,c("cr1", "cr2","cr3","cr4","cr5","cr6","cr7")]
plot(as.numeric(exam),type = "b")



hist(cohort$cr1,xlim=c(0,10),breaks = 50)
hist(cohort$cr2,xlim=c(0,10),breaks = 50,freq = TRUE)
hist(cohort$cr3,xlim=c(0,10),breaks = 50)
hist(cohort$cr4,xlim=c(0,10),breaks = 50)
hist(cohort$cr5,xlim=c(0,10),breaks = 50,freq = TRUE)

