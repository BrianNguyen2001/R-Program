library(tidyverse)
data=read.csv('default.csv')
View(data)

set.seed(123)	#ensure replicability of the result
sample <- sample(c(TRUE, FALSE), nrow(data), replace=TRUE, prob=c(0.7,0.3))
train <- data[sample, ]
test <- data[!sample, ]  


dim(train)
dim(test)
#estimate logistic regression model
model <- glm(default~student+balance+income, family="binomial", data=train)
summary(model)

# Null deviance: sai số hằng số chặn (trước khi đưa các biến giải thích)
# Residual deviance: sai số sau khi đưa các biến giải thích

#Marginal effect at the mean
# Dấu ảnh hưởng biên bị ảnh hưởng bởi dấu của Beta.
library(margins)
margin.model=margins(model,type='response')
summary(margin.model)

# Xem xét tính quan trọng của các biến
library(caret)
varImp(model)

#define two individuals
new <- data.frame(balance = 1400, income = 2000, student = c(1, 0))
new
#predict probability of defaulting
predict(model, new, type="response")

#model checking
#check multicollinearity
library(car)
vif(model) 

#calculate probability of default for each individual in test dataset
predicted <- predict(model, test, type="response")

#create confusion matrix to measure the percent correctly predicted value (test data)
predicted2=ifelse(predicted>=0.5,1,0)
predicted2=factor(predicted2,levels=c('0','1'))
test$default=factor(test$default,levels=c('0','1'))
confusionMatrix(test$default, predicted2)


#plot the ROC curve
library(ROCR)
# res = predicted2 = ifelse(predi)
# plotROC(test$default, predicted
        
