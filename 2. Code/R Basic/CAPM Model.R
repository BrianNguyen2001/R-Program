library(ggplot2)
library(tidyverse)

capm = as_tibble(read.csv('capm.csv'))

View(capm)

capm=capm[,2:length(capm)]
# length(capm) # number of columns.

summary(capm)

# Check feature of the data
str(capm)

# Calculate excess returns
capm$RP.mkt = capm$mkt - capm$riskfree
capm$RP.dis = capm$dis - capm$riskfree
capm$RP.ge  = capm$ge - capm$riskfree
capm$RP.ford= capm$ford - capm$riskfree
capm$RP.ibm = capm$ibm - capm$riskfree
capm$RP.msft= capm$msft - capm$riskfree
capm$RP.xom = capm$xom - capm$riskfree

dis.fitted =lm (RP.dis~RP.mkt,data = capm)
ge.fitted = lm(RP.ge~ RP.mkt,data = capm)
ford.fitted = lm(RP.ford~ RP.mkt,data = capm)
ibm.fitted = lm(RP.ibm~ RP.mkt,data = capm)
msft.fitted = lm(RP.msft~ RP.mkt,data = capm)
xom.fitted = lm(RP.xom~ RP.mkt,data = capm)

summary(dis.fitted)
# Min - Max run from negative to positive is good. The data is balance.
# t - value: show the distance of Beta to zero.
# Beta > 1: Stock volatility is greater than the market

attributes(dis.fitted)
dis.fitted$coefficients[2] # Beta

capm$Resid.dis = dis.fitted$residuals

hist(capm$Resid.dis)

shapiro.test(capm$Resid.dis) # P-value < 0 => Not is normal distribution.
# shapiro.test(resid(dis.fitted))


capm$dis.predict = predict.lm(dis.fitted)
# capm$dis.predict=predict(dis.fitted)
# capm$dis.predict=fitted(dis.fitted)
capm$ge.predict = predict.lm(ge.fitted)
capm$ford.predict = predict.lm(ford.fitted)
capm$ibm.predict = predict.lm(ibm.fitted)
capm$msft.predict = predict.lm(msft.fitted)
capm$xom.predict = predict.lm(xom.fitted)


dis.plot <- ggplot(capm, aes(y = dis.predict, x = RP.mkt)) +
  geom_smooth(col='tomato2', method='lm') + # show the linear line
  geom_point(aes(y = RP.dis, x = RP.mkt)) + # scatter
  labs(title='Disney',x='Risk Premium',y='Expected Return')

dis.plot



########################## Use PerformanceAnalytics ########################## 
# install.packages('xts')
# install.packages('PerformanceAnalytics')

library(xts)
#  xts conclude index and core data (DataFrame have a timeseries columns)
library(PerformanceAnalytics)

capm=read.csv('capm.csv')

capm$date = as.Date(capm$date) #convert to Date data

class(capm$date)
View(capm)


#  Create object zoo/xts because PerformanceAnalytics need xts format
capm.xts = xts(capm[,2:9],capm$date) #convert to xts object
class(capm.xts)
View(capm.xts)

capm.xts$RP.mkt = capm.xts$mkt - capm.xts$riskfree
capm.xts$RP.ge = capm.xts$ge-capm.xts$riskfree

summary(lm(capm.xts$RP.ge~capm.xts$RP.mkt, data = capm.xts))

CAPM.beta(Ra = capm.xts$RP.ge, Rb = capm.xts$RP.mkt)
CAPM.alpha(Ra = capm.xts$RP.ge, Rb = capm.xts$RP.mkt)
CAPM.CML(Ra = capm.xts$RP.ge, Rb = capm.xts$RP.mkt)

covariance.ge = cov(capm.xts$RP.ge, capm.xts$RP.mkt)
variance.ge = var(capm.xts$RP.mkt)
beta = covariance.ge/variance.ge

beta
