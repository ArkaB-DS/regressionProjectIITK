## MARS implementation on ozone dataset
# load data in R
#install.packages("faraway") # library where the data is
data(ozone,package="faraway") # loading the dataset in R
# taking modulo 365 +1
ozone<-data.frame(ozone[,-10],doy=ozone[,10]%%365+1)

#test data - 30%=>200-298

#------------------------------------
install.packages("earth")
library(earth)
mmod <- earth(O3 ~ ., ozone[1:300,])
summary(mmod)
plotmo(mmod)
#multicollinearity
library(lmtest)
imcdiag(mmod)
#normality
shapiro.test(residuals(mmod)) # rejected
# homo
library(lmtest)
bptest(mmod) #rejected
# autocorrelation
dwtest(mmod) # rejected
# prediction
y_pred<-predict(mmod,ozone[301:330,-1],
type="response")
plot(ozone[301:330,1],type="o",lwd=2,
col="red",ylim=c(-5,20))
lines(y_pred, lwd=2, col="blue",type="o")
sqrt(mean((ozone[301:330,1]-y_pred)^2))


