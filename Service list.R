library(readxl)
library(sqldf)
library(plotrix)
set.seed(123)
z1<-read_excel("D:\\DATA ANALYSIS\\PROJECT\\VAYA SALON\\vaya.xlsx",sheet=6)
dim(z1)
colSums(is.na(z1))
names(z1)
a1<-sqldf('select service_list,sum(time_min) as Total_time from z1 group by service_list')
a1
summary(a1)
sqldf("select Service_List from a1 where time_min==1905.0")
m1<-table(z1$Service_List)
m1
windows(height = 8,width=4)
pie3D(m1,explode = 0.1)
### services commissionable or not
a2<-sqldf('select Commissionable,count(*) from z1 group by Commissionable')
a2

