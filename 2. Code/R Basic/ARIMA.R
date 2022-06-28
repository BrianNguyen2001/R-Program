library(forecast) #forecast, accuracy
library(quantmod) #getSymbols
library(tseries) #adf.test
library(lmtest) #coeftest
library(stats) #Box.test


# get data: AAPL stock price
getSymbols('AAPL',
           from='2021-01-01',
           to='2022-04-30')

class(AAPL) # check class of AAPL *xts, zoo

lag(aapl$AAPL.Close)
# only keep close price, and calculate return
aapl=AAPL[,4]
aapl$raapl=diff(aapl$AAPL.Close)/lag(aapl$AAPL.Close)
aapl=na.omit(aapl)
aapl


aapl.train=aapl['2021/2022-02-28']
aapl.test=aapl['2022-02-28/']
View(aapl.train)
View(aapl.test)

plot(aapl$AAPL.Close)
plot(aapl$raapl)
aapl

#price of AAPL is not stationary
par(mfrow=c(1,1))
acf(aapl.train$AAPL.Close,main='ACF for aapl')
pacf(aapl.train$AAPL.Close,main='PACF for appl')
adf.test(aapl.train$AAPL.Close) 


#now check whether return of AAPL is stationary
acf(aapl.train$raapl,lag=12) #13
pacf(aapl.train$raapl,lag=12) #13
adf.test(aapl.train$raapl) 


#use auto.arima function to determine best P, D, Q
auto=auto.arima(aapl.train$raapl,seasonal=F,trace = T,max.order=4,ic='aic')
coeftest(auto.arima(aapl.train$raapl,seasonal=F))

acf(auto$residuals)
pacf(auto$residuals,lag=12)

Box.test(auto$residuals,lag=12,type='Ljung-Box')

#prediction
term=44
fcastauto=forecast(auto,h=term)
fcastauto #fcastauto is the predicted values for 44 terms
plot(fcastauto)

#test accuracy
length(aapl$raapl)
length(aapl$raapl['/2022-02-28'])
accuracy(fcastauto) #train set
accuracy(fcastauto,aapl$raapl[290:333]) #test set

#test accuracy of another model (the order is chosen by examining the ACF and PACF of raapl)
arima11011=arima(aapl.train$raapl,order=c(11,0,11))
coeftest(arima11011)
acf(arima11011$residuals)
pacf(arima11011$residuals)
Box.test(arima11011$residuals,lag=20,type='Ljung-Box')
fcast11011=forecast(arima11011,h=term)
plot(fcast11011)

#test accuracy of another model (the order is chosen by examining the ACF and PACF of raapl)
arima13013=arima(aapl.train$raapl,order=c(13,0,13))
coeftest(arima13013)
acf(arima13013$residuals)
pacf(arima13013$residuals)
Box.test(arima13013$residuals,lag=20,type='Ljung-Box')
fcast13013=forecast(arima13013,h=term)
plot(fcast13013)

# compare accuracy of auto.arima vs 11011
accuracy(fcastauto)
accuracy(fcast11011)
accuracy(fcastauto)<accuracy(fcast11011)
accuracy(fcast11011,aapl$raapl[290:333])
accuracy(fcastauto,aapl$raapl[290:333])<
  accuracy(fcast11011,aapl$raapl[290:333])
# => Overfitting

# compare accuracy of auto.arima vs 13013
accuracy(fcastauto)
accuracy(fcast13013)
accuracy(fcastauto)<accuracy(fcast13013)
accuracy(fcast13013,aapl$raapl[290:333])
accuracy(fcastauto,aapl$raapl[290:333])< accuracy(fcast13013,aapl$raapl[290:333])

                

                