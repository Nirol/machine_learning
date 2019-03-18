
library(gdata)   # load gdata package 
library(randomForest)
library(gplots)
require(ggplot2); require(gridExtra); require(clv)
require(mvtnorm); require(fields); require(cluster)
require(topicmodels); require(corrplot);
set.seed(71)



source("DataClean.R")
data <- loadData()


source("Kmeans.R")
KMeans(data)

source("RandomForest.R")
RandomForest(data) #



source("neuronmain.R")
neuronNet(data)

