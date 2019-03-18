

library(gdata)  
library(ggplot2)
source("DataClean.R")
data <- preProcess()

column.counts <- colSums(is.na(df[,1:ncol(df)]))
row.counts <- rowSums(is.na(df))


## column
p <- qplot(column.counts,
      geom="histogram",
      binwidth = 30,
      main = "number of Featuers\nby NA number",
      xlab = "NA's",
      ylab = "Featuers",
      fill=I("blue"),
      col=I("red"),
      alpha=I(.2),
      cex.lab = 10,
      xlim=c(0,1000))



## rows

p <- qplot(row.counts,
      geom="histogram",
      binwidth = 15,
      main = "number of Samples\nby NA number",
      xlab = "number of NA",
      ylab = "Samples",
      fill=I("blue"),
      col=I("red"),
      alpha=I(.2),
      xlim=c(0,500))

# fixed for bigger aexis labels size.
p + theme(title = element_text ( size = 20), axis.title=element_text(size=18,face="bold"), axis.text.y = blue.bold.italic.14.text, axis.text.x = blue.bold.italic.14.text)



x <-data$SACOL0001
min(x)
h<-hist(x, breaks=30, col="red", xlab="Allel number",
        main="Histogram with Normal Curve\nfor SACOL0001 Allel Frequncies ") 
xfit<-seq(min(x),max(x),length=40) 
h + theme(title = element_text ( size = 20), axis.title=element_text(size=18,face="bold"), axis.text.y = blue.bold.italic.14.text, axis.text.x = blue.bold.italic.14.text)

yfit<-dnorm(xfit,mean=mean(x),sd=sd(x)) 
yfit <- yfit*diff(h$mids[1:2])*length(x) 
lines(xfit, yfit, col="blue", lwd=2)

# all na in qc cgmlst data frame 
a <- sapply(cgmlst, function(x) sum(is.na(x)))







#Allel frequency for depended variable SACOL001

qplot(data[,1],
      geom="histogram",
      binwidth = 1,
      main = "Allel frequency\nfor SACOL001",
      xlab = "Allel's",
      ylab = "number",
      fill=I("blue"),
      col=I("red"),
      alpha=I(.2),
      cex.lab = 10,
      xlim=c(0,68))





# corrlation matrix - not too informative in our case.
M <- cor(df) # get correlations
image(M)

# plot of unqiue values for SACOL0001
sum(is.na(z$Ozone)


