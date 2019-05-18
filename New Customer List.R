library(readxl)
library(sqldf)
library(plotrix)
library(RColorBrewer)
set.seed(123)
z1<-read_excel("D:\\DATA ANALYSIS\\PROJECT\\VAYA SALON\\vaya.xlsx",sheet=2)
dim(z1)
colSums(is.na(z1))
summary(z1)
######## Returned
table(z1$Returned)

windows(height = 8,width=4)
pie3D(table(z1$Returned),main = "Customer Returned",col=brewer.pal(n=2,"Set1"),explode = 0.1)
legend("topright",c("YES","NO"),fill =brewer.pal(n=2,"Set1"),cex=0.7)

