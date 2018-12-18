###########
## Session 2: Introductory Stats Revision
###########
## Question 1a 
rm(list = ls())
datsmoke <- read.csv("data/smokePregnant.csv", header = T)

## Question 1b-c
## Inference; hypothesis test of whether there is difference in number of errors between two groups
## Two variables; one categorical and one quantitative

## Question 1d
boxplot(datsmoke, main = "Comparative boxplots of # of errors by treatment", ylab = "# of errors", xlab = "Treatment")

## Question 1e
par(mfrow = c(1,2))
qqnorm(datsmoke$Nicotine); qqline(datsmoke$Nicotine)
qqnorm(datsmoke$Control); qqline(datsmoke$Control)
## Both are right skewed; boxplots in particular show this; give the transformations a go

boxplot(log(datsmoke), main = "Comparative boxplots of # of errors by treatment", ylab = "# of errors", xlab = "Treatment")

par(mfrow = c(1,2))
qqnorm(log(datsmoke$Nicotine)); qqline(log(datsmoke$Nicotine))
qqnorm(log(datsmoke$Control)); qqline(log(datsmoke$Control))
## Better

## Question 1f-g
#t.test(dat$Nicotine,dat$Control, var.equal=T)
t.test(log(datsmoke$Nicotine), log(datsmoke$Control), var.equal=T)

## Question 1h
## Observations are independent; random sample of GPs and and random allocation of treatments
## observations are normally distributed with same variance in both groups
sd(log(datsmoke$Nicotine))
sd(log(datsmoke$Control))


## Question 2

batsex = cbind(44,65)

## Question 2a-b
## Inference, with a specifc hypothesis to test (evidence of gender bias)
## One variable with two categories

## Question 2c
barplot(batsex, xlab = "Sex", ylab = "Frequency in Colony", main = "Barplot of Bats in Colony by Sex")

## Question 2d-e
prop.test(batsex, correct = F)

## Question 1f
## Each bat has the same probability of being selected (independence); guaranteed by random sampling of bats

