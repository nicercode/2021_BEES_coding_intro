# ###########
# ## Session 4: Weirder linear models
# ###########


#install.packages(c("dplyr", "reshape2"))
library(reshape2)
library(dplyr)

# Import the bird data
birds <- read.csv("data/birdCountYear.csv", head=TRUE)
colnames(birds) <- c("site", "1992", "2002", "2012")
birds <- melt(birds)
colnames(birds)[2] <- 'year'
birds$year <- birds$year %>% as.character 
plot(y=log(birds$value+1), x=birds$year, col=birds$site, pch=20, cex=2)

anova(lm(value~., data=birds))



habitat <- read.csv("data/HabitatConfig.csv", head=TRUE)

plot(y=habitat$Total, x=habitat$Wmass, log='xy', col=as.factor(habitat$Dist), xlab='wet mass (kg)', ylab='count per gram of seaweed', pch=20)
legend(x="topright", legend=unique(habitat$Dist), col=1:3, bty='n', pch=20)

plot(y=habitat$Total, x=habitat$Wmass, log='xy', col=as.factor(habitat$Time), xlab='wet mass (kg)', ylab='count per gram of seaweed', pch=20)
legend(x="topright", legend=unique(habitat$Time), col=1:2, bty='n', pch=20)

###########################
## Question 1a
rm(list = ls())
dathabconf <- read.csv("data/HabitatConfig.csv", head=TRUE)
dathabconf$Dist <- factor(dathabconf$Dist)
dathabconf$Size <- factor(dathabconf$Size)
dathabconf$Time <- factor(dathabconf$Time)
## NO subsetting done here. Consequently, answers will be different to question 3 of session 2

## Question 1b-c
## inference; testing whether density is related with distance and whether it changes with two other covariates
## More than two variables; response is quantitative and all covariates as categorical

## Question 1d
par(mfrow = c(1,2))
boxplot(dathabconf$Total)
boxplot(log(dathabconf$Total))
## Encouraged to use a log transformation

boxplot(Total~Dist*Time*Size,data=dathabconf,log="y",xlab="",ylab="Density [log scale]",las=2)
## Hard to see what's going on!

par(mfrow = c(2,1))
boxplot(Total~Dist*Time,data=dathabconf,xlab="Time.Dist",ylab="Density [log scale]",log="y",las=2)
boxplot(Total~Dist*Size,data=dathabconf,xlab="Time.Size",ylab="Density [log scale]",log="y",las=2)

## Question 1e
fit.habconf1 <- lm(Total~Dist, data=dathabconf) 
anova(fit.habconf1)

par(mfrow = c(2,2)); 
plot(fit.habconf1)
## Mean-variance trend (large variance at larger densities) so futher support for log transform

fit.habconf1aov <- aov(log(Total)~Dist, data=dathabconf)
summary(fit.habconf1aov)
TukeyHSD(fit.habconf1aov)

par(mfrow = c(2,2)); 
plot(fit.habconf1aov)
## not perfect but a better

## Illstration of Factorial design and model selection in action! Fit a three-way ANOVA and do backward elimination
fit.habconffull <- aov(log(Total)~Dist*Time*Size, data=dathabconf)
summary(fit.habconffull)

fit.habconf3 <- aov(log(Total)~(Dist + Time + Size)^2, data=dathabconf)
summary(fit.habconf3)

fit.habconf4 <- aov(log(Total)~ Dist*Time + Dist*Size, data=dathabconf)
summary(fit.habconf4)

fit.habconf5 <- aov(log(Total)~ Dist*Time + Size, data=dathabconf)
summary(fit.habconf5)

fit.habconf6 <- aov(log(Total)~ Dist*Time, data=dathabconf)
summary(fit.habconf6)
anova(fit.habconf6, fit.habconf5) ## Suggests size is probably droppable

fit.habconffinal <- aov(log(Total)~ Dist*Time, data=dathabconf)
summary(fit.habconffinal)

## Question 1f
## The usual assumptions regarding ANOVA are made everywhere above, but since model selection is involved then our concern is whether these assumptions are satisfied for the FINAL model chosen

par(mfrow = c(2,2))
plot(fit.habconffinal)
## OK

## Question 1g-h
summary(fit.habconffinal)
TukeyHSD(fit.habconffinal,which="Dist")

