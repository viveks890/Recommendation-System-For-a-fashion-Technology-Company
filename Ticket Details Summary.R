library(readxl)
library(sqldf)
set.seed(123)
z1<-read_excel("D:\\DATA ANALYSIS\\PROJECT\\VAYA SALON\\vaya.xlsx",sheet=7)
dim(z1)
colSums(is.na(z1))
names(z1)
#### number of customer with Pure Privilegs
a1<-sqldf("select Membership_Type,count(*) as 'Number' from z1 group by Membership_Type")
a1
#### total discount given to each type of members
a2<-sqldf("select Membership_Type,sum(Discount) as 'Total discount' from z1 group by Membership_Type")
a2
