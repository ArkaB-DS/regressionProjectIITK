library(forecast)
modA<-arima(x=(ozone[c(1:300),1]^lambdaA-1)/lambdaA,
xreg=model.matrix(lmodA)[,-1],
order=c(0,1,2))

(modelA<-auto.arima(y=(ozone[c(1:300),1]^lambdaA-1)/lambdaA,
xreg=model.matrix(lmodA)[,-1],
max.p=7,max.q=7,max.d=7))

y<-ozone[301:330,1]
y<-(y^lambdaA-1)/lambdaA
#par(mfrow=c(1,2))
y_pred<-as.vector(predict(modA,
newxreg=ozone[301:330,c(4,5,6,7,10)])[[1]])
plot(y,type="o",col="red",ylim=c(0,5),lwd=2)
lines(y_pred,col="blue",type="o",lwd=2)
sqrt(mean((y-y_pred)^2))

modelB<-auto.arima(y=(ozone[1:300,1]^lambdaB-1)/lambdaB,
xreg=model.matrix(lmodB)[,-1],
max.p=7,max.q=7,max.d=7)

## for model C
(modelC<-auto.arima(y=(ozone[c(1:300),1]^lambdaC-1)/lambdaC,
xreg=model.matrix(lmodC)[,-1],
max.p=7,max.q=7,max.d=7))

modC<-arima(x=(ozone[c(1:300),1]^lambdaC-1)/lambdaC,
xreg=model.matrix(lmodC)[,-1],
order=c(0,1,2))
par(mfrow=c(1,2))
acf(residuals(modC));pacf(residuals(modC))

y<-ozone[301:330,1]
y<-(y^lambdaC-1)/lambdaC
pcr<-prcomp(ozone[301:330,-1],center=TRUE,scale=TRUE)
Data<-data.frame(pcr$x)[,-c(2,3,6,9)]
#par(mfrow=c(1,2))
y_pred<-as.vector(predict(modC,newxreg=Data)[[1]])
plot(y,type="o",col="red",ylim=c(0,6),lwd=2)
lines(y_pred,col="blue",type="o",lwd=2)
sqrt(mean((y-y_pred)^2))











