
loadData <- function() {  

  data <- preProcess()
  data <- qc(data)
  data <- PredictorData(1,data)
  rownames(data) <- NULL # minor fix for the df, removing usless rownames
  data <- na.roughfix(data) 
  return(data)

}

preProcess <- function() {  
  cgmlst = read.csv(file = "big.csv")
  ## cleanning the file from unrelated data and gibrish
  cgmlst.stLabel =  cgmlst[, 5]
  cgmlst.data =  cgmlst[, 9:1869]
  cgmlst.data[cgmlst.data==0]<- NA
  cgmlst.data[1:1861] <- as.numeric(as.matrix(cgmlst.data[1:1861]))   
  return(cgmlst.data)
}



# removing samples with >= 15% missing values
qc <- function(df) {  
  ## removing bad samples
  row.counts <- rowSums(is.na(df))
  vecRemovee <- which(row.counts > 279)
  df <- df[-vecRemovee, ]
  return(df)
}

# for a spesific predictor, remove all samples without  a label.
PredictorData <- function(predictorColumnIndex,data) {
  #remove all samples with no label:
  completeVec <- complete.cases(data[, predictorColumnIndex])
  return (data[completeVec, ])
}
