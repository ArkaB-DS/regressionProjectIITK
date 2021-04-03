# Modelling-linear-relationship-between-Ozone-Concentration-and-Meteorology-LA-Basin-1976
This repo is for a group project for MTH416A : Regression Analysis at IIT Kanpur

## Group Members : 
  - Arkajyoti Bhattacharjee
  - Vishweshwar Tyagi
  - Saurab Jain
  - Jetti Ramya Chowdary
  - Apoorva Singh

## Tentative Plan for the Project

1. Outliers (O) and Influential Points (IP) :
     + Detection :
        -  Cooks Distance (IP)
        -  DFFITs (IP)
        -  Hat Values (O)
        -  Studentized Residuals (O)
     + Remedy : 
2. Multicollinearity :
     + Detection :
       - Pairs Plot
       - Variance Inflation Factor (VIF)
       - Variance Decompostion Proportion
     + Remedy :
       - Dropping variables (**Model A**)
       - Ridge Regression (**Model B**)
       - Principal Component Regression (**Model C**)
       - LASSO (**Model D** - *BONUS*)
       - Elastic Net (**Model E** - *BONUS*)
3. Variable Selection :
     - Stepwise Regression
     - Plot AIC vs P
4. Homoscedasticity of Errors :
     + Detection :
         - Residual vs Fitted Plot
         - Goldfeld-Quandt Test
         - Glejser Test
         - Breusch-Pagan Test
     + Remedy :
         - Box-Cox Transformation
         - Generalized Least Squares
5. Normality of Errors :
     + Detection :
         - Q-Q Plot
         - Shapiro-Wilks Test
6. Autocorrelation :
     + Detection :
         - $\epsilon_t$ vs $\epsilon_{t-1}$ plot
         - Durbin-Watson Test
     + Remedy :
         - Assume AR(1) model for errors and estimate AR parameter $\rho$ using -
               * Cochrane-Orcutt Method
               * Prais-Winsten Method
 7. Prediction :       
     Compare the models A, B and C based on RMSE.
