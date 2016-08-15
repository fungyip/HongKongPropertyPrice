---
title: "Web Scraping Hong Kong Property Price"
author: "Fung YIP"
date: "14 August 2016"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## 美聯物業樓價

This handy R script is created to extract Hong Kong **Gross** and **Net** property prices from the Hong Kong Estate Agent Midland 美聯物業 <http://www.midland.com.hk/> for rapid machine learning.

### Data Collection
Hong Kong Property Price Movement is sourced from Midland Realty
```{r url}
url <- "http://resources.midland.com.hk/json/common/price.json?t="
```

### Web Scraping
```{r WebScraping, echo=TRUE, message=FALSE, warning=FALSE}
require(jsonlite)
flat_data<-fromJSON(url)
period<-flat_data$x_axis$labels$labels
Price<-flat_data$elements
```

###Data manipulation
```{r prices, echo=TRUE, message=FALSE, warning=FALSE}
net_price<-as.data.frame(Price$values[[1]])
gross_price<-as.data.frame(Price$values[[2]])
```

Variable Names
```{r names, echo=TRUE, message=FALSE, warning=FALSE}
names(net_price)[1]<-"net_price"
names(gross_price)[1]<-"gross_price"
```

Add Time dimension 
```{r time, echo=TRUE, message=FALSE, warning=FALSE}
library(dse)
starttime=c(1997,1);endtime=c(2016,7);freq=12
flat_net_price<-ts(net_price,start=starttime,end=endtime,frequency=freq)
flat_gross_price<-ts(gross_price,start=starttime,end=endtime,frequency=freq)
```

```{r plot, echo=TRUE, message=FALSE, warning=FALSE}
plot(flat_gross_price)
plot(flat_net_price)
```

###Data Visualization
Net Price 平均實用樓價
```{r DataVis, echo=TRUE, message=FALSE, warning=FALSE}
library(zoo)
library(ggplot2)
library(scales)

hk_flat_net_price<-autoplot(as.zoo(flat_net_price), geom = "line")+
  xlab("Period") +
  ylab("Net Price") 

hk_flat_net_price
```

Export
```{r DataOut, echo=TRUE, message=FALSE, warning=FALSE}
ggsave(filename="../DataOut/hk_flat_net_price.png",plot=hk_flat_net_price)
```

###ARIMA Modelling
```{r ARIMA, echo=TRUE, message=FALSE, warning=FALSE}
library(forecast)
fit<-auto.arima(flat_net_price)
summary(fit)
fitted(fit)
forecast_fit<-forecast(fit)
plot(forecast_fit)
```




