
KMeans <- function(data) { 


colnames(data) <- c("x1","x2","x3","x4","x5")

dunn <- c(); DB <- c(); K <- 32;
inter <- c(); outer <- c(); ratio <- c();



for(k in 2:K){
  clust_data2    <- kmeans(data, centers=k, iter.max=25, nstart=5)
  inter       <- c(inter,   clust_data2$tot.withinss)
  outer       <- c(outer,   clust_data2$betweenss)
  ratio       <- c(ratio,   clust_data2$tot.withinss/clust_data2$betweenss)
  scatt_data    <- cls.scatt.data(data, clust=clust_data2$cluster, dist='euclidean')
  dunn          <- c(dunn, clv.Dunn(scatt_data, 'centroid', 'centroid'))
  DB            <- c(DB,   clv.Davies.Bouldin(scatt_data, 'centroid', 'centroid'))
}


l       <- length(dunn)
results <- data.frame(K=rep(seq(2,K),3), metrics=c(rep('inter', l), rep('outer', l),rep('ratio', l)),
                      value=c(inter, outer, 1000000000*ratio))
ggplot(results, aes(x=K, y=value, color=factor(metrics))) + geom_line() + geom_point()


mixedIndex <- mapply("/",dunn,DB)
#second pic mixed
clust_metrics <- data.frame(K = rep(seq(2,K,1),3), value = c(dunn, DB, mixedIndex), metric = c(rep('Dunn',l), rep('DB',l),rep('mixed',l)))
ggplot(clust_metrics, aes(x=K, y=value, color=factor(metric))) + geom_point() + geom_line()


#third pic try to visulaize the data -  doesntt work well for us,
#problem is hard to visulaize
clust_data2    <- kmeans(data2, centers=29, iter.max=25, nstart=5)
clusplot(data2, clust_data2$cluster, color=TRUE, shade=TRUE, line=0,)




}