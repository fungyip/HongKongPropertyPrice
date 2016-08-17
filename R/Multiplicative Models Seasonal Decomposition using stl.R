flat_net_price<-ts(net_price$net_price,start=starttime,end=endtime,frequency=freq)
lflat_net_price <- log(flat_net_price)
fit <- stl(lflat_net_price, s.window="period")
plot(fit)
fit$time.series
exp(fit$time.series)
