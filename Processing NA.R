x = c(1:4,NA,6:7,NA)
x
is.na(x)

df = data.frame(col1 = c(1:3, NA),
               col2=c('a', NA, 'c', 'd'),
               col3=c(T,F,T,T),
               col4=c(2.5,4.2,3.2, NA),
               stringsAsFactors = F)
df
is.na(df)
is.na(df$col1)

which(is.na(df$col1))
sum(is.na(df$col1))
summary(df)


colSums(is.na(df))
rowSums(is.na(df))

mean(x,na.rm = T)
x[is.na(x)] = mean(x,na.rm = T)
round(x,2)

# Get row have not NA
# 1st 
df[complete.cases(df),]
na.omit(df)


# How many missing values are in the built-in data set airquality?
# Which variables are the missing values concentrated in?
# How would you impute the mean or median for these values?
# How would you omit all rows containing missing values?


sum(is.na(airquality))
summary(airquality)

airquality$Ozone[is.na(airquality$Ozone)] = mean(airquality$Ozone, na.rm =T)
airquality$Solar.R[is.na(airquality$Solar.R)] = mean(airquality$Solar.R, na.rm =T)

na.omit(airquality)

# write.csv(df,'Demo Missing data.csv')


