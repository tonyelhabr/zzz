#' ---	
#' title: "Homework"	
#' output: word_document	
#' header-includes:	
#'   - \usepackage{comment}	
#' params:	
#'   soln: TRUE	
#' ---	
#'   	
#'   1. Fit the linear regression model $Y \sim X$ with the following data. Interpret the coefficient estimates.	
#' 	
#' 	
set.seed(123)	
X <- c(1, 1, 0, 0)	
Y <- rnorm(4)	
#' 	
#' 	
#' `r if(!params$soln) {"\\begin{comment}"}`	
#' 	
#' **Solution:**	
#'   	
#' Run the following R code to fit the linear regression model:	
#' 	
fit1 = lm(Y ~ X)	
#' 	
#' 	
#' To see a summary of the regression results, run the following code and review the output: 	
#'   	
#' 	
summary(fit1)	
#' 	
#' The interpretation of the intercept is.... 	
#' 	
#' Our estimate $\hat{\beta}_0$ is `r round(coef(fit1)[1], 2)`.	
#' 	
#' The estimated X coefficient $\hat{\beta}_1$ is `r round(coef(fit1)[2], 2)`. 	
#' 	
#' This can be interpreted as....	
#' 	
#' `r if(!params$soln) {"\\end{comment}"}`	
#' 	
