library(readxl)
library(sqldf)
library(plotrix)
set.seed(123)
z1<-read_excel("D:\\DATA ANALYSIS\\PROJECT\\VAYA SALON\\vaya.xlsx",sheet=8)
dim(z1)
colSums(is.na(z1))

##na.omit(z1) ### does'nt work,have to specify new object explicitly

z2<-na.omit(z1)### works
colSums(is.na(z2))

names(z2)
str(z2$Ticket)
a1<-sqldf("select ticket_staff,sum(ticket) from z2 group by ticket_staff")
a1
barplot(z2$Ticket,col = c("red","black","blue"))### increasing number of tickets from 1pm-4pm

str(z2$Amount)

a2<-sqldf("select ticket_staff,sum(Amount) from z2 group by ticket_staff")
a2
#### boxplot
X<-c(a2$Ticket_Staff)
Y<-c(a2$`sum(Amount)`)
boxplot(Y~X,col=c("red","blue","green"))

m1<-if(z2$Amount==z2$Total_for_Processed){
  print("Columns are identical")
}else
{
  print("Not Identical")
}
##########################################
names(z2)
a3<-sqldf("select Status,sum(Amount) from z2 group by status")
a3
#################
windows(height =7,width = 4.5)
pie3D(table(a3$Status),main="Status",col=c("red","black","purple"),explode = 0.2)
legend("topright",c("Open","Processed","Void"),fill=c("red","black","purple"))





