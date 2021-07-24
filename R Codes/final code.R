### R Codes for regression Project

# load data in R
install.packages("faraway") # library where the data is
data(ozone,package="faraway") # loading the dataset in R
# changing the variable doy to day and taking modulo 365 
ozone<-data.frame(ozone[,-10],"day"=ozone[,10]%%365)
ozone<-as.data.frame(rbind(ozone[307:330,],ozone[1:306,]))
#test data - 70%=>1:231
---------------------------------------------------------
#0 Basic Analysis
str(ozone) # structure of the dataset
summary(ozone) # summary of the dataset
install.packages("Hmisc") # library for plotting the histograms of all the variables
library(Hmisc) # load the installed package
par(mfrow=c(2,5))# create a 2x5 window for next 10 plots
hist.data.frame(ozone,freq=FALSE) # plot the histgrams
lmod0<-lm(O3~.,data=ozone[1:231,]) # Model 0
par(mfrow=c(2,2)) # create a 2x2 window for next 4 plots
plot(lmod0) # 4 plots
summary(lmod0) # summary of Model 0
-----------------------------------------------------------------
#1 Outlier and Influential points
# note : look at lower(2nd) components
CD<-cooks.distance(lmod0) # IP
#plot(CD)
which(CD>(4/221)) ##  21  41  77 133 148 150 159 191 200 217 229 230
DF<-dffits(lmod0) # IP 
which(DF>2*sqrt(10/221)) ## 77 104 133 148 150 159 200 
H<-hatvalues(lmod0) # Outlier
which(H>(2*10/221)) ## 4  41  57  58  60  72  82  90 121 
stud<-rstudent(lmod0) # outlier
which(abs(stud)>3)   ## 41 77
## which(dfbeta(lmod0)>sqrt(2/330)) # IP 
------------------------------------------------------------------
#2 Multicollinearity
pairs(formula=O3~.,data=ozone[1:231,]) # scatterplot matrix of all variables

install.packages("mctest")
library(mctest)
eigprop(lmod0) # variance decompostion proportion 
##gives vh, wind, humidity,dpg, temp, ibt and vis as correlated

install.packages("car")
library(car)
vif(lmod0) # variance inflation factor 
## gives ibt,vh and temp as correlated as VIF>5

eigprop(lm(O3~.-vh-ibt,data=ozone[1:231,]))# wind humidity temp
vif(lm(O3~.-vh-ibt,data=ozone[1:231,])) #all <5

# checking if there's significant drop in adjusted R^2
summary(lmod0)$r.squared
summary(lm(O3~.-vh-ibt,data=ozone[1:231,]))$r.squared

# so final model after removing multicollinearity is
# O3~wind+humidity+temp+ibh+dpg+vis+day
pairs(ozone[,c(1,3,4,5,6,7,9,10)])
lmodA<-lm(O3~.-ibt-vh,data=ozone[1:231,])
-------
## Ridge Regression
install.packages("lmridge")
library(lmridge)
#lmodB<-lmridge(O3~wind+humidity+temp+ibh+dpg+vis+day,
#data=ozone[1:231,],K=seq(0,0.2,1e-3)) # K=0.0404
#plot(lmodB)
lmodB<-lmridge(O3~wind+humidity+temp+ibh+dpg+vis+day,
data=ozone[1:231,],K=0.0404)
summary(lmodB)
vif(lmodB)
--------
## PCR
pcr<-prcomp(ozone[1:231,-1],center=T,scale=T)
summary(pcr)
plot(pcr,type="l")
lmodC<-lm(ozone[1:231,1]~.-PC9-PC8-PC7,data=data.frame(pcr$x))
summary(lmodC)$r.squared
-------------------------------------------------------------------
## Variable selection
install.packages("leaps")
library(leaps)
# for modelA
b <- regsubsets(x=model.matrix(lmodA)[1:231,-1],y=ozone[1:231,1])
rs <- summary(b)
rs$which
AIC <- 330*log(rs$rss/330) + (2:8)*2
plot(AIC ~ I(1:7), ylab="AIC", xlab="Number of Predictors",
type="l")
# so final model after variable selection is
# O3~humidity+temp+ibh+vis+day
lmodA<-lm(O3~.-ibt-vh-wind-dpg,data=ozone)
summary(lmodA)$r.squared

# for modelB
b <- regsubsets(x=lmodB$xs,y=lmodB$y)
rs <- summary(b)
rs$which
AIC <- 330*log(rs$rss/330) + (2:8)*2
plot(AIC ~ I(1:7), ylab="AIC", xlab="Number of Predictors",
type="l")
# so final model after variable selection is
# O3~humidity+temp+dpg+ibh+vis+day
#lmodB<-lmridge(O3~humidity+temp+dpg+ibh+vis+day,
#data=ozone[1:231,],K=seq(0,0.1,1e-3)) # K=0.011
#plot(lmodB)
lmodB<-lmridge(O3~humidity+temp+ibh+dpg+vis+day,
data=ozone[1:231,],K=0.038) # K=0.011
summary(lmodB)

