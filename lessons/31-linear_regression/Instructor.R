###########
## Session 3: Linear Regression
###########

library(tidyverse)

## Question 1a 
datsmoke <- read_csv("data/smokePregnant.csv")

## Question 1b
datsmoke2 <- data.frame(errors=c(datsmoke$Nicotine,datsmoke$Control), treatment=rep(c("Nicotine","Control"),each=nrow(datsmoke)))
# library(reshape); dat2 <- melt(dat)

## Question 1c
## We previously saw that a log transformation helped
boxplot(datsmoke2$errors ~ datsmoke2$treatment)

boxplot(log(datsmoke2$errors) ~ datsmoke2$treatment, main = "Comparative boxplots of # of errors by treatment", ylab = "# of errors", xlab = "Treatment")
## Better

fit.smoke=lm(log(errors)~as.factor(treatment),data=datsmoke2)
summary(fit.smoke)


## Question 1d
datsmoke2$numericTreatment <- factor(rep(c(1,0), each=nrow(datsmoke)))
fit.smoke1 <- lm(log(errors) ~ numericTreatment, data = datsmoke2)
summary(fit.smoke1)

t.test(log(datsmoke$Nicotine), log(datsmoke$Control), var.equal=T)

## Question 1e
## Observations are independent; random sample of GPs and and random allocation of treatments
## observations are normally distributed with same variance in both groups
## Straight line relationship but this is not a concern here since there are only two x-values

plot(fit.smoke1)

## Question 2a

#catchment <- c(29,49,28,8,57,9,31,10,21,26,31,52,21,8,18,5,18,26,27,26)
#quality <- c(61,85,46,53,55,71,59,41,82,56,39,89,32,43,29,55,81,82,82,85)
#write.table(data.frame(catchment, quality), file = "waterQual.txt", row.names = F)

datqual <- read_csv("data/waterQual.csv")
head(datqual)


## Question 2b-c
## Inference; estimating a parameter i.e., slope of regression line for quality regressed against catchment area
## Two variables; both quantitative continuous

## Question 2d
plot(datqual$catchment, datqual$quality, xlab="Water catchment area", ylab="Water quality (IBI)", pch=19, main = "Scatterplot of water quality against catchment area")

## Question 2e
## Use linear regression, the slope describes the strength of the relationship. 
fit.qual1 <- lm(quality ~ catchment, data = datqual)
summary(fit.qual1)


plot(datqual$catchment, datqual$quality, xlab="Water catchment area", ylab="Water quality (IBI)", pch=19, main = "Scatterplot of water quality against catchment area")

abline(fit.qual1, lwd = 3)

## Question 2f
summary(fit.qual1)
confint(fit.qual1)

## Question 2g
## Observations were independent; random sampling of creek locations
## Residuals are normally distributed with same variance for each value of catchment area (predictor)
## Straight line relationship between water quality and catchment area


plot(fit.qual1)








## construct residual plot, add 0 line
plot(fit.qual1$fit, fit.qual1$res, xlab="Fitted values", ylab="Residuals", lwd=3, pch=19)
abline(0,0,lwd=3)
## construct qq plot
qqnorm(fit.qual1$res, lwd=3, pch=19, main="Normal quantile plot for water quality data", ylab="Regression residuals")
qqline(fit.qual1$res)
     
#par(mfrow = c(2,2))
plot(fit.qual1)

###############


