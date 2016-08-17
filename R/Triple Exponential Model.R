#A triple exponential model (also called a Holt-Winters exponential smoothing) fits a time series with level, trend and seasonal components.
#Smoothing is controlled by three parameters: alpha, beta and gamma for the estimates of the level, slope b of the trend component and the seasonal component respectively.
#The parameters alpha, beta and gamma all have values between 0 and 1 whose values that are close to 0 meaning that relatively little weight is placed on the most recent observations when making forecasts of future values.


library(forecast)
holt_winters <- ets(log(flat_net_price), model="MMM")
holt_winters
accuracy(holt_winters)

pred <- forecast(holt_winters, 5)
pred
plot(pred, main="HK Property",
     ylab="Log(flat_net_price)", xlab="Time")

pred$mean <- exp(pred$mean)
pred$lower <- exp(pred$lower)
pred$upper <- exp(pred$upper)
p <- cbind(pred$mean, pred$lower, pred$upper)
dimnames(p)[[2]] <- c("mean", "Lo 80", "Lo 95", "Hi 80", "Hi 95")
p
