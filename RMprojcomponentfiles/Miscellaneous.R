range(mtcars$mpg[mtcars$am==0]) # 0 = automatic
range(mtcars$mpg[mtcars$am==1]) # 1 = manual
sd(mtcars$mpg[mtcars$am==0])
sd(mtcars$mpg[mtcars$am==1])
var(mtcars$mpg[mtcars$am==0])
var(mtcars$mpg[mtcars$am==1])
mean(mtcars$mpg[mtcars$am==0])
mean(mtcars$mpg[mtcars$am==1])
---
# Notice the correlation of mpg to cyl = -0.852, disp = -0.848, wt = -0.868 & hp = -0.776
# Notice the covariance of mpg to disp = -633.10, & hp = -320.73
# these should be checked for collinearity and variance inflation VIF
---
tstat <- t.test(mpg ~ am, data = mtcars)
tstat
# Welch Two Sample t-test
#
# data:  mpg by am
# t = -3.7671, df = 18.332, p-value = 0.001374
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#         -11.280194  -3.209684
# sample estimates:
#         mean in group 0 mean in group 1
# 17.14737        24.39231
---
data(mtcars);head(mtcars)
for(i in c(2,8:11))mtcars[,i] <- as.factor(mtcars[,i])
str(mtcars)

mtcars$vs <- factor(mtcars$vs, labels = c("V-eng", "S-eng")); mtcars$am <- factor(mtcars$am, labels = c("Automatic", "Manual")); mtcars$gear <- factor(mtcars$gear); mtcars$carb <- factor(mtcars$carb)
head(mtcars,3)









---
?

---
# Regression
f1 <- (lm(mpg ~ factor(am), data = mtcars))
coef(f1)
plot(1/(coef(f1)))

(Intercept) factor(am)1
17.147368    7.244939
# mean mpg for automatic transmission is 17.15mpg
# mean mpg for manual transmission is 17.15mpg + 7.24mpg = 24.39mpg
---
##** How to center y & x
##yc <- y - mean(y)
##xc <- x - mean(x)
##b1 <- sum(yc * xc) / sum(xc ^2)
##c(b1, coef(lm(y ~ x))[2])
## OR
## lm(yc ~ xc -1)
## ##---
##** How to normalize y & x
##yn <- (y - mean(y)) / sd(y)
##xn <- (x - mean(x)) / sd(x)
##c(cor(y,x), cor(yn, xn), coef(lmyn ~ xn))[2])
##
## To add a regression line using ggplot2
## ```{r, fig.height=6,fig.width=6,echo=FALSE}
## g <- ggplot(filter(freqData, freq > 0), aes(x = parent, y = child))
## g <- g + scale_size(range = c(2,20), guide = "none)
## g <- geom_point(colour="grey50", aes(size = freq+20, show_guide = FALSE))
## g <- g + geom_point(aes(colour=freq, size=freq))
## g <- g + scale_colour_gradient(low = "lightblue", high = "white)
## g <- g + geom_smooth(method="lm", formula=y~x) ## this adds the regression line
## g
## ```
##```{r,}
## data(diamond)
## y <- diamond$orice; x <- diamond$carat; n <- lenght(y,x)
## fit <- lm(y ~ x)
## e <- resid(fit)
## yhat <- predict(fit)
## max(abd(e - (y - yhat)))
## max(abs(e - (y - coef(fit)[1] - coef(fit)[2] * x)))
## sum(e)
## sum(e * x)
---
## Residuals
## Using base plot graphics
## plot(diamond$carat, diamond$price,
##      xlab = "Mass (carats"),
##      ylab = "Price (SIN $),
##      bg = "lightblue,
##      col = black, cex = 1.1, pch = 21, frame = FALSE)
## abline(fit, lwd = 2)
## for(i in 1:n)
##      lines(c(x[i], x[i], c(y[i], yhat[i]), col = "red, lwd = 2)
## ## plot(diamond$carat, diamond$price,
##      xlab = "Mass (carats")",
##      ylab = "Residuals (SIN $)",
##      bg = "lightblue",
##      col = black, cex = 1.1, pch = 21, frame = FALSE)
## abline(fit, lwd = 2)
## for(i in 1:n)
##      lines(c(x[i], x[i], c(y[i], yhat[i]), col = "red", lwd = 2)
##
## Residuals continued!!
## g <- ggplot(data.frame(x = x, y = resid(lm(y ` x))),
##      aes(x = x, y = y))
## g <- g + geom_hline(yintercept = 0, size = 2);
## g <- g + geom_point(size = 7, colour = "black", alpha = 0.4)
## g <- g + geom_point(size = 5, colour = "red", alpha - 0.4)
## g <- g + xlab("X") + ylab("Residual")
## g
## More Residuals
## diamond$e <- resid(lm(price ~ carat, data = diamond))
## g <- ggplot(diamond, aes(x = carat, y = e))
## g <- g + xlab("Mass (carats)")
## g <- g + ylab)"Residual price (SIN $)")
## g <- g + geom_hline(yintercept = 0, size = 2)
## g <- g + geom_point(size = 7, colour = "black", alpha = 0.5)
## g <- g + geom_point(size = 5, colour = "blue", alpha = 0.2)
##
---

