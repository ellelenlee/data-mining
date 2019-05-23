## 1. Pre-processing data 

# Import data and have an overview of database. 
# loading packages and import database 
library(NbClust) 
library(ggplot2) 
library(reshape2) 
library(gridExtra) 
library(fpc) 
library(MASS) 

vehicle<-read.csv("vehicle.csv") 

# Summary overview of `vehicle` database 
head(vehicle) 
summary(vehicle) 
 
# Remove the outliers 
# show the data chart 
melted_vehicle = melt(vehicle[,2:19]) 
tail(melted_vehicle) 
qplot(x=value, data=melted_vehicle) + facet_wrap(~variable, scales='free') 
 
# remove noisy data 
vehicle2<-vehicle[c(-389,-136,-38,-101,-707,-5,-292,-524,-392,-128,-816,-545,-232),] 

# show the data chart again 
melted_vehicle2 = melt(vehicle2[,2:19]) 
tail(melted_vehicle2) 
qplot(x=value, data=melted_vehicle2) + facet_wrap(~variable, scales='free') 
# summary of cleaned data 
summary(vehicle2[,2:19]) 
 
# Scaling  
# normalization 
str(vehicle2) 
data.train<-scale(vehicle2[,2:19]) 
summary(data.train) 


## 2. Find ideal number of clusters 

# NbCluster Method 
#find clustering group number 
#method 1: nbclust 
set.seed(1234) 
nc1<-NbClust(data.train,distance="euclidean",min.nc = 2,max.nc = 15,method = "kmeans") 
nc2<-NbClust(data.train,distance="manhattan",min.nc = 2,max.nc = 15,method = "kmeans") 
nc3<-NbClust(data.train,distance="maximum",min.nc = 2,max.nc = 15,method = "kmeans") 
 
table(nc1$Best.nc[1,]) 
barplot(table(nc1$Best.n[1,]),  xlab="Numer of Clusters--euclidean", ylab="Number of Criteria") 
table(nc2$Best.nc[1,]) 
barplot(table(nc2$Best.n[1,]),  xlab="Numer of Clusters--manhattan", ylab="Number of Criteria") 
table(nc3$Best.nc[1,]) 
barplot(table(nc3$Best.n[1,]),  xlab="Numer of Clusters--maximum", ylab="Number of Criteria") 
 
# Elbow Method 
k<- 2:10 
wss<-sapply(k, function(k){kmeans(data.train,centers = k)$tot.withinss}) 
plot(k,wss,type = "b", xlab="Number of Clusters", ylab="Within groups sum of squares") 
 
 
##3. Fit the K-means models with the best clusters 

# clustering with different numbers of groups 
# Fit the K-means models with the best clusters 
# 2 groups 
fit.km1 <- kmeans(data.train, 2) 
fit.km1 
plotcluster(data.train, fit.km1$cluster) 
 
# 3 groups 
fit.km2 <- kmeans(data.train, 3) 
fit.km2 
plotcluster(data.train, fit.km2$cluster) 
 
# 4 groups 
fit.km3 <- kmeans(data.train, 4) 
fit.km3 
plotcluster(data.train, fit.km3$cluster) 
 
# 5 groups 
fit.km4 <- kmeans(data.train, 5) 
fit.km4 
plotcluster(data.train, fit.km4$cluster) 
 
 
 
## 4. Evaluation the K-means models and Improve 

# Two Clusters 
parcoord(data.train, fit.km1$cluster) 
confuseTable.km1 <- table(vehicle2$Class, fit.km1$cluster) 
confuseTable.km1 
parcoord(data.train, fit.km1$cluster) 
plot(vehicle2[c("Sc.Var.Maxis", "Scat.Ra")], col=fit.km1$cluster) 
plot(vehicle2[c("Kurt.Maxis", "Holl.Ra")], col=fit.km1$cluster) 
points(fit.km1$centers[,c("Sc.Var.axis", "Scat.Ra")], col=1:3, pch=23, cex=3) 
 
#clusting with different numbers of groups 
data.train2<-scale(vehicle2[,c(8,9,12,13)]) 
fit.km4 <- kmeans(data.train2, 2) 
fit.km4 
plotcluster(data.train2, fit.km4$cluster) 
confuseTable.km4 <- table(vehicle2$Class, fit.km4$cluster) 
confuseTable.km4 
 
 
 
# Three Clusters 
# 3 groups 
fit.km2 <- kmeans(data.train, 3) 
fit.km2 
plotcluster(data.train, fit.km2$cluster) 
confuseTable.km2 <- table(vehicle2$Class, fit.km2$cluster) 
confuseTable.km2 
parcoord(data.train, fit.km2$cluster) 
 
data.train2<-scale(vehicle2[,c(5,8,9,13,15)]) 
fit.km5 <- kmeans(data.train2, 3) 
fit.km5 
plotcluster(data.train2, fit.km5$cluster) 
confuseTable.km5 <- table(vehicle2$Class, fit.km5$cluster) 
confuseTable.km5 
 


# Four Clusters 
# 4 groups 
fit.km3 <- kmeans(data.train, 4) 
fit.km3 
plotcluster(data.train, fit.km3$cluster) 
confuseTable.km3 <- table(vehicle2$Class, fit.km3$cluster) 
confuseTable.km3 
 


# Five Clusters
# 5 groups 
fit.km4 <- kmeans(data.train, 5) 
fit.km4
plotcluster(data.train, fit.km4$cluster) 
confuseTable.km4 <- table(vehicle2$Class, fit.km4$cluster) 
confuseTable.km4 
