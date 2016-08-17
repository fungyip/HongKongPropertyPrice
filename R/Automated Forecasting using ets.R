#ets() function and automated forecasting
library(forecast)
fit <- ets(flat_net_price)
fit
plot(forecast(fit,6), main="Hong Kong Property Price",
     ylab="Price", xlab="Time", flty=2)