from the pairs plot
# #pairs(ordmtcars, panel = panel.smooth, main = "MTCARS data set", col = 3)
# pairs(mtcars, main = "mtcars data")
# coplot(mpg ~ hp + drat | as.factor(cyl), data = mtcars,
#        panel = panel.smooth, rows = 1)




REVISE THIS!!!!

        # From the output of the above code use those variables with low sqrt of variance inflation results = (cyl, drat, vs, am, gear & carb), to formulate the next multivariate model



        ```{r, eval=FALSE, fig.height=3, fig.width=3, message=FALSE, warning=FALSE, include=FALSE}
library(ggplot2);library(dplyr);data("mtcars")
f4 <- lm(mpg ~ am + drat +  cyl + vs + gear + carb, data = mtcars);vif(f4)
f5 <- lm(mpg ~ I(am + drat) + carb, data = mtcars);sqrt(vif(f5))
par(mfrow = c(2,1), mar = c(4,4,2,2)) # set margin
g <- ggplot(mtcars, aes(x = (drat, am, carb), y = mpg),)
g <- g + xlab("(am + drat + carb)")
g <- g + ylab("Miles per g1allon")
g <- g + geom_smooth(aes(method = "lm", se = FALSE))
g <- g + geom_point(size = 3.0, col = "black", alpha = .65)
g
```


Finding a better model fit; use the variables with low sqrt of variance
inflation =  cyl, drat, vs, am, gear & carb; The following multivariate model
includes these regressors

```{r, echo=TRUE, eval=, fig.height=3, fig.width=3, message=FALSE, warning=FALSE, include=FALSE}
library(ggplot2);library(dplyr);data("mtcars")
f4 <- lm(mpg ~ am + drat +  cyl + vs + gear + carb, data = mtcars)
sqrt(vif(f4))
# remove cyl for high level of variance inflation
f5 <- lm(mpg ~ I(am + drat) + carb, data = mtcars)
sqrt(vif(f5))
x <- mtcars[,c(5,9,11)]
y <- mtcars$mpg
n <- length(y)
par(mfrow = c(2,1), mar = c(4,4,2,2)) # set margin
g <- ggplot(mtcars, aes(x = drat, am, carb, y = y),)
g <- g + xlab("(am + drat) + carb")
g <- g + ylab("Miles per g1allon")
g <- g + geom_smooth(aes(method = "lm", se = FALSE))
g <- g + geom_point(size = 3.0, col = "black", alpha = .65)
g
```
library(car)
library(datasets)
library(dplyr)
library(ggplot2)
library(graphics)
library(grDevices)
library(GGally)
library(knitr)
library(kernlab)
library(MASS)
library(xtable)
custom_car <- ggpairs(mtcars[, c("mpg", "wt", "cyl")], upper = "blank", title = "Custom Example")
# ggplot example taken from example(geom_text)
plot <- ggplot2::ggplot(mtcars, ggplot2::aes(x=wt, y=mpg, label=rownames(mtcars)))
plot <- plot +
        ggplot2::geom_text(ggplot2::aes(colour=factor(cyl)), size = 3) +
        ggplot2::scale_colour_discrete(l=40)
custom_car[1, 2] <- plot
personal_plot <- ggally_text(
        "ggpairs allows you\nto put in your\nown plot.\nLike that one.\n <---"
)
# custom_car[1, 3] <- personal_plot
# # custom_car
#
# # remove plots after creating a plot matrix
# custom_car[2,1] <- NULL
# custom_car[3,1] <- "blank" # the same as storing null
# custom_car[3,2] <- NULL
# custom_car


