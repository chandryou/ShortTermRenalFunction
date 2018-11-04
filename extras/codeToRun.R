#Load Cohort
cohort<-read.csv("/Users/Chan/OneDrive/OHDSI/MIMIC/data/cohort_ike_updated.csv")
#Load Covariate
covariateRenal<-read.csv("/Users/Chan/OneDrive/OHDSI/MIMIC/data/cov_kidneyfunc.csv")
covariateUric<-read.csv("/Users/Chan/OneDrive/OHDSI/MIMIC/data/co_uric_acid.csv")
#covariateElix<-read.csv("/Users/Chan/OneDrive/OHDSI/MIMIC/data/elixhauser_ahrq_score.csv")

colnames(covariateRenal)<-c("icuId", "covariateId","covariateValue")
colnames(covariateUric)<-c("icuId", "covariateId","covariateValue")

covariates<-rbind(covariateRenal,covariateUric)
colnames(covariates)<-c("icuId", "covariateId","covariateValue")

toMatrix <- function(covariates, normalize = TRUE){
    covariates$icuId.factor<-as.factor(covariates$icuId)
    covariates$covariateId.factor<-as.factor(covariates$covariateId)
    #Configuring covariate
    sparseM<-Matrix::sparseMatrix(i = as.numeric(covariates$icuId.factor),
                                  j = as.numeric(covariates$covariateId.factor),
                                  x = covariates$covariateValue
    )
    dataM<-apply(sparseM, 2, function (x){
        min = min(x, na.rm = TRUE)
        max = max(x, na.rm = TRUE)
        diff = max-min
        if (diff ==0) diff = 1
        return ( (x-min)/diff  )
    } )

    list(dataM = dataM,
         icuId.factor = covariates$icuId.factor)

    return(    list(dataM = dataM,
                    icuId.factor = covariates$icuId.factor,
                    covariateId.factor = covariates$covariateId.factor))
}




covariateList<-toMatrix(covariates)

icuId.factor<-covariateList$icuId.factor
covariateId.factor<-covariateList$covariateId.factor

covariateMatrix <- covariateList$sparseM
as.matrix(covariateMatrix)


