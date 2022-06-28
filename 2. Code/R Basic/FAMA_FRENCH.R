library(tidyverse)
library(quantmod)
library(zoo)

ff_data = read.csv("F-F_Research_Data_Factors_daily.CSV", skip = 3)
ff_data = na.omit(ff_data) #remove missing values
head(ff_data) #date is missing column names

colnames(ff_data)[1]='Date'
# strptime tách chuỗi ra để format
ff_data$Date=as.Date(strptime(ff_data$Date,format='%Y%m%d'))
View(ff_data)

d_aapl=getSymbols("AAPL",from="2019-01-01", to = "2021-09-30", auto.assign = F)
d_aapl

class(d_aapl)

# log return: có thể cộng 2 return của 2 ngày
aapl_ret = dailyReturn(d_aapl$AAPL.Close, type = "log")
aapl_ret

aapl_ret2=fortify.zoo(aapl_ret) #convert zoo object to dataframe
head(aapl_ret2)

colnames(aapl_ret2)=c('Date','AAPL')
data_ffex=merge(aapl_ret2,ff_data,by='Date')
data_ffex$AAPL.Rf = data_ffex$AAPL - data_ffex$RF
head(data_ffex)

ff_lreg = lm(AAPL.Rf ~ Mkt.RF + SMB + HML, data = data_ffex)
summary(ff_lreg)