Removing the regressor disp in this model based on the appearance of an sinusoidal shape in the previous residual plot above resulting in a more random residual plot in this model (eliminating overfitting)
```{r Fig.9_ResidFit2, eval=FALSE, fig.height=4.5, fig.width=4.5, message=FALSE, warning=FALSE, include=FALSE, results='hide'}
y <- mtcars$mpg
x <- (as.numeric(mtcars$cyl) + mtcars$wt + as.numeric(mtcars$am))
n <- length(y)
fw <- lm(y ~ x, data = ordmtcars)
coef(summary(fw))
e <- resid(fw)# ;e;plot(e);sum(e)
plot(x,e,
     xlab = "cyl + disp + drat + hp wt + am",
     ylab = "Residuals (MPG)",
     bg = "lightblue",
     col = "black", cex = 2.5, pch = 21, frame = FALSE)
abline(h = 0, lwd = 2)
for(i in 1:n)
        lines(c(x[i], x[i]), c(e[i], 0), col = "red", lwd = 2)
```

Removing the regressor disp in this model based on the appearance of an sinusoidal shape in the previous residual plot above resulting in a more random residual plot in this model (eliminating overfitting)
```{r Fig.9_ResidFit2, eval=FALSE, fig.height=4.5, fig.width=4.5, message=FALSE, warning=FALSE, include=FALSE, results='hide'}
y <- mtcars$mpg
x <- (as.numeric(mtcars$cyl) + mtcars$wt + as.numeric(mtcars$am))
n <- length(y)
fw <- lm(y ~ x, data = ordmtcars)
coef(summary(fw))
e <- resid(fw)# ;e;plot(e);sum(e)
plot(x,e,
     xlab = "cyl + disp + drat + hp wt + am",
     ylab = "Residuals (MPG)",
     bg = "lightblue",
     col = "black", cex = 2.5, pch = 21, frame = FALSE)
abline(h = 0, lwd = 2)
for(i in 1:n)
        lines(c(x[i], x[i]), c(e[i], 0), col = "red", lwd = 2)
```

##########-----------------#############---------------################



Fig.1, Pairs
```{r Pairs Fig.1, echo=TRUE, fig.height=6, fig.width=6}
pairs(mtcars, main = "mtcars data")
coplot(mpg ~ disp | as.factor(cyl), data = mtcars,
       panel = panel.smooth, rows = 1)
```

Fig.2, Pairs
```{r Pairs Fig.2, echo=TRUE, fig.height=6, fig.width=6}
pairs(mtcars, main = "mtcars data")
coplot(mpg ~ hp | as.factor(cyl), data = mtcars,
       panel = panel.smooth, rows = 1)
```

Fig.2, Pairs
```{r Pairs Fig.2, echo=TRUE, fig.height=6, fig.width=6}
pairs(mtcars, main = "mtcars data")
coplot(mpg ~ hp | as.factor(cyl), data = mtcars,
       panel = panel.smooth, rows = 1)
```

Fig.2, Pairs
```{r Pairs Fig.2, echo=TRUE, fig.height=6, fig.width=6}
pairs(mtcars, main = "mtcars data")
coplot(mpg ~ wt | as.factor(cyl), data = mtcars,
       panel = panel.smooth, rows = 1)
```

----

        Fig.1, Pairs
```{r Pairs Fig.1, echo=TRUE, fig.height=6, fig.width=6}
pairs(mtcars, main = "mtcars data")
coplot(mpg ~ disp | as.factor(am), data = mtcars,
       panel = panel.smooth, rows = 1)
```

Fig.2, Pairs
```{r Pairs Fig.2, echo=TRUE, fig.height=6, fig.width=6}
pairs(mtcars, main = "mtcars data")
coplot(mpg ~ hp | as.factor(am), data = mtcars,
       panel = panel.smooth, rows = 1)
```

Fig.2, Pairs
```{r Pairs Fig.2, echo=TRUE, fig.height=6, fig.width=6}
pairs(mtcars, main = "mtcars data")
coplot(mpg ~ wt | as.factor(am), data = mtcars,
       panel = panel.smooth, rows = 1)
```
---

        Fig.2, Histograms
