

neuronNet <- function(data) { 
  
  library(nnet)
  
  data      <- data[sample(nrow(data),size=nrow(data)),]
  max_neurons <- 2
  nnum <- seq(1,max_neurons,1)
  acc     <- matrix(0,length(nnum),10)
  folds      <- sample(10, nrow(data), replace=T)
  folds.prob <- as.numeric(table(folds)/length(folds))
  

  

  
  for(neurons in nnum){
    fold_num=0
    for(fold in 1:10){  
            fold_num=fold_num+1
            nn <- nnet(x=data[folds!=fold,2:1861], y=class.ind(data[folds!=fold,1]), size=neurons, linout=FALSE, softmax=T, MaxNWts = 40000)
  		    	preds1   <- factor(predict(nn, newdata=data[folds==fold,2:1861], type='class'))
  		    	acc[neurons, fold]  <- (sum(preds1==data[folds==fold,1]))/nrow(data[folds==fold,])
  		    	
          }
  }
  
  acc_avg     <- matrix(0,max_neurons)
  for (i in 1:max_neurons){
    acc_avg[i] <-apply(acc[i,], 2, function(x){x*folds.prob},2,sum)
	  acc_avg[i] <- (acc[i,1]+acc[i,2]+acc[i,3]+acc[i,4]+acc[i,5]+acc[i,6]+acc[i,7]+acc[i,8]+acc[i,9]+acc[i,10]])/10
  }
  
  
  x <- c(1:max_neurons)
  y <- acc_avg
  plot(x,y,xlab="neurons",ylab="accuracy", main="10 cross validation accuracy", pch=15, col="blue")
  
}