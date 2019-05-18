library(readxl)
library(tidyverse)
library(lubridate)
library(ggplot2)
library(dplyr)
library(RColorBrewer)
z1<-read_excel("D:\\DATA ANALYSIS\\PROJECT\\VAYA SALON\\vaya.xlsx",sheet=2)
set.seed(123)
names(z1)
z2<-subset(z1,select = c(LV,Name) )
colSums(is.na(z2))
str(z2)
dim(z2)
z3<-na.omit(z2)
dim(z3)
z3$LV<-as.factor(z3$LV)
z3$LV<-mdy(z3$LV)
str(z3)
colSums(is.na(z3))
z3$LV<-as.POSIXct(z3$LV)
########################### RFM ###############################
zr<-z3%>%
  group_by(Name)%>%
  summarise(recency=as.numeric(day(as.Date("2017-01-01")-max(LV))))

summary(zr)
View(zr)
################## RECENCY ###############################
barplot(zr$recency,xlab="Days since last visit",col=brewer.pal(n=8,"PuOr"))

q1<-ifelse(zr$recency<=quantile(zr$recency,c(0.25)),1,ifelse(zr$recency<=quantile(zr$recency,c(0.50)),2,ifelse(zr$recency<=quantile(zr$recency,c(0.75)),3,ifelse(zr$recency<=quantile(zr$recency,c(1)),4,NA))))

sum(is.na(q1))

##################################
qr<-data.frame(zr,q1)
View(qr)
##################################

#write.csv(qr,"D:\\DATA ANALYSIS\\PROJECT\\VAYA SALON\\Modelling\\RFM(NEW CUST LIST).csv")
qr<-qr%>%arrange(qr$recency)



library(readr)
library(sqldf)
s1<-read.csv("D:\\DATA ANALYSIS\\PROJECT\\VAYA SALON\\Modelling\\RFM(NEW CUST LIST).csv")
View(s1)
r1<-sqldf("select sum(recency)/count(recency) from s1 where q1==4")
r1
