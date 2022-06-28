############################### Import Library ##################################
library(tidyverse)
library(ggplot2) #to draw graphs to examine the distribution of data


# income.data for simple linear regression
# heart.data for multiple linear regression

# Input data
income = read.csv('income.data.csv')

# Income is dependence variable and Happiness is independence variable
View(income)

# Scatter
plot(income$happiness ~income$income)

# Running model
incomelm = lm(happiness ~ income, data = income)
summary(incomelm)

# Subplots (2 col 2 row)
par(mfrow=c(2,2))

# Visualization 
plot(incomelm)











