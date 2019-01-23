###########
## Session 4: Linear Models
###########
## Question 1a

library(car)
library(tidyverse)

data_height <- read_csv("data/plantHeightSingleSpp.csv")

## Question 1b-c
## Inference; testing whether latitude variation in plant height can be explained by rainfall
## That is, after accounting for rainfall, does latitude still exhibit any relationship to height?
## More than two variables; all quantitative

## Question 1d-g
plot(data_height$lat, data_height$height, ylab = "Height", xlab = "Latitude", main = "Scatterplot of plant height versus latitude")

fit.height1 <- lm(height ~ rain + lat, data=data_height) ## Notice how I enter rain first, as I wantr to account or control for rainfall.
summary(fit.height1)
anova(fit.height1)

vif(fit.height1) ## No values near 5-10 so no big concern
cor(cbind(data_height$lat, data_height$rain))

## Observations were independent conditional on x; random sampling of plants
## Residuals are normally distributed with same variance
## height is linear related to latitude and rain

plot(fit.height1)
## Seems to be heteroscedascity and right skewed residuals. This is not surprising if you just consider a QQ plot of height
par(mfrow =  c(1,2))
qqnorm(data_height$height); qqline(data_height$height)
qqnorm(log(data_height$height)); qqline(log(data_height$height))
## Consider a log transformation of height. The transformation is inherently useful anyway as it removes the boundary at 0 (which many of the measurements are pushed up against if you look at the marginal plot)

fit.height2 <- lm(log(height) ~ rain + lat, data = data_height)
par(mfrow = c(2,2))
plot(fit.height2)
## Things are much better now; multicollinearity will not have changed, so nothing to worry about here still 
summary(fit.height2)
anova(fit.height2)

## Question 1h-i 
summary(fit.height2)
confint(fit.height2)

## A partial residual plot is a better way to visualize the problem here, to look at how height varies with latitude after accounting for rain
par(mfrow = c(1,1))
#avPlots(fit.height2, terms = ~lat, xlab="Latitude", ylab="Height|rain", grid=F, main = "Partial residual plot of plant height versus latitude")
crPlots(fit.height2, terms = ~lat, xlab="Latitude|rain", ylab="Height|rain", grid=F, main = "Partial residual plot of plant height versus latitude, given rain", smooth = F)

summary(fit.height2)
anova(fit.height2)
confint(fit.height2)

## Question 1j
fit.clim1 <- lm(log(height) ~ rain + temp, data=data_height)
fit.clim2  <- lm(log(height)~ rain + temp + lat, data=data_height)
anova(fit.clim1, fit.clim2)

summary(fit.clim2)

par(mfrow = c(2,2))
plot(fit.clim2)
## OK

vif(fit.clim2) ## Worse but not ridiculously large; the damage is due to correlation between temp and lat, as one can see from the matrix of correlations
cor(cbind(data_height$lat, data_height$rain, data_height$temp))

par(mfrow = c(1,1))
crPlots(fit.clim2, terms = ~lat, xlab="Latitude", ylab="Height|rain + temp",grid=F,smooth=F)

summary(fit.clim2)
anova(fit.clim2)
confint(fit.clim2)
## Contrasting conlcusions to the model with rainfall alone

###########################

## Question 2a-b
rm(list = ls())
data_habitat <- read_csv("data/HabitatConfig.csv") %>%
	filter(Size == "SMALL" & Time == 10) %>% 
	mutate(Dist = as.factor(Dist))

## Question 2c-d
## Inference; testing of whether density changes with distance of isolation
## Two variables; covariate is categorical and response is quantitative

## Question 2e
plot(data_habitat$Total~data_habitat$Dist, xlab = "Distance", ylab = "Density", main = "Comparative boxplot of invertebrate density versus isolation distance")

## Question 2f-h
fit.habconf1 <- lm(Total~Dist, data=data_habitat)
anova(fit.habconf1)

## Observations are independent conditional on x; random sampling of sites 
## Observations are normally distributed with same variance each of the isolation distances
## Straight line relationship not of concern here at there are only two points on each x axes

par(mfrow = c(2,2))
plot(fit.habconf1)
## Clear mean-variance trend (large variance at larger densities), so it's transformation time. This is even clearer in the scale-location plot

fit.habconf2 <- lm(log(Total)~Dist, data=data_habitat)
summary(fit.habconf2)
anova(fit.habconf2)

par(mfrow = c(2,2))
plot(fit.habconf2)
## Slightly Better but not great in terms of residual analysis...oh well


## Question 2i
library(multcomp)
contDist = mcp(Dist="Tukey") # telling R to compare on the Dist factor
compDist = glht(fit.habconf2, linfct=contDist) # now run multiple comparisions
summary(compDist) # present a summary of the results
confint(compDist)
plot(compDist)

