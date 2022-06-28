############################## Data Frames ############################## 
# - Like matrices, Data frames are tabular data objects.
# - Unlike matrices, each column in data frame can contain different types of data.
# - It is a list of vectors of equal length.
# - Data Frames are created using the data.frame().


bmi = data.frame(
  gender = c("Male", "Male","Female"),
  height = c(152, 171.5, 165),
  weight = c(81,93, 78),
  age = c(42,38,26))

bmi

bmi['age'] = NULL

bmi

############################## Rename columns/rows ############################## 

# 1. names(df)[1] <- 'new name '
# 2. colnames(df)[1]<- 'new name'
# 3. rename(df, 'new name'=oldname) #require dplyr
# 4. data.frame(data,row.names=.)
# 5 rownames(df)[1]= 'new name


dataframe_1 <- data.frame(
  emp_id = c(1:5),
  emp_name = c("Rick","Dan","Michelle","Ryan","Gary"),
  salary = c(623.3,515.2,611.0,729.0,843.25),
  start_date = as.Date(c("2012-01-01", "2013-09-23", "2014-11-15", "2014-05-11", "2015-03-27")),
  stringsAsFactors = FALSE) 

dataframe_1

dataframe_1.1 = data.frame(
  emp_id = c(1:5),
  emp_name = c("Rick","Dan","Michelle","Ryan","Gary"),
  salary = c(623.3,515.2,611.0,729.0,843.25),
  stringsAsFactors = FALSE)
row.names(dataframe_1.1) = as.Date(c("2012-01-01", "2013-09-23", "2014-11-15", "2014-05-11", "2015-03-27"))

dataframe_1.1
# Rename
names(dataframe_1)[1] = 'ID'
colnames(dataframe_1)[2] = "Customers"
# rename(dataframe_1, 'salary'='Monthly rollpay')

# install.packages('tidyverse') # Install super packages
library(tidyverse) # Import library

dataframe_1 = rename(dataframe_1,'Payroll'=salary)
dataframe_1
# Rename the row of the dataframe
rownames(dataframe_1)= as.Date(c("2012-01-01", "2013-09-23", "2014-11-15", "2014-05-11", "2015-03-27"))

############################## Slicing/Indexing ############################## 

dataframe_2 = data.frame(dataframe_1['ID'],dataframe_1['Customers'], dataframe_1['Payroll'])
dataframe_2

# Other examples
dataframe_2.1 = dataframe_1[1:2,] # Get all columns in the 1st and 2nd row
dataframe_2.1
dataframe_2.2 = dataframe_1[c(3,5),c(2,4)] # Get the columns 2nd and 4th in the 3rd and 5th row.
dataframe_2.2


############################## Add Columns ############################## 

# data.frame$new.column
# data.frame[["new.column"]]
# cbind(data.frame,new.column)

dataframe_1['True/False'] = c('True','True','False','True','False')

Bonus = c(100,220,120,150,300)
dataframe_1 = cbind(dataframe_1,Bonus)

#Add the "dept" column.

Department= c("IT","Operations","IT","HR","Finance")

dataframe_1$Department = Department

dataframe_1['True/False'] = NULL

dataframe_1


############################## Add Rows ############################## 

# When adding rows into a DataFrame, the new one must have same columns' name.
dataframe_3 = data.frame(
  ID = c(1:5),
  Customers = c("Rick","Dan","Michelle","Ryan","Gary"),
  Salary = c(623.3,515.2,611.0,729.0,843.25),
  Start_date = as.Date(c("2012-01-01", "2013-09-23", "2014-11-15", "2014-05-11", "2015-03-27")),
  stringsAsFactors = F) 

dataframe_4 = data.frame(
  ID = c(6:8),
  Customers = c("Rasmi","Pranab","Tusar"),
  Salary = c(578.0,722.5,632.8),
  Start_date = as.Date(c("2013-05-21","2013-07-30","2014-06-17")),
  stringsAsFactors = F)

concatenate_dataframe = rbind(dataframe_3,dataframe_4)

concatenate_dataframe

############################## Operators ############################## \

# - To perform specific mathematical or logical manipulations
# - Types of Operators
# . Arithmetic Operators
# . Relational Operators
# . Logical Operators
# . Assignment Operators
# . Miscellaneous Operators

# Other operators

var_1 = c(1:5)
var_2 = 3
var_3 = 7
var_4 = seq(1,10,2)

var_3 %in% var_1
var_2 %in% var_1

!var_3

var_4 != var_1
var_4 == var_1
var_4 >= var_1

######################################################################### 
##############################  Programming ############################## 
######################################################################## 

############################## If, else, else if ##############################  

# IF STATEMENT (1 CONDITION)
input_num = -6

if (input_num < 0){
  cat(input_num,'is negative number.')
} else{
  cat(input_num,'is positive number.')
}

# THE IF ELSE STATEMENT (2 CONDITIONS)  
quantity = 13

if (quantity >= 20){
  print('You sold well!')
}else{
  print('You must try more')
}

# THE ELSE IF STATEMENT (MORE THAN 2 CONDITIONS)
bmi = 33

if (bmi<18.5) {
  print('Low weight')
} else if (18.5<=bmi & bmi< 24.9){
  print('Normal weight')
} else if (bmi > 25 & bmi <29.9){
  print('Overweight')
} else if (bmi > 30){
  print('Fat')
}

A = c('Book','magazine', 'newspaper')
B = c('Vegetable','meat', 'beverage')
C = c('Tee-shirt','jean', 'pant')

product = 'Vegetable'

if (product %in% A){
  paste(product, 'belong to A categories.',
        'The VAT of',product,'is 8%.',
        'The price after tax is',100*1.08)
} else if (product %in% B) {
  paste(product, 'belong to B categories.',
        'The VAT of',product,'is 10%.',
        'The price after tax is',100*1.1)
} else if (product %in% C) {
  paste(product, 'belong to C categories.',
        'The VAT of',product,'is 20%.',
        'The price after tax is',100*1.2)
}

############################## Loops - For loop ##############################  
fruit = c('Apple', 'Orange', 'Passion fruit', 'Banana')

for (i in fruit){
  print(i)
}

empty_list = c()
for (i in seq(1,4,1)){
  empty_list[i] = i**2
}

print(empty_list)

##############################  Excercise  ##############################  
# Exercise 1

# If the 1st number is even, calculate its value to the power of three. If the 1st number is odd, calculate its
# value to the power of two. Put the calculated value to the corresponding order in the series.

exercise_1 = c(1,4,5,7,3,7,3,2)

if (exercise_1[1] %% 2 == 0){
  result.exercise_1 = (exercise_1)**3
} else if (exercise_1[1] %% 2 != 0) {
  result.exercise_1 = (exercise_1)**2
}

result.exercise_1

exercise_2 = c(1,4,5,7,3,7,3,2)
result.exercise_2 = c()
for (j in seq(1,length(exercise_2),1)){
  if (exercise_2[j] %% 2 == 0){
    result.exercise_2[j] = (exercise_2[j])**2
  } else {
    result.exercise_2[j] = (exercise_2[j])**3
  }
}

result.exercise_2

# Exercise 2

# Put the words in the 'title' vector in the 'new.title' vector
# title=c('catch','me','if','you','can')

title=c('catch','me','if','you','can')

new.title = c()
for (i in seq(1,length(title),1)){
  new.title[i] = title[i]
}

new.title   

# For Loop over a list
fruit = list(Basket=c('Apple', 'Orange', 'Passion fruit', 'Banana'),
             Money = c(10,12,15))

for (j in fruit){
  print(j)
}

