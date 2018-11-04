# @file formatting.R
#
# Copyright 2018 Observational Health Data Sciences and Informatics
#
# This file is part of PatientLevelPrediction
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#' Convert the plpData in COO format into a sparse R matrix
#'
#' @description
#' Converts the standard plpData to a sparse matrix
#'
#' @details
#' This function converts the covariate file from ffdf in COO format into a sparse matrix from
#' the package Matrix
#' @param plpData                       An object of type \code{plpData} with covariate in coo format - the patient level prediction
#'                                      data extracted from the CDM.
#' @param population                    The population to include in the matrix
#' @param map                           A covariate map (telling us the column number for covariates)
#' @param temporal                      Whether you want to convert temporal data
#' @examples
#' #TODO
#'
#' @return
#' Returns a list, containing the data as a sparse matrix, the plpData covariateRef
#' and a data.frame named map that tells us what covariate corresponds to each column
#' This object is a list with the following components: \describe{
#' \item{data}{A sparse matrix with the rows corresponding to each person in the plpData and the columns corresponding to the covariates.}
#' \item{covariateRef}{The plpData covariateRef.}
#' \item{map}{A data.frame containing the data column ids and the corresponding covariateId from covariateRef.}
#' }
#'
#' @export
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
