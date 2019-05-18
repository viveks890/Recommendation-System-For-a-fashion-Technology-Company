library(readxl)
library(cluster)
library(factoextra)
library(fpc)
library(readr)
z1<-read_excel("D:\\DATA ANALYSIS\\PROJECT\\VAYA SALON\\vaya.xlsx",sheet="Ticket Detail Summary")
names(z1)
z2<-subset(z1,select=c(Total_Sales,Other_Sales,Service_Sales,Product_Sales,Discount))
names(z2)
########## detrmining number of clusters
set.seed(123)
wss<-0
for(i in 1:15){
  wss[i]<-sum(kmeans(z2,centers=i)$withinss)
}
plot(1:15,wss,type="b",col="blue")
wss[4]-wss[5]
wss[5]-wss[6]
######## clustering with 5 clusters
z3<-scale(z2)
clus<-kmeans(z3,5)
clus$withinss
clus$betweenss
clus$size
clus$iter
######### silhouette coefficient
diss<-daisy(z3)
diss1<-diss^2
silcof<-silhouette(clus$cluster,diss1)
plot(silcof,col="green")
d<-dist(z3,method="euclidean")
######## plotting
fviz_cluster(clus,z3)
clusplot(z3,clus$cluster,color=T,shade = T)
######## appending
z4<-data.frame(z1,Cluster=clus$cluster)
############################################
#write.csv(z4,"D:\\DATA ANALYSIS\\PROJECT\\VAYA SALON\\Modelling\\TDS(CLUSTER).csv")
library(readr)
library(sqldf)
z6<-read.csv("D:\\DATA ANALYSIS\\PROJECT\\VAYA SALON\\Modelling\\TDS(CLUSTER).csv")
z7<-subset(z6,select = c(Total_Sales,Other_Sales,Service_Sales,Product_Sales,Discount,Cluster))
View(z7)
t1<-sqldf("select sum(total_sales)/count(total_sales) from z7 where cluster==5")
t1
