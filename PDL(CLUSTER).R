library(readxl)
library(cluster)
library(factoextra)
library(fpc)
library(readr)
library(psych)
z1<-read_excel("D:/DATA ANALYSIS/PROJECT/VAYA SALON/vaya.xlsx", 
    sheet = "Product Detail List", col_types = c("text", 
               "numeric", "text", "text", "text", 
               "text", "text", "text", "numeric", 
               "numeric", "numeric", "numeric", 
               "numeric", "numeric", "text", "text", 
               "text", "text"))
names(z1)
z2<-subset(z1,select=c(On_HandQty,Cost,Retail_Price))
############## Removing Skewness in cost and Retail price
z2$Cost<-sqrt(z2$Cost)
z2$Retail_Price<-sqrt(z2$Retail_Price)
describe(z2)
z2$Cost<-sqrt(z2$Cost)
describe(z2)
names(z2)
############ determining number of clusters
wss<-0
for(i in 1:15){
  wss[i]<-sum(kmeans(z2,centers = i)$withinss)
}
plot(1:15,wss,type="b",col="orange")
wss[3]-wss[4]
wss[4]-wss[5]
wss[5]-wss[6]
########### clustering with 4 clusters
set.seed(123)
z3<-scale(z2)
clus<-kmeans(z3,4)
clus$withinss
clus$betweenss
clus$size
########### silhouette coefficient
diss<-daisy(z2)
diss1<-diss^2
silcof<-silhouette(clus$cluster,diss1)
plot(silcof,col="red")
########### plotting
fviz_cluster(clus,z2)
########### appending
z4<-data.frame(z1,Cluster=clus$cluster)
############################################
#write.csv(z4,"D:\\DATA ANALYSIS\\PROJECT\\VAYA SALON\\Modelling\\PDL(CLUSTERS).csv")

library(readr)
library(sqldf)
z5<-read.csv("D:\\DATA ANALYSIS\\PROJECT\\VAYA SALON\\Modelling\\PDL(CLUSTERS).csv")
View(z5)
names(z5)
z6<-subset(z5,select=c(On_HandQty,Cost,Retail_Price,Cluster))
View(z6)

t1<-sqldf("select sum(retail_price)/count(retail_price) from z6 where cluster==4")
t1

