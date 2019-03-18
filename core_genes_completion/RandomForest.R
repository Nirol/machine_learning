#© 2016 JONATHAN ENGEL AND NIR GILAD ALL RIGHTS RESERVED
RandomForest <- function(data) { 
  
  # loading saved object instaed of running

  data      <- data[sample(nrow(data),size=nrow(data)),]  
View(data)

  folds      <- sample(10, nrow(data), replace=T)
  folds.prob <- as.numeric(table(folds)/length(folds))
  ntrees <- seq(100,1000,100) #cheking for 100 - 2000 number of tree's range.
  mtry <- c(35,40,43,50)
  acc     <- matrix(0,length(ntrees),length(mtry))
  acc2 <- matrix(0,10)
  treeCounter=0
  for(trees in ntrees){
    treeCounter=treeCounter+1
    mtryCounter=0
    for (mtryParam in mtry) {     
      fold_num=0
      mtryCounter=mtryCounter+1
      #build model
      for(fold in 1:10){  
      fold_num=fold_num+1  
      rf <- randomForest(as.factor(SACOL0001)~., data=data[folds!=fold,], ntree=trees, mtry=mtryParam)
      preds1 <- predict(rf, newdata=data[folds==fold,-1], type='response')      
      acc2[fold_num,1] <- sum(preds1==data[folds==fold,1])/nrow(data[folds==fold,])
      
      
      }  
      final_acc<-apply(apply(acc2, 2, function(x){x*folds.prob}),2,sum)
      acc[treeCounter, mtryCounter]  <- final_acc
    
            
    }
    
  }
  
  
  
  #additional plots for final calculated model with best accuracy
  
  
 importanceVector <- cgmlst.rf$importance[,28]
 sorted <- sort(importanceVector, decreasing = TRUE)



# proximity matrix
#View(cgmlst.rf$proximity)




# plot of error on trees
plot(cgmlst.rf$err.rate[,1],type="l" ,xlab = "Trees used", ylab = "OOB error",main = "OOB error\nby number of trees used",)
  


#plot of important variable
varImpPlot(cgmlst.rf,n.var=10,main="Variable Importance Plot",cex=0.75,cex.lab = 2, col=1, pch="x")



## get tree!, the number is the tree number, give us a matrix representing the tree
#tree <-getTree(cgmlst.rf, 3, labelVar=TRUE)
#View(tree)

## margin of rf

abc <- margin(cgmlst.rf,observed )

plot(margin(cgmlst.rf,observed,sort=FALSE ), main="Margins of randomForest Classifier")




## rfcv need to run and save it


## remove SACOL0001 from data first
data2 <-data[-c(1)]

result <- rfcv(data2,  data$SACOL0001, cv.fold=10)
save(result, file = "rfcv")

with(result, plot(n.var, error.cv, log="x", type="o", lwd=2))






## this one run 5 different expreiments of cv each one with cv.fold=5

result <- replicate(5, rfcv(data2,data$SACOL0001,cv.fold=20), simplify=FALSE)


error.cv <- sapply(result, "[[", "error.cv")
matplot(result[[1]]$n.var, cbind(rowMeans(error.cv), error.cv), type="l",
        lwd=c(2, rep(1, ncol(error.cv))), col=1, lty=1, log="x",
        xlab="Number of variables", ylab="CV Error")




}