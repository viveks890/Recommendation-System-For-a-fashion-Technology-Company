library(readxl)
library(sqldf)
library(plotrix)
library(RColorBrewer)
library(psych)
set.seed(123)
z1<- read_excel("D:/DATA ANALYSIS/PROJECT/VAYA SALON/vaya.xlsx", 
                sheet = "Product Detail List", col_types = c("text", 
                                                             "date", "text", "text", "text", 
                                                             "text", "text", "text", "numeric", 
                                                             "numeric", "numeric", "numeric", 
                                                             "numeric", "numeric", "text", "text", 
                                                             "text", "text"))

dim(z1)
colSums(is.na(z1))
z1$Status<-as.factor(z1$Status)
z1$Status<-ifelse(z1$Status=="'Active'",1,0)
z1$Vendor<-as.factor(z1$Vendor)
z1$Vendor<-ifelse(z1$Vendor=="'Aveda'",1,0)
z1$Man<-as.factor(z1$Man)
z1$Man<-ifelse(z1$Man=="'Aveda'",1,ifelse(z1$Man=="'Not Listed'",0,ifelse(z1$Man=="'T3'",2,3)))

## aveda=1,not listed=0,t3=2,wet brush=3

z1$Type<-as.factor(z1$Type)
z1$Type<-ifelse(z1$Type=="'Prof'",1,0)

##### prof=1,retail=0

table(z1$`Print Labels`)
z1$`Print Labels`[1]<-"'No'"
z1$`Print Labels`<-as.factor(z1$`Print Labels`)
str(z1$`Print Labels`)
z1$`Print Labels`<-ifelse(z1$`Print Labels`=="'Yes'",1,0)
z1$Subcategory<-as.factor(z1$Subcategory)
z1$Subcategory<-as.integer(z1$Subcategory)
z1$`Product List`<-as.factor(z1$`Product List`)
z1$`Product List`<-as.integer(z1$`Product List`)
colSums(is.na(z1))
which(is.na(z1$Subcategory))
z1<-na.omit(z1)
colSums(is.na(z1))
describe(z1)
#########################
table(z1$Type)
windows(height = 7,width = 4.5)
barplot(table(z1$Type),ylim=c(0,700),col=brewer.pal(n=2,"Set2"),ylab="Units Sold",xlab = "Type") 
legend("topleft",c("Retail","Professional"),fill=brewer.pal(n=2,"Set2"))
#########################
library(plotrix)
windows(height=7,width = 4.5)
pie3D(table(z1$Type),explode=0.1,col =brewer.pal(n=2,"Accent"),main="Type of Products")
legend("topright",c("Retail","Professional"),fill=brewer.pal(n=2,"Accent"))
table(z1$Type)

######################################################################################
######## cost wrt manufacturer #############

names(z1)
z2<-subset(z1,select=c(Cost,Man))
names(z2)

library(sqldf)
a1<-sqldf("select sum(cost),man from z2 group by man")
a1
a2<-sqldf("select cost from z2 where man==1")
median(a2$Cost)
a3<-sqldf("select cost from z2 where man==2")
median(a3$Cost)
a4<-sqldf("select cost from z2 where man==0")
median(a4$Cost)
a5<-sqldf("select cost from z2 where man==3")
median(a5$Cost)

################ more products from aveda as compared to others but costing less

###################### products wrt to type ####################################

names(z1)
z3<-subset(z1,select=c(Type,Cost))
####prof=1,retail=0

v1<-sqldf("select cost from z3 where type=1")
median(v1$Cost)

v2<-sqldf("select cost from z3 where type=0")
median(v2$Cost)


