library(forecast)
#input Training Data - df_train
fit<-auto.arima(df_train)
summary(fit)
fitted(fit)
forecast_fit<-forecast(fit)
plot(forecast_fit)