```{r Hist Fig.2, echo=TRUE, fig.height=6.5, fig.width=6.5}
data("mtcars");par(mfrow = c(2,1), mar = c(4,4,2,1)) # set margin
mtcars$vs <- factor(mtcars$vs, labels = c("V-block", "S-block")); mtcars$am <- factor(mtcars$am, labels = c("Auto", "Manual")); mtcars$gear <- factor(mtcars$gear); mtcars$carb <- factor(mtcars$carb)
head(mtcars,3)
hist(mtcars$mpg[mtcars$am=="Auto"], breaks=10, xlab = "Miles-Per-gallon", ylab = "Count", main = "Automatic Transmission", col = "yellow", xlim = range(5:40))
abline(v=mean(mtcars$mpg[mtcars$am=="Auto"]), col="red", lwd = 4)
hist(mtcars$mpg[mtcars$am=="Manual"], breaks=10, xlab = "Miles-Per-gallon", ylab = "Count", main = "Manual Transmission", col="lightblue", xlim = range(5:40))
abline(v=mean(mtcars$mpg[mtcars$am=="Manual"]), col="blue", lwd = 4)
```

Fig.3, Box Plots
```{r Box Plot Fig.3, echo=TRUE, fig.height=6, fig.width=6}
data("mtcars")
mtcars$vs <- factor(mtcars$vs, labels = c("V-block", "S-block")); mtcars$am <- factor(mtcars$am, labels = c("Auto", "Manual")); mtcars$gear <- factor(mtcars$gear); mtcars$carb <- factor(mtcars$carb)
head(mtcars,3)
boxplot(mpg ~ am, data = mtcars, col = (c("yellow","lightblue")), ylab = "Miles-Per-Gallon", xlab = "Transmission", main =  "Automatic vs Manual Transmission Miles Per Gallon")
```

Fig.4, Simple Linear Regression - Single Variable Plot
```{r SimpleLinearRegression Fig.4, echo=TRUE, results='hide', fig.height=6, fig.width=6,}
par(mfrow = c(2, 2), mar = c(4, 5, 2, 2));fslrm1 <- lm(mpg ~ am, data = mtcars);
coef(summary(fslrm)); plot(fslrm);fslrm2 <- lm(mpg ~ am - 1, data = mtcars);
coef(summary(fslrm)); plot(fslrm); plot(fslrm2)
```

Fig.5, Bivariate Linear Model Regression plot
```{r Bivariate Linear Model Regression Plot, echo=TRUE, results='hide', fig.height=6, fig.width=6}
data("mtcars")
par(mfrow = c(2, 2), mar = c(4, 5, 2, 1));fslrm <- lm(mpg ~ am, data = mtcars);
f2 <- lm(mpg ~ factor(am) + wt, data = mtcars);coef(summary(f2))
f3 <- lm(mpg ~ factor(am) * wt, data = mtcars);coef(summary(f3))
f4 <- lm(mpg ~ factor(am) + qsec, data = mtcars);coef(summary(f4))
f5 <- lm(mpg ~ factor(am) * qsec, data = mtcars);coef(summary(f5))
f6 <- lm(mpg ~ factor(am) + wt + qsec, data = mtcars);coef(summary(f6))
f7 <- lm(mpg ~ factor(am) * wt * qsec, data = mtcars);coef(summary(f7))
plot(f2);plot(f3);plot(f4);plot(f5);plot(f6);plot(f7)
```

Fig.6, MultivariateLM(allvars)Fig.6 - Residuals/Fitted/Residuals vs Fitted
```{r MultvariateLM(allvars)Fig.6, echo=TRUE, results='hide', fig.height=6.5, fig.width=6.5}
par(mfrow = c(2, 2), mar = c(4, 5, 2, 1))
mlr1 <- lm(mpg ~ ., data = mtcars);coef(summary(mlr1))
plot(mlr1);plot(mlr2)
```

Fig.7, Multivariate LM (all vars)-Residuals/Fitted/Residuals vs Fitted & Adjusted
```{r MultvariateLM(all vars)Fig.7, echo=TRUE, results='hide', fig.height=6.5, fig.width=6.5}
par(mfrow = c(2, 2), mar = c(4, 5, 2, 1))
mlr2 <- lm(mpg ~ . - 1, data = mtcars);coef(summary(mlr2))
```

