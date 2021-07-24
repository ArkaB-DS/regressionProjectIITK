## KNN implementation on ozone dataset
# load data in R
#install.packages("faraway") # library where the data is
data(ozone,package="faraway") # loading the dataset in R
# taking modulo 365 +1
ozone<-data.frame(ozone[,-10],doy=ozone[,10]%%365+1)
ozone<-as.data.frame(rbind(ozone[307:330,],ozone[1:306,]))
#test data - 30%=>200-298
#-------------------------------------------------
#install.packages("FNN")
library(FNN)
knn<-knn.reg(train=ozone[c(1:300),-1],
test=ozone[301:330,-1],
y=ozone[c(1:300),1], k=14)
y<-ozone[301:330,1]
y_pred<-knn$pred
sqrt(mean((y-y_pred)^2))
plot(y,col="red",lwd=2,type="o")
lines(y_pred,col="blue",type="o",lwd=2)

