# ###########
# ## Session 4: Weirder linear models
# ###########

library(tidyverse)

# Import the bird data
data_birds_raw <- read_csv("data/birdCountYear.csv")
data_birds <- gather(data_birds_raw, key="year", value= "counts", `1992`, `2002`, `2012`)
plot(y=log(data_birds$counts+1), x=data_birds$year, col=as.factor(data_birds$site), pch=20, cex=2)

anova(lm(counts~., data=data_birds))



data_habitat <- read_csv("data/HabitatConfig.csv")

plot(y=data_habitat$Total, x=data_habitat$Wmass, log='xy', col=as.factor(data_habitat$Dist), xlab='wet mass (kg)', ylab='count per gram of seaweed', pch=20)
legend(x="topright", legend=unique(data_habitat$Dist), col=1:3, bty='n', pch=20)

plot(y=data_habitat$Total, x=data_habitat$Wmass, log='xy', col=as.factor(data_habitat$Time), xlab='wet mass (kg)', ylab='count per gram of seaweed', pch=20)
legend(x="topright", legend=unique(data_habitat$Time), col=1:2, bty='n', pch=20)

###########################
## Question 1a
data_habitat <- data_habitat %>%
  mutate(Dist = as.factor(Dist),
        Size = as.factor(Size),
        Time = as.factor(Time))
## NO subsetting done here. Consequently, answers will be different to question 3 of session 2

## Question 1b-c
## inference; testing whether density is related with distance and whether it changes with two other covariates
## More than two variables; response is quantitative and all covariates as categorical

## Question 1d
par(mfrow = c(1,2))
boxplot(data_habitat$Total)
boxplot(log(data_habitat$Total))
## Encouraged to use a log transformation

boxplot(Total~Dist*Time*Size,data=data_habitat,log="y",xlab="",ylab="Density [log scale]",las=2)
## Hard to see what's going on!

par(mfrow = c(2,1))
boxplot(Total~Dist*Time,data=data_habitat,xlab="Time.Dist",ylab="Density [log scale]",log="y",las=2)
boxplot(Total~Dist*Size,data=data_habitat,xlab="Time.Size",ylab="Density [log scale]",log="y",las=2)

## Question 1e
fit.habconf1 <- lm(Total~Dist, data=data_habitat) 
anova(fit.habconf1)

par(mfrow = c(2,2)); 
plot(fit.habconf1)
## Mean-variance trend (large variance at larger densities) so futher support for log transform

fit.habconf1aov <- aov(log(Total)~Dist, data=data_habitat)
summary(fit.habconf1aov)
TukeyHSD(fit.habconf1aov)

par(mfrow = c(2,2)); 
plot(fit.habconf1aov)
## not perfect but a better

## Illstration of Factorial design and model selection in action! Fit a three-way ANOVA and do backward elimination
fit.habconffull <- aov(log(Total)~Dist*Time*Size, data=data_habitat)
summary(fit.habconffull)

fit.habconf3 <- aov(log(Total)~(Dist + Time + Size)^2, data=data_habitat)
summary(fit.habconf3)

fit.habconf4 <- aov(log(Total)~ Dist*Time + Dist*Size, data=data_habitat)
summary(fit.habconf4)

fit.habconf5 <- aov(log(Total)~ Dist*Time + Size, data=data_habitat)
summary(fit.habconf5)

fit.habconf6 <- aov(log(Total)~ Dist*Time, data=data_habitat)
summary(fit.habconf6)
anova(fit.habconf6, fit.habconf5) ## Suggests size is probably droppable

fit.habconffinal <- aov(log(Total)~ Dist*Time, data=data_habitat)
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
interaction.plot(data_habitat$Dist, data_habitat$Time, fit.habconffinal$fitted, xlab="Isolation of patch", ylab="Total density [log scale]", trace.label="Time (weeks)")
## Similar shapes of the two lines suggests that interaction between Distance and Time is mild, which corresponds with the p-value in fit.habconffinal


## Question 1i - Wetmass is a "blocking factor" , so we put this covariate first after the "~"
fit.wethabconf <- aov(log(Total)~Wmass*Dist,data=data_habitat)
summary(fit.wethabconf)

fit.wethabconf2 <- aov(log(Total)~Wmass + Dist,data=data_habitat)
summary(fit.wethabconf2)
## Overall conclusion is not changed. That is, after accounting for wet mass, Distance is still significantly related to Density. Wet mass also an additive effect. This can also be seen below.

plot(data_habitat$Total~data_habitat$Wmass, col=as.numeric(data_habitat$Dist), log="xy", xlab="Wet Mass [log scale]", ylab="Density (per gram) [log scale]")
legend("topright", levels(data_habitat$Dist), col=1:3)

fit.wethabconffinal <- aov(log(Total)~ Wmass + Dist*Time, data=data_habitat)
summary(fit.wethabconffinal)

## Interaction is now significant at a 5% level, but conclusions are not changed dramatically
interaction.plot(data_habitat$Dist, data_habitat$Time, fit.wethabconffinal$fitted, xlab="Isolation of patch (m)", ylab="Total density (per gram) [log scale]", trace.label="Time (weeks)")

tft=TukeyHSD(fit.wethabconffinal,which=c("Dist:Time"))
par(mar = c(6,6,4,1))
plot(tft,las=1)




# ## Question 2a
##data_birds <- read_csv("data/birdCountYear.csv")

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
