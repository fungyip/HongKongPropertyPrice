ts_flat_net_price = ts(flat_net_price, frequency = 12)
decompose_flat_net_price = decompose(ts_flat_net_price, "multiplicative")

plot(decompose_flat_net_price$seasonal)
plot(decompose_flat_net_price$trend)
plot(decompose_flat_net_price$random)
plot(decompose_flat_net_price)
