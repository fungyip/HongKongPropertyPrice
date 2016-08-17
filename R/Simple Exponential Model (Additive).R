#A simple exponential model (also called a single exponential model) fits a time series that has a constant level and an irregular component but no seasonality.
#Smoothing is controlled by the parameter alpha which lies between 0 and 1. Values of alpha that are close to 0 mean that little weight is placed on the most recent observations when making forecasts of future values.

#Additive
library(forecast)
simple_exp<-ets(flat_net_price, model="ANN")
hk_flat<-forecast(simple_exp, 6)
plot(hk_flat, xlab="Year", ylab=expression(paste("Price")), main="HK Property Price")
accuracy(simple_exp)
