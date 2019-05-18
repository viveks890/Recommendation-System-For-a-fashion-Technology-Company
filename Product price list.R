library(readxl)
library(sqldf)
set.seed(123)
z1<-read_excel("D:\\DATA ANALYSIS\\PROJECT\\VAYA SALON\\vaya.xlsx",sheet = 4)
dim(z1)
colSums(is.na(z1))
names(z1)
a1<-sqldf("select Product_List,sum(Retail_Price) as 'Product_sold' from z1 group by Product_List")
a1
summary(a1)
sqldf("select Product_List from a1 where Product_sold==1424")
sqldf
########### number of products sold ###########
a2<-sqldf("select Product_List from a1 where Product_sold==0.0")
dim(a2)
a3<-sqldf("select Product_List from a1 where Product_sold<>0.0")
dim(a3)