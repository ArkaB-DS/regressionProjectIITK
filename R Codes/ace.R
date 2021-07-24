# load data in R
#install.packages("faraway") # library where the data is
data(ozone,package="faraway") # loading the dataset in R
# changing the variable doy to day and taking modulo 365 
ozone<-data.frame(ozone[,-10],"day"=ozone[,10]%%365+1)
ozone<-as.data.frame(rbind(ozone[307:330,],ozone[1:306,]))
#test data - 70%=>1:231
------------------------------
#install.packages("acepack")
library(acepack) # for the ACE algorithm
final<-ace(x=as.matrix(ozone[1:300,-1]),
y=ozone[1:300,1]) # storing the optimal transformed variables
Data<-data.frame(O3=final$ty,final$tx)
par(mfrow=c(2,5))
for (i in 1:10) plot(ozone[1:300,i],
Data[,i],col=i,xlab="Original",ylab="Optimal Transform")
pairs(O3~.,data=Data)
lmod<-lm(O3~.,data=Data) # fitting a model after optimal transformations
summary(lmod)$r.squared
final2 <- ace(x=as.matrix(ozone[301:330,-1]),y=ozone[301:330,1]) # test data
New <- data.frame(final2$tx) 
y_pred<-as.vector(predict(lmod,newdata=New,type="response")) # predicted values
plot(final2$ty,type="o",col="red",ylim=c(-2,2.5),lwd=2) # original vs predicted
lines(y_pred,type="o",col="blue",lwd=2)
(RMSE<-sqrt(mean((final2$ty-y_pred)^2))) # RMSE value 0.4516001
---------------------------------
imcdiag(lmod)
step(lmod)
shapiro.test(residuals(lmod)) # accepted
bptest(lmod)
---------------------------------
#install.packages("acepack")
library(acepack) # for the ACE algorithm
final<-ace(x=as.matrix(ozone[1:300,-c(1,2,8)]),
y=ozone[1:300,1]) # storing the optimal transformed variables
Data<-data.frame(O3=final$ty,final$tx)
par(mfrow=c(2,5))
for (i in 1:10) {plot(ozone[1:300,i],
Data[,i],col=i,xlab="Original",ylab="Optimal Transform")}
pairs(O3~.,data=Data)
lmod<-lm(O3~.,data=Data) # fitting a model after optimal transformations
summary(lmod)$r.squared
final2 <- ace(x=as.matrix(ozone[301:330,-c(1,2,8)]),
y=ozone[301:330,1]) # test data
New <- data.frame(final2$tx) 
y_pred<-as.vector(predict(lmod,newdata=New,type="response")) # predicted values
plot(final2$ty,type="o",col="red",ylim=c(-2,2.5),lwd=2) # original vs predicted
lines(y_pred,type="o",col="blue",lwd=2)
(RMSE<-sqrt(mean((final2$ty-y_pred)^2))) # RMSE value 0.3132212
#--------------------------------
vif(lmod)
shapiro.test(residuals(lmod)) # accepted
bptest(lmod)
dwtest(lmod,alternative="two.sided")