Fig.8, Multivariate LM Nested Plot
```{r Nested_Fig.8, echo=FALSE, results='hide', fig.height=6, fig.width=6}
data("mtcars")
names(mtcars)
fn1 <- lm(mpg ~ cyl + disp, data = mtcars)
fn2 <- update(fn1, mpg ~ cyl + disp + hp)
fn3 <- update(fn1, mpg ~ cyl + disp + hp + drat)
fn4 <- update(fn1, mpg ~ cyl + disp + hp + drat + wt)
fn5 <- update(fn1, mpg ~ cyl + disp + hp + drat + wt +  qsec)
fn6 <- update(fn1, mpg ~ cyl + disp + hp + drat + wt +  qsec + vs)
fn7 <- update(fn1, mpg ~ cyl + disp + hp + drat + wt +  qsec + vs +  am)
fn8 <- update(fn1, mpg ~ cyl + disp + hp + drat + wt +  qsec + vs +  am +  gear)
fn9 <- update(fn1, mpg ~ cyl + disp + hp + drat + wt +  qsec + vs +  am +  gear + carb)
anova(fn1, fn2, fn3, fn4, fn5, fn6, fn7, fn8, fn9)
```


61226 deleted from main rmd document



Executive Summary:

Problem Statement & Questions to Answer:
        Assumptions:
        The given data set (a sample of a larger population) for this analysis consists of (iid) independent and identically                                distrubuted random varialbles for 32 subjects (vehicles) of 11 observations or variables.
Questions off interest to the Motor Trend Magazine are:
        Q1 “Is an automatic or manual transmission better for 'mpg'”
or which type of tramsmission is associated with better mph or gas mileage ratings?
Q2 "Quantify the MPG difference between automatic and manual transmissions"
or assuming there is an associated difference in mpg ratings between manual and automatic type transmissions then:
        What is the expected difference and how accurate is this estimate based on the given data?


---

        #       Analysis Considerations:
        Assumptions:
        Given data set for this analysis consists of independent and identically distrubuted random varialbles iid for 32 vehicles or subjects with 11 variables or observations

Descriptive - (dim, mean, sd, sigma^2, str & summary) statistics

Exploratory - pairs, histograms, QQ, fitted, residualplots, boxplots
& (multiple plots); T-Test

Analysis -  OLS, simple linear regression, statistical linear regression,
multivariate regression & model selection, logistic regression, pValues,
adjustments, residuals, residual fit, predict fit, hatvalues, variance, & dfbetas, R^2,
diagnostics; ANOVA, coeficients, confint, correlation, covariance, variance inflation



#       Software Environment: &  System - session Info:
Set the Working Directory then get System & Session Info
```{r SetDirectory, eval=FALSE, include=FALSE, results='hide'}
setwd("~/Desktop/Coursera_R/7_Regression Models/RM_proj_MPG_MotorTrendData")
sessionInfo()
```

#       Raw Data: Motor Trend 'mtcars' data set:
Clean up the work space & import the data from the data sets package
```{r Data_mtcars, include=FALSE, results='hide'}
rm(list=ls());library(car);library(dplyr); data("mtcars");any(is.na(mtcars));data(mtcars)
```
A data frame with 32 observations on 11 variables.

[, 1]	mpg	Miles/(US) gallon
[, 2]	cyl	Number of cylinders (4,6,8)
[, 3]	disp	Displacement (cu.in.)
[, 4]	hp	Gross horsepower
[, 5]	drat	Rear axle ratio
[, 6]	wt	Weight (1000 lbs)
[, 7]	qsec	1/4 mile time
[, 8]	vs	V/S (V = vee-block, S = straight-block)
[, 9]	am	Transmission (0 = automatic, 1 = manual)
[,10]	gear	Number of forward gears (3,4,5)
[,11]	carb	Number of carburetors (1,2,3,4,6,8)


#       Process Data:
Factor columns 2 & 8:11 (cyl,vs,am,gear,carb) and order the data on mpg from the lowest to highest mpg rating
```{r ProcessData, echo=FALSE, eval=TRUE, cache=TRUE, message=TRUE, warning=TRUE, cache=TRUE, include=FALSE, results='hide'}
data("mtcars");
for(i in c(2,8:11))mtcars[,i] <- as.factor(mtcars[,i]);str(mtcars);ordmtcars <<- mtcars[order(mtcars$mpg,decreasing = FALSE),];ordmtcars
```

