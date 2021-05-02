# Modelling-linear-relationship-between-Ozone-Concentration-and-Meteorology-LA-Basin-1976
This repo is for a group project for MTH416A : Regression Analysis at IIT Kanpur

## Group Members : 
  - [Arkajyoti Bhattacharjee](https://github.com/ArkaB-DS)
  - [Vishweshwar Tyagi](https://github.com/vishweshwartyagi)
  - [Saurab Jain](https://github.com/jnsaurab)
  - Apoorva Singh


## Tentative Plan for the Project :

0. Preliminaries :
    - structure of the data-set 
    - summary of the data-set
    - Fitting a linear model with all the variables and summarize (**Model 0**)
    - Scatterplot Matrix
    - Basic Plots based on **Model 0**
1. Outliers (O) and Influential Points (IP) : [omitted]
     + Detection :
        -  Cooks Distance (IP)
        -  DFFITs (IP)
        -  Hat Values (O)
        -  Studentized Residuals (O)
     + Remedy : 
2. Multicollinearity :
     + Detection :
       - Scatterplot Matrix
       - Variance Inflation Factor (VIF)
       - Variance Decompostion Proportion
     + Remedy :
       - Dropping variables (**Model A**)
       - Ridge Regression (**Model B**)
       - Principal Component Regression (**Model C**)
       - LASSO (**Model D** - *BONUS*) [omitted]
       - Elastic Net (**Model E** - *BONUS*) [omitted]
3. Variable Selection :
     - Plot AIC vs P
     - Exhaustive Search
     - Mallow's Cp Criterion
     - Stepwise Selection
4. Homoscedasticity of Errors :
     + Detection :
         - Residual vs Fitted Plot
         - Goldfeld-Quandt Test (*optional*) [omitted]
         - Glejser Test (*optional*) [omitted]
         - Breusch-Pagan Test
     + Remedy :
         - Box-Cox Transformation
         - Generalized Least Squares [omitted]
5. Normality of Errors :
     + Detection :
         - Q-Q Plot
         - Shapiro-Wilks Test
6. Autocorrelation :
     + Detection :
         -  $\epsilon_t$ vs $\epsilon_{t-1}$ plot
         - Durbin-Watson Test
     + Remedy :
         - Assume AR(1) model for errors and estimate AR parameter $\rho$ using -[omitted]
              * Cochrane-Orcutt Method
              * Prais-Winsten Method
         - Used *auto.arima* function in R to fit an ARIMA(0,1,2) model for model A
         - model B and C were not auto-correlation corrected 
 7. Prediction :       
     + Compare the models A, B and C based on RMSE with model 0 as baseline model
 
 8. * Apply **Alternating Conditional Expectation(ACE)** algorithm on the **ozone** dataset and repeat all steps 0 through 7, whatever is applicable.
 
 ### BONUS :
  * Apply **Multivariate Adaptive Regression Splines(MARS)** algorithm on the **ozone** dataset and repeat all steps 0 through 7, whatever is applicable. [omitted]
