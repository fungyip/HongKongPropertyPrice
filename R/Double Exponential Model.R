#A double exponential model (also called a Holt exponential smoothing) fits a time series with both a level and a trend but no seasonality.
#Smoothing is controlled by two parameters, alpha, for the estimate of the level and beta for the estimate of the slope b of the trend component.
#As with simple exponential smoothing, the parameters alpha and beta have values between 0 and 1, and values that are close to 0 mean that little weight is placed on the most recent observations when making forecasts of future values.

#A double exponential Multiplicative model
library(forecast)
simple_exp<-ets(flat_net_price, model="MMN")
simple_exp
forecast(simple_exp, 6)
plot(forecast(simple_exp, 6), xlab="Year",
     ylab=expression(paste("Price")),
     main="A Double Exponential Multiplicative Model for HK Property Net Price")
accuracy(simple_exp)
