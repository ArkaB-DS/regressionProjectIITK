> This repo is for a group project for the course **MTH416A : Regression Analysis** during the academic session 2021-2022 (even semester) at IIT Kanpur.

## Project Title:

**`Ozone concentration and meteorology in the LA Basin, 1976 - A Regression Study`** [[_Report_]](https://github.com/ArkaB-DS/regressionProjectIITK/blob/main/Report/Project_Report.pdf)       [[_Presentation_]](https://github.com/ArkaB-DS/regressionProjectIITK/blob/main/Presentation/Project_PPT.pdf) 
# Project Guide

[**_Prof. Sharmishtha Mitra_**](http://home.iitk.ac.in/~smitra/), Department of Mathematics and Statistics, IIT Kanpur

## Project Members : 
  - [Arkajyoti Bhattacharjee](https://github.com/ArkaB-DS)
  - [Vishweshwar Tyagi](https://github.com/vishweshwartyagi)
  - [Saurab Jain](https://github.com/jnsaurab)
  - Apoorva Singh

## Project Outline

|Setup|Topic|
|-----|-----|
|     |1. Introduction|
|     |2. Data Description|
|     |3. Exploratory Data Analysis|
|Parametric|4. Multicollinearity |
|| Detection:<ul><li> Eigen-decompostion Proportion</li></ul> <ul><li> Variance Inflation Factor</li></ul>Remedy: <ul><li> Variable Drop (Model A)</li></ul><ul><li> Ridge Regression (Model B)</li></ul><ul><li> Principal Components Regression (Model C)</li></ul>|
|          |5. Variable Selection|
||Selection Methods: <ul><li> Best Subset Selection</li></ul> <ul><li> Mallow's Cp</li></ul><ul><li> Adjusted $R^2$</li></ul><ul><li> AIC vs p Plot</li></ul><ul><li> Scree Plot and Validation Plot</li></ul>
|          |6. Heteroscedasticity of Errors|
|          |7. Normality of Errors|
|          |8. Autocorrelation|
|          | 9. Prediction |
|Nonparametric| 10. Alternating Conditional Expectation (ACE)|
|             | 11. Final Model Fit and Predictions |

## Final Model Fit and Predictions:

|Model type    |Model Name|$R^2$ |RMSE  |
|:------------:|:--------:|:----:|:----:|
|Parametric    |  Model 0 |0.6986|4.2745|
|              |  Model A |0.7662|0.8272|
|              |  Model B |0.7202|0.8830|
|              |  Model C |0.7077|1.2565|
|Non-Parametric|    ACE   |0.8271|0.3132|

## Conclusions

* Among the **parametric models**, **model A** has the **highest** $R^2$ value as well as the **lowest** $RMSE$ value. 
* All models - **A**, **B** and **C** are better than the baseline model **Model 0**. This validates our corrections for **multicollinearity**, **heteroscedasticity** and **autocorrelation** and **variable selection**.
* Simple **non-parametric models** are better if the problem of prediction is to be solved. But here, the **ACE** model transforms the data so that maximum $R^2$ can be achieved. And, as expected it has the **highest** $R^2$ value and the **lowest** $RMSE$ value amond all the models.
* So among the models considered here, **ACE** model is the **best**, both for the problem of prediction and for the purpose of explaining **ozone concentration** by the **meteorological** variables based on the **ozone** dataset.

## References:

  1. Leo Breiman & Jerome H. Friedman (1985): Estimating Optimal Transformations for Multiple Regression and
Correlation, Journal of the American Statistical Association, 80:391, 580-598
  2. Jolliffe, Ian T. (1982). "A note on the Use of Principal Components in Regression". Journal of the Royal Statistical Society, Series C. 31 (3): 300–303. doi:10.2307/2348005. JSTOR 2348005.
  3. Sung H. Park (1981). "Collinearity and Optimal Restrictions on Regression Parameters for Estimating Responses". Technometrics. 23 (3): 289–295. doi:10.2307/1267793.
  4. Wilkinson, L., & Dallal, G.E. (1981). Tests of significance in forward selection regression with an F-to enter stopping rule. Technometrics, 23, 377–380
  5. Akaike, H. (1973), "Information theory and an extension of the maximum likelihood principle", in Petrov, B. N.; Csáki, F. (eds.), 2nd International Symposium on Information Theory, Tsahkadsor, Armenia, USSR, September 2-8, 1971, Budapest: Akadémiai Kiadó, pp. 267–281. Republished in Kotz, S.; Johnson, N. L., eds. (1992), Breakthroughs in Statistics, I, Springer-Verlag, pp. 610–624.
  6. Akaike, H. (1974), "A new look at the statistical model identification", IEEE Transactions on Automatic Control, 19 (6): 716–723, doi:10.1109/TAC.1974.1100705, MR 0423716.
  7. Shapiro, S. S.; Wilk, M. B. (1965). "An analysis of variance test for normality (complete samples)". Biometrika. 52 (3–4): 591–611. doi:10.1093/biomet/52.3-4.591. JSTOR 2333709. MR 0205384. p. 593
  8. Breusch, T. S.; Pagan, A. R. (1979). "A Simple Test for Heteroskedasticity and Random Coefficient Variation". Econometrica. 47 (5): 1287–1294. doi:10.2307/1911963. JSTOR 1911963. MR 0545960.
  9. Box, George E. P.; Cox, D. R. (1964). "An analysis of transformations". Journal of the Royal Statistical Society, Series B. 26 (2): 211–252. JSTOR 2984418. MR 0192611.
  10. Durbin, J.; Watson, G. S. (1950). "Testing for Serial Correlation in Least Squares Regression, I". Biometrika. 37 (3–4): 409–428. doi:10.1093/biomet/37.3-4.409. JSTOR 2332391
  11. Durbin, J.; Watson, G. S. (1951). "Testing for Serial Correlation in Least Squares Regression, II". Biometrika. 38 (1–2): 159–179. doi:10.1093/biomet/38.1-2.159. JSTOR 2332325
  12. Faraway, J.J. (2004). Linear Models with R (1st ed.). Chapman and Hall/CRC. https://doi.org/10.4324/9780203507278
  13. Hoerl, A. E., Kennard, R. W. and Baldwin, K. F. (1975). Ridge regression: Some simulations.
Communications in Statistics-Theory and Methods, 4(2), 105-123. 
