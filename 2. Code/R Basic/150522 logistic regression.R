library(tidyverse)
data=read_csv('default.csv')
View(data)

summary(data)
str(data)
nrow(data)
dim(data)

set.seed(123)	#ensure replicability of the result
sample <- sample(c(TRUE, FALSE), nrow(data),
                 replace=TRUE, prob=c(0.7,0.3))
sample

train <- data[sample, ]
test <- data[!sample, ]  
dim(train)
dim(test)

model <- glm(default~student+balance+income,
             family="binomial", data=train)
summary(model)

#marginal effect at the mean
#install.packages('margins')
library(margins)
margin.model=margins(model,type='response')
summary(margin.model)

library(caret)
varImp(model)

#define two individuals
new <- data.frame(balance = 1400,
                  income = 2000,
                  student = c(1, 0))
new
#predict probability of defaulting
predict(model, new, type="response")

#check multicollinearity
library(car)
vif(model) 

#create confusion matrix to measure the percent correctly predicted value (test data)
predicted <- predict(model, test, type="response")
predicted2=ifelse(predicted>=0.5,1,0)
predicted2=factor(predicted2,levels=c('0','1'))
test$default=factor(test$default,levels=c('0','1'))
library(caret)
confusionMatrix(test$default, predicted2)

#plot the ROC curve with cutoff points
library(ROCR)
res=predict(model,train,type='response')
rocrpred=prediction(res,train$default)
rocrperf=performance(rocrpred,'tpr','fpr')
plot(rocrperf,colorize=TRUE,print.cutoffs.at=seq(0.1,by=0.1))

#determine the best cutoff point
ROCR_pred <- prediction(res,train$default)
cost_perf = performance(ROCR_pred, "cost") 
ROCR_pred@cutoffs[[1]][which.min(cost_perf@y.values[[1]])]

table(Actualvalue=train$default,Predictedvalue=res>=0.5)
(6790+80)/(6790+30+148+80)

table(Actualvalue=train$default,Predictedvalue=res>=0.4782603)
(6790+81)/(6790+30+147+81)
