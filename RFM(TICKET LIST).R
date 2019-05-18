library(readxl)
library(tidyverse)
library(lubridate)
library(ggplot2)
library(dplyr)
library(RColorBrewer)
z1<-read_excel("D:\\DATA ANALYSIS\\PROJECT\\VAYA SALON\\vaya.xlsx",sheet=8)
names(z1)
z2<-subset(z1,select = -c(Salon,Ticket_Staff,Status,Payment,Total_for_Processed,Total_for_void))
names(z2)
str(z2)
colSums(is.na(z2))
z2<-na.omit(z2)
colSums(is.na(z2))
################data cleaning
z3<-z2 %>%
  mutate(Amount=replace(Amount,Amount<=0,NA))
dim(z3)
z4<-z3[complete.cases(z3),]
########################################
zc<-na.omit(z3)
#View(zc)

library(compare)
compare(z4,zc,ignoreNames=T)
#########################################
dim(z4)
colSums(is.na(z4))
str(z4)
################ RFM ################
zr<-z4 %>%
  group_by(Customer) %>%
  summarise(recency=as.numeric(day(as.Date("2018-01-01")-max(Date) )),
            #frequency=n_distinct(Customer)####because every coustomer only visited once
            monitery=sum(Amount)/n_distinct(Customer))
summary(zr)            
###################### Recency #########################
barplot(zr$recency,xlab="Number of days",col=brewer.pal(n=5,name = "YlOrRd"))

q1<-ifelse(zr$recency<=quantile(zr$recency,c(0.25)),1,ifelse(zr$recency<=quantile(zr$recency,c(0.50)),2,ifelse(zr$recency<=quantile(zr$recency,c(0.75)),3,ifelse(zr$recency<=quantile(zr$recency,c(1)),4,NA))))

sum(is.na(q1))


##################### Monitery #########################
barplot(zr$monitery,xlab="$Money$ spent",col=brewer.pal(n=8,name = "YlOrRd"))

q2<-ifelse(zr$monitery<=quantile(zr$monitery,c(0.25)),1,ifelse(zr$monitery<=quantile(zr$monitery,c(0.50)),2,ifelse(zr$monitery<=quantile(zr$monitery,c(0.75)),3,ifelse(zr$monitery<=quantile(zr$monitery,c(1)),4,NA))))

sum(is.na(q2))

#################################
quartile_r<-data.frame(zr,q1,q2)
View(quartile_r)
#####################################

#write.csv(quartile_r,"D:\\DATA ANALYSIS\\PROJECT\\VAYA SALON\\Modelling\\RFM(Ticket_list).csv")

quartile_r<-quartile_r%>%arrange(quartile_r$recency,quartile_r$monitery)

nrow(quartile_r)
View(quartile_r)

library(readxl)
library(sqldf)
g1<-read.csv("D:\\DATA ANALYSIS\\PROJECT\\VAYA SALON\\Modelling\\RFM(Ticket_list).csv")
View(g1)


t1<-sqldf("select sum(recency)/count(recency) from g1 where q2==4")
t1