#       Descriptive Statistics
Reveiw data set for obvious visual patterns or trends using descriptive statistics r code to generate pairs plots, histograms and boxplots see Appendix A below for more information
```{r DescriptiveStats, echo=FALSE, message=FALSE, warning=FALSE, results='hide'}
str(ordmtcars);summary(ordmtcars);ordmtcars
```


#       Exploratory Analysis:
Develop the r code for analyzing and identify any significant relationships /
        correlations between the range of mpg ratings and any of the other ten varialbes
for observations contained in the data set. Use avaialbe regression model tools
to find the best model fit, examine the coefficients, hatvalues, residuals, dfbetas, variance inflation, and R^2 values to spot over or underfitting of the
model.

Next, we can check for the correlation between mpg and the other ten regressors and learn that the weight variable has the highest single correlation to mpg that any of the other single varialbes at (-95.45%) using the ordered data set "ordmtcars".
```{r correlation, eval=FALSE, include=FALSE}
cor(ordmtcars$mpg, ordmtcars$wt)
```

#       Statistical Modeling:
Assumptions:
        A
B
##              Simple Linear Regression Plot
In this plot we examine the relationship between mpg ratings and vehicle weight and find that as mpg rating increases vehicle weight decreases.
```{r Fig.4_SimpleLR, echo=TRUE, eval=c(5:12), fig.height=3.5, fig.width=3.5, message=FALSE, warning=FALSE}
library(dplyr)
ordmtcars$am <- factor(ordmtcars$am, labels = c("Auto", "Manual"))
f1 <- lm(mpg ~ factor(am), data = ordmtcars)
coef(summary(f1))
library(ggplot2)
par(mfrow = c(2,1), mar = c(4,4,2,2)) # set margin
g <- ggplot(ordmtcars, aes(x = factor(am), y = mpg),)
g <- g + xlab("Transmission Type")
g <- g + ylab("Miles per Gallon")
g <- g + geom_point(size = 4.0, col = "blue", alpha = .45)
g <- g + geom_abline(intercept = 9.91, slope = 7.24) # intercept adjusted (-7.24) to fit grid
g
```


##              Bivariate Linear Model: # Note: manual trans & eng shape / vs are significant
First, using r command plot(f2) plot the four series plor for Reiduals vs Fitted, Normal QQ, Scale Location, and Residuals vs Leverage diagnostics plots of the bivariate model using; as.numeric(am) + wt.

Next, check coefficients summary (f2), hatvalues(f2),vif(f2), & sqrt(vif(f2)) for
indications of poor model fit

Additionaly, check indluence.measures on (f2) as see that the Cadilac Fleetwood, Lincoln Continental, Chrysler Imperial and the Fiat 128 exhibit influence on the model fit (f2).

Finally, fit a bivariate linear regression model using as.numeric(am) & wt.
```{r Fig.5_BivariateLM, echo=FALSE, fig.height=6, fig.width=6, message=FALSE, warning=FALSE, results='hide'}
f2 <- lm(mpg ~ as.numeric(am) + wt, data = ordmtcars)
plot(f2)
hatvalues(f2);coef(summary(f2));vif(f2);sqrt(vif(f2))
par(mfrow = c(2, 2), mar = c(4,4,4,2))
g <- ggplot(mtcars, aes(x = as.numeric(am) + wt , y = mpg),)
g <- g + xlab("Transmission Type + Weight")
g <- g + ylab("Miles per Gallon")
g <- g + geom_point(size = 3.5, col = "blue", alpha = .65)
g <- g + geom_smooth(aes(method = "lm", se = FALSE))
g
```


##      Multivariate Linear Model (all vars)

The influence measures test indicates that the following vehicles exhibit
substatial influence on the model fit; "Merc 230","Merc 280", "Honda Civic",
"Camaro Z28","Porsche 914-2","Ford Pantera L","Ferrari Dino","Maserati Bora"
based on the cov.r (covariance ratio) at 2.809 or above

```{r Fig.6_MVLM(allvars), eval=FALSE, fig.height=4, fig.width=4, message=FALSE, warning=FALSE, include=FALSE, results='hide'}
data("mtcars")
f3 <- lm(mpg ~ ., data = mtcars)
confint(f3)
coef(summary(f3))
vif(f3)
sqrt(vif(f3))
par(mfrow = c(1, 1), mar = c(4,4,4,2))
g <- ggplot(mtcars, aes(x = (cyl + disp + hp + drat + wt + qsec + vs + am + gear + carb), y = mpg),)
g <- g + xlab("All Design Components Included")
g <- g + ylab("Miles per Gallon")
g <- g + geom_smooth(aes(method = "lm", se = FALSE))
g <- g + geom_point(size = 2.5, col = "black", alpha = .85)
g
#
par(mfrow = c(2,2), mar = c(4,4,4,2))
plot(f3)
```


