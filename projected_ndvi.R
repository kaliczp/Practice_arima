ndvi2 <- read.csv("ndvi2.csv")
class(ndvi2)
str(ndvi2)
plot(ndvi2)
#convert the data in to time series by using ts function
#ndvitime=ts(ndvi2$NDVI,start =min(ndvi2$Date),end = max(ndvi2$Date),frequency = 1)
ndvi2time=ts(ndvi2$NDVI,start = min(ndvi2$Years),end = max(ndvi2$Years),frequency=1)
#chech the data if its converted 
class(ndvi2time)
#upload the required libraries
library(forecast)
library(tseries)
plot(ndvi2time)
#chech the stachinary of the data there are three type of data(seasonalty,stachinarity,categroty)
# first we chech the outo corelation using acf funtion
#if the lines are between the two blue dots that means the data is significantly corelated
acf(ndvi2time)
#another stationary test is to use pacf function
pacf(ndvitime)
# another test is to chech the p value by using adf.test function
adf.test(ndvi2time)
# the p value should be less than 0.5 if its large then we use outo.aeima function to convert non stationary to stationary data
##ndvimodel=auto.arima(ndvitime,ic="aic",trace = TRUE)
##ndvimodel
# again chech the outo corelation
##acf(ts(ndvimodel$residuals))
#now we forecat
myndviforecast=forecast(ndvi2time,level = c(95),h=10*1)
#plot forecast
plot(myndviforecast)
#now we validate the accuracy the p value should be lower than 0.5
Box.test(myndviforecast$residuals,lag=2,type="Ljung-Box")