# for modelC
b <- regsubsets(x=model.matrix(lmodC)[1:231,-1],y=ozone[1:231,1])
rs <- summary(b)
rs$which
AIC <- 330*log(rs$rss/330) + (3:8)*2
plot(AIC ~ I(1:6), ylab="AIC", xlab="Number of Predictors",
type="l")
# so final model after variable selection is
# O3~PC1+PC2+PC3
lmodC<-lm(ozone[1:231,]$O3~PC1+PC2+PC3,data=data.frame(pcr$x))
summary(lmodC)$r.squared
---------------------------------------------------
# heteroscedasticity
install.packages("lmtest")
library(lmtest)
## for Model A
bptest(lmodA) # Breusch-Pagan test
## rejected
install.packages("MASS")
library(MASS)
ans<-boxcox(lmodA)
lambda<-ans$x[which(ans$y==max(ans$y))]
#lambda<-0.2626263
lmodA<-lm(((O3^lambda-1)/lambda)~.-ibt-vh-wind-dpg,data=ozone[1:231,])
summary(lmodA)$r.squared
bptest(lmodA) # accepted
----
## for model B
bptest(lmodB)
ans<-boxcox(lmodB)
lambda<-ans$x[which(ans$y==max(ans$y))]
lambda<-.22
lmodB<-lmridge(((O3^lambda-1)/lambda)~humidity+temp+ibh+dpg+vis+day,
data=ozone[1:231,],K=0.08) # K=0.011
#plot(lmodB)
summary(lmodB)
bptest(lmodB) # accepted
-----
## for Model C
bptest(lmodC) # Breusch-Pagan test
## rejected
ans<-boxcox(lmodC)
lambda<-ans$x[which(ans$y==max(ans$y))]
#lambda<-.303030
lmodC<-lm(((ozone[1:231,]$O3^lambda-1)/lambda)~PC1+PC2+PC3,data=data.frame(pcr$x))
summary(lmodC)$r.squared
bptest(lmodC) # accepted
--------------------------------------
## normality
# for model A
qqnorm(residuals(lmodA)) ## Q-Q Plot
qqline(residuals(lmodA))
shapiro.test(residuals(lmodA)) # accepted
# for model B
qqnorm(residuals(lmodB)) ## Q-Q Plot
qqline(residuals(lmodB))
shapiro.test(residuals(lmodB)) # accepted
# for model C
qqnorm(residuals(lmodC)) ## Q-Q Plot
qqline(residuals(lmodC))
shapiro.test(residuals(lmodC)) # accepted
--------------------------------------- do till here
## autocorrelation
install.packages("lmtest")
library(lmtest)
# for model A
plot(residuals(lmodA)[-1],residuals(lmodA)[-length(residuals(lmodA))],
xlab=expression(epsilon[t-1]),ylab=expression(epsilon[t]))
abline(lm(residuals(lmodA)[-length(residuals(lmodA))]~
residuals(lmodA)[-1]))
cov(residuals(lmodA)[-1],residuals(lmodA)[-length(residuals(lmodA))])

dwtest(lmodA) # rejected
#install.packages("orcutt")
#install.packages("prais")
#library(orcutt)
#lmodA<-cochrane.orcutt(lmodA)
#lmodA$r.squared
#library(prais)
#lmodA<-prais_winsten(lmodA$call,data=ozone)
#summary(lmodA)
-------
# for model B
dwtest(lmodB) # rejected
#install.packages("orcutt")
#library(orcutt)
#lmodB<-cochrane.orcutt(lmodB)
#lmodB$r.squared
-------
# for model C
dwtest(lmodC) # rejected
#install.packages("orcutt")
#library(orcutt)
#lmodC<-cochrane.orcutt(lmodC)
#lmodC$r.squared
-----------------------------------------------------
Predicitve Power -

## without autocorrelation

# for model A
y<-ozone[232:330,1]
y<-(y^0.2626263-1)/0.2626263
y_pred<-predict(lmodA,ozone[232:330,-1],
type="response")
(RMSE<-sqrt(mean((y-y_pred)^2)))
plot(1:99,y_pred,type="o",col="blue",ylim=c(0,8))
lines(x=1:99,y,col="red",type="o")

# for model B
y<-ozone[232:330,1]
y<-(y^.22-1)/.22
y_pred<-predict(lmodB,ozone[232:330,-1],
type="response")
(RMSE<-sqrt(mean((y-y_pred)^2)))
plot(1:99,y_pred,type="o",col="blue",ylim=c(0,8))
lines(x=1:99,y,col="red",type="o")

# for model C
y<-ozone[232:330,1]
y<-(y^0.3-1)/0.3
pcr<-prcomp(ozone[232:330,-1],center=T,scale=T)
Data<-data.frame(pcr$x)[,c(1,2,3)]
y_pred<-predict(lmodC,Data,
type="response")
(RMSE<-sqrt(mean((y-y_pred)^2)))
plot(1:99,y_pred,type="o",col="blue",ylim=c(0,10))
lines(x=1:99,y,col="red",type="o")


-------------------------------------------------------ignore below


AR<-arima(ozone[1:231,1],
c(11,0,0),xreg=ozone[1:231,c(4,5,6,9,10)])
pacf(residuals(AR))
(d = sum((AR$residuals - lag(AR$residuals))^2, na.rm = TRUE) /
sum(AR$residuals^2, na.rm = TRUE))

y_pred<-predict(AR,n.ahead=99,newxreg=ozone[232:330,c(4,5,6,9,10)])$pred
(RMSE<-sqrt(mean((y-y_pred)^2)))
plot(232:330,y_pred,type="o",col="blue",ylim=c(-5,40))
lines(x=232:330,y,col="red",type="o")

plot(ozone[1:231,1],type="l",col="red",,ylim=c(-5,40))
lines(fitted(AR),type="l",col="blue",ylim=c(-5,40))
lines(fitted(lmodA),type="l",col="seagreen",,ylim=c(-5,40))