#       Multivariate Linear Model (all vars) Adjusted:
```{r Fig.7a_MVLM(allvars)_Adjusted, echo=FALSE,  eval=c(1,2,5:12), fig.align='center', fig.height=7,fig.width=9, message=FALSE, warning=FALSE, include=FALSE, results='hide'}
library(car);library(ggplot2)
f6 <- lm(mpg ~ . -1, data = ordmtcars)
coef(summary(f6))
confint(f6)
par(mfrow = c(1,1), mar = c(4,4,2,2)) # set margin
g <- ggplot(mtcars, aes(x = cyl, disp, hp, drat, wt, qsec, vs, am, gear, carb, am, -1, y = mpg),)
g <- g + xlab("Multivariate(allvars)- Adjusted to Intercept")
g <- g + ylab("Miles per Gallon")
g <- g + geom_smooth(aes(method = "lm", se = FALSE))
g <- g + geom_point(aes(shape = factor(am), size = 4.0))
g <- g + geom_point(aes(colour = factor(cyl)))
g
```


Removing the am (transmission type) variable from the multivariate linear
regression using all other varialbes the results appear to be identical; meaing
that am or transmission type does not influence mpg ratings in any significant
way.


```{r Fig.7b_MVLM(allvars,-am), eval=FALSE, fig.height=4, fig.width=4, message=FALSE, warning=FALSE, include=FALSE, results='hide'}
data("mtcars")
mtcars2 <- subset(mtcars, select = -am)
mean(mtcars2$mpg)
f4 <- lm(mpg ~ ., data = mtcars2)
confint(f4)
coef(summary(f4))
vif(f4)
sqrt(vif(f4))
par(mfrow = c(1, 1), mar = c(4,4,4,2))
g <- ggplot(mtcars2, aes(x = (cyl + disp + hp + drat + wt + qsec + vs + gear + carb), y = mpg),)
g <- g + xlab("All Design Components - am")
g <- g + ylab("Miles per Gallon")
g <- g + geom_smooth(aes(method = "lm", se = FALSE))
g <- g + geom_point(size = 2.5, col = "orange", alpha = .85)
g
par(mfrow = c(2,2), mar = c(4,4,4,2))
plot(f4)
```


##      Multivariate LM Nested & ANOVA table
Using a nested model approach, followed by checking for variance inflation
using the command vif we can see that cyl, disp & hp

```{r Fig.8_MVLM_ANOVA_table, message=FALSE, warning=FALSE, include=FALSE, results='hide'}
fn1 <- lm(mpg ~ factor(am), data = mtcars)
fnm2 <- update(fn1, mpg ~ cyl + disp)
fnm3 <- update(fn1, mpg ~ cyl + disp + hp + drat)
fnm4 <- update(fn1, mpg ~ cyl + disp + hp + drat + wt +  qsec)
fnm5 <- update(fn1, mpg ~ cyl + disp + hp + drat + wt +  qsec + vs + am)
fnm6 <- update(fn1, mpg ~ cyl + disp + hp + drat + wt +  qsec + vs + am + gear + carb)
anova(fn1, fnm2, fnm3, fnm4, fnm5, fnm6)
vif(fnm6)
vif(fnm4)
sqrt(vif(fnm4))
confint(fnm4)
par(mfrow = c(2,2), mar = c(4,4,4,2))
plot(fnm4)
```


#       Multivarite Linear Model Finding Best Fit with Step function:
```{r MVLM_Step_R^2, echo=TRUE, eval=TRUE, cache=TRUE, include=TRUE, results='asis'}
library(stats);library(MASS)
fstp <- lm(mpg ~ ., data = mtcars)
stp <- step(fstp, trace = FALSE)
coef(summary(stp))
summary(stp)$r.squared
```


