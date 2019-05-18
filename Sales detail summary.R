library(readxl)
library(sqldf)
library(plotrix)
library(RColorBrewer)
set.seed(123)
z1<-read_excel("D:\\DATA ANALYSIS\\PROJECT\\VAYA SALON\\vaya.xlsx",sheet = 5)
class(z1)
dim(z1)
colSums(is.na(z1))
names(z1)
z2<-subset(z1,select = -c(Salon,Staff_2,Vendor_Code))
names(z2)
a1<-sqldf("select Ticket,Staff_1,Net from z2")
a1
#### number of tickets attended by staff ####
m1<-tapply(a1$Ticket,a1$Staff_1,sum)
m1
windows(height = 7,width = 4.5)
barplot(m1,ylim = c(0,600),col=brewer.pal(n=8,"Blues"))
#### net amount genrated by each staff member ####
a2<-tapply(a1$Net,a1$Staff_1,sum)  
windows(height=7,width = 4.5)
barplot(a2,col=brewer.pal(n=8,"Spectral"))




