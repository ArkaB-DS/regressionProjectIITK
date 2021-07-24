# load data in R
install.packages("faraway") # library where the data is
data(ozone,package="faraway") # loading the dataset in R
# changing the variable doy to day and taking modulo 365 
ozone<-data.frame(ozone[,-10],"day"=ozone[,10]%%365)
ozone<-as.data.frame(rbind(ozone[307:330,],ozone[1:306,]))
ozone<-data.frame(ozone[12:330,],y.lag1=diff(ozone[,1],lag=1)[-(1:10)],
y.lag2=diff(ozone[,1],lag=2)[-(1:9)],y.lag3=diff(ozone[,1],lag=3)[-(1:8)],
y.lag4=diff(ozone[,1],lag=4)[-(1:7)],y.lag5=diff(ozone[,1],lag=5)[-(1:6)],
y.lag6=diff(ozone[,1],lag=6)[-(1:5)],y.lag7=diff(ozone[,1],lag=7)[-(1:4)],
y.lag8=diff(ozone[,1],lag=8)[-(1:3)],y.lag9=diff(ozone[,1],lag=9)[-(1:2)],
y.lag10=diff(ozone[,1],lag=10)[-1],y.lag11=diff(ozone[,1],lag=11))
lmodA.lag11<-lm(O3~.-ibt-vh-wind-dpg,data=ozone[1:224,])
summary(lmodA.lag11)$r.squared
library(MASS)
ans<-boxcox(lmodA.lag11)
lambda<-ans$x[which(ans$y==max(ans$y))]
#lambda<-0.5858586
lmodA.lag11<-lm(((O3^lambda-1)/lambda)~.-ibt-vh-wind-dpg,data=ozone[1:224,])
summary(lmodA.lag11)$r.squared
library(lmtest)
bptest(lmodA.lag11) # homoscedastic
library(car)
vif(lmodA.lag11) #almost no multicollinearity
shapiro.test(residuals(lmodA.lag11))# errors are normal
library(ecm)

# prediction

# for model A

y<-ozone[225:319,1]
y<-(y^lambda-1)/lambda
y_pred<-predict(lmodA.lag11,ozone[225:319,-1],
type="response")
(RMSE<-sqrt(mean((y-y_pred)^2)))
plot(y_pred,type="o",col="blue",ylim=c(0,15))
lines(y,col="red",type="o",lwd=2)
-------------------------------------
