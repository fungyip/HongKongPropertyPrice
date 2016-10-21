#This handy R script is created to extract Hong Kong gross and net property prices from the estate agent Midland 美聯物業 for rapid machine learning.
#install.packages("jsonlite")
require(jsonlite)
#############################Data Collection############################
#####Hong Kong Property Price Movement is sourced from Midland Realty#############
url <- "http://resources.midland.com.hk/json/common/price.json?t="

###########################Web Scraping############################################
flat_data<-fromJSON(url)
period<-flat_data$x_axis$labels$labels
Price<-flat_data$elements
###########################Data manipulation############################################
net_price<-as.data.frame(Price$values[[1]])
gross_price<-as.data.frame(Price$values[[2]])

names(gross_price)[1]<-"gross_price"
names(net_price)[1]<-"net_price"

#install.packages("dse")
library(dse)
starttime=c(1997,1);endtime=c(2016,9);freq=12
flat_gross_price<-ts(gross_price,start=starttime,end=endtime,frequency=freq)
plot(flat_gross_price)
flat_net_price<-ts(net_price,start=starttime,end=endtime,frequency=freq)
plot(flat_net_price)

########################################################################
library(zoo)
library(ggplot2)
library(scales)

hk_flat_net_price<-autoplot(as.zoo(flat_net_price), geom = "line")+
  xlab("Period") +
  ylab("Net Price (平均實用樓價)") 

hk_flat_net_price


#ggsave(filename="hk_flat_net_price.png",plot=hk_flat_net_price,scale=4)
ggsave(filename="hk_flat_net_price.png",plot=hk_flat_net_price)


####ARIMA Modelling####
library(forecast)
#input Training Data - df_train
fit<-auto.arima(flat_net_price)
summary(fit)
fitted(fit)
forecast_fit<-forecast(fit)
forecast_fit
plot(forecast_fit)