par(mfrow = c(1,1))
tft=TukeyHSD(fit.habconffinal,which=c("Dist:Time"))
par(mar = c(6,6,4,1))
plot(tft,las=1)
## So density definitely changes with distance, and the relationship doesn't with sampling size but does vary with sampling time. 

## A more informative result can also be obtained via an interaction plot using on final model 
par(mfrow = c(1,1));
interaction.plot(dathabconf$Dist, dathabconf$Time, fit.habconffinal$fitted, xlab="Isolation of patch", ylab="Total density [log scale]", trace.label="Time (weeks)")
## Similar shapes of the two lines suggests that interaction between Distance and Time is mild, which corresponds with the p-value in fit.habconffinal


## Question 1i - Wetmass is a "blocking factor" , so we put this covariate first after the "~"
fit.wethabconf <- aov(log(Total)~Wmass*Dist,data=dathabconf)
summary(fit.wethabconf)

fit.wethabconf2 <- aov(log(Total)~Wmass + Dist,data=dathabconf)
summary(fit.wethabconf2)
## Overall conclusion is not changed. That is, after accounting for wet mass, Distance is still significantly related to Density. Wet mass also an additive effect. This can also be seen below.

plot(dathabconf$Total~dathabconf$Wmass, col=as.numeric(dathabconf$Dist), log="xy", xlab="Wet Mass [log scale]", ylab="Density (per gram) [log scale]")
legend("topright", levels(dathabconf$Dist), col=1:3)

fit.wethabconffinal <- aov(log(Total)~ Wmass + Dist*Time, data=dathabconf)
summary(fit.wethabconffinal)

## Interaction is now significant at a 5% level, but conclusions are not changed dramatically
interaction.plot(dathabconf$Dist, dathabconf$Time, fit.wethabconffinal$fitted, xlab="Isolation of patch (m)", ylab="Total density (per gram) [log scale]", trace.label="Time (weeks)")

tft=TukeyHSD(fit.wethabconffinal,which=c("Dist:Time"))
par(mar = c(6,6,4,1))
plot(tft,las=1)




# ## Question 2a
##rm(list = ls())
##datbird <- read.csv("data/birdCountYear.csv", header = T)

# #dathost$Genus <- factor(dathost$Genus) 
# 
# ## Question 1b-c
# ## IT'S HARD TO WORK OUT WHAT WE WANT HERE. AFTER THINKING FOR A WHILE, IT TURNS WE WANT...
# ## inference; testing whether the count of genera varies with genus, with studies as a blocking factor
# ## More than two variables, with a response as a count
# 
# ## Question 1d
# par(mfrow = c(1,2))
# boxplot(dathost$Genera, main = "Boxplot of Genera counts")
# boxplot(dathost$Studies, main = "Boxplot of Studies counts")
# ## Counts almost always warrant a transformation. The right-skewed nature of the response is further justification. 
# ## Because there are zero counts, you could use a log rather than a log(1+x), or sqrt(), but let's go with the master on this one
# ## In addition, studies is also a count and right skewed, so we might as well transform it as well
# 
# dathost$lGenera=log(dathost$Genera+1)
# dathost$lStudies=log(dathost$Studies+1)
# 
# boxplot(dathost$lGenera ~ dathost$Genus, xlab = "Genus", ylab = "Host count", main = "Comparative boxplot of host count versus crustacean genus")
# 
# ## An even better plot 
# par(mfrow=c(1,1))
# plot((dathost$Genera+1)~(dathost$Studies+1), log="xy", col=as.numeric(dathost$Genus), xlab="# studies + 1", ylab = "Host count + 1")
# legend("bottomright", levels(dathost$Genus), col=1:4)
# ## Just from the graph, we can see a difference in counts between genus even after accounting for # studies 
# 
# ## Question 1e
# fit.host1 <- aov(lGenera~lStudies + Genus, data=dathost) ## ANCOVA time...but then again it's just a linear model!
# summary(fit.host1)
# 
# ## Question 1f
# ## Observations are independent conditional on x; random sample for meta-analysis
# ## Transformed response is normally distributed with a constant variance (challenging to think what this actually means!)
# ## linear relationship between transformed host counts and covariates
# 
# plot(fit.host1)
# ## All assumptions appear to be OK.
# 
# ## Question 1g-h
# summary(fit.host1)
# TukeyHSD(fit.host1, which="Genus")
# 