Based on the nested modeling process followed by the anova table check then
followed by the vif and sqrt(vif) test and the step function we decide to go
with the following model labeled (fstp)
```{r Fig.9a_BestFitModeling, eval=FALSE, fig.height=5, fig.width=5, message=TRUE, warning=TRUE, include=FALSE, results='hide'}
data("mtcars");library(car);library(ggplot2);library(graphics)
stp
mtc <- mtcars
mtc$am <- c("0" = "automatic", "1" = "manual")[as.character(mtc$am)]
x <- (mtc$wt + mtc$qsec + mtc$am)
par(mfrow = c(1,1), mar = c(4,4,2,2)) # set margin
g <- ggplot(mtc, aes(x = x, y = mpg),)
g <- g + xlab("(wt + qsec + am)")
g <- g + ylab("Miles per Gallon")
g <- g + geom_smooth(method = "loess")
g <- g + geom_point(aes(shape = factor(am), size = wt, colour = qsec, alpha = .85))
g
```


#       Preliminary Findings:
Questions of Interest:
A What other regressors if any correlated with mpg rating and transmission type?
B
Interpretation of Results:
A Using ANOVA table with Nested Multivariate Regression fit it is clear that the variable weight (wt) is significance according with a code of ** = 0.001
B Based on the
C
---
#       Appendix A: Figures for the "Exploratory Analysis"

##      Pairs Plot:
Interpretation: MPG decreases as the; # of cylinders increases, the engine
displacement increases, the horsepower increases, the weight increases, the rear
axle ratio decreases, qsec time decreases, the engine is a V-block, # of gears
decreases, and the # of carburators increases ~ conversely the MPG increases as
the: rear axle ratio increases, qsec time increases, the engine is a
Straight-block, transmission is manual, # of gears increases and the # of
carburators decreases


```{r Fig.1_Pairs, echo=FALSE, fig.align='center', fig.height=5, fig.width=6.5, message=FALSE, warning=FALSE}
panel.cor <- function(x, y, digits = 2, prefix = "", cex.cor, ...)
{
        usr <- par("usr"); on.exit(par(usr))
        par(usr = c(0, 1, 0, 1))
        r <- abs(cor(x, y))
        txt <- format(c(r, 0.123456789), digits = digits)[1]
        txt <- paste0(prefix, txt)
        if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
        text(0.5, 0.5, txt, cex = cex.cor * r)
}
pairs(mtcars[1:11], lower.panel=panel.smooth, upper.panel = panel.cor, cex=1.5, pch=20, col="lightblue", cex.labels=2, font.lables =2, main = "MPG mtcars data")
```

##      Histogram:
```{r Fig.2_Hist, echo=FALSE, fig.align='center', fig.height=4.0, fig.width=6.5}
data(mtcars)
par(mfrow = c(2,1), mar = c(4,4,4,4)) # set margin
mtcars$vs <- factor(mtcars$vs, labels = c("V-block", "S-block")); mtcars$am <- factor(mtcars$am, labels = c("Auto", "Manual")); mtcars$gear <- factor(mtcars$gear); mtcars$carb <- factor(mtcars$carb)
hist(mtcars$mpg[mtcars$am=="Auto"], breaks=10, xlab = "Miles-Per-gallon", ylab = "Frequency", main = "Automatic Transmission", col = "yellow", xlim = range(5:40))
abline(v=mean(mtcars$mpg[mtcars$am=="Auto"]), col="red", lwd = 4)
hist(mtcars$mpg[mtcars$am=="Manual"], breaks=10, xlab = "Miles-Per-gallon", ylab = "Frequency", main = "Manual Transmission", col="lightblue", xlim = range(5:40))
abline(v=mean(mtcars$mpg[mtcars$am=="Manual"]), col="blue", lwd = 4)
```

##      Box Plot:
```{r Fig.3_BoxPlot, echo=FALSE, fig.align='center', fig.height=4, fig.width=6.5}
data("mtcars");par(mfrow = c(1,1), mar = c(4,4,4,4))
mtcars$vs <- factor(mtcars$vs, labels = c("V-block", "S-block")); mtcars$am <- factor(mtcars$am, labels = c("Auto", "Manual")); mtcars$gear <- factor(mtcars$gear); mtcars$carb <- factor(mtcars$carb)
boxplot(mpg ~ am, data = mtcars, col = (c("yellow","lightblue")), ylab = "Miles-Per-Gallon", xlab = "Transmission", main =  "Automatic vs Manual Transmission, Miles Per Gallon Ratings")
```


===
END
===




