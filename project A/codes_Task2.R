## 1. Pre-processing data

#loading packages and import database
library(NbClust)
library(ggplot2)
library(reshape2)
library(gridExtra)
library(dendextend)
library(caret)
library(corrplot)
library(colorspace)
library(gplots)
vehicle<-read.csv("vehicle.csv")

# Summary overview of `vehicle` database
head(vehicle)
summary(vehicle)

# show the data graphs
boxplot(vehicle)
melted_vehicle = melt(vehicle[,2:19])
tail(melted_vehicle)
qplot(x=value, data=melted_vehicle) + facet_wrap(~variable, scales='free')

# delete noisy data
vehicle2<-vehicle[c(-389,-136,-38,-101,-707,-5,-292,-524,-392,-128,-816,-545,-232),]

# show the data graphs again
melted_vehicle2 = melt(vehicle2[,2:19])
tail(melted_vehicle2)
qplot(x=value, data=melted_vehicle2) + facet_wrap(~variable, scales='free')

#summary of cleaned data
summary(vehicle2[,2:19])

#normalization
str(vehicle2)
data.train<-scale(vehicle2[,2:19])
summary(data.train)

## 2. Hierarchical clustering and dendrograms for different methods

# overall
d_vehicle <- dist(data.train)
hclust_methods <- c("single","complete","average")
vehicle_dendlist <- dendlist()
for(i in seq_along(hclust_methods)) {
hc_vehicle <- hclust(d_vehicle, method = hclust_methods[i])
vehicle_dendlist <- dendlist(vehicle_dendlist, as.dendrogram(hc_vehicle))
}
names(vehicle_dendlist) <- hclust_methods
vehicle_dendlist

#average
set.seed(1234)
clusters <- hclust(dist(data.train,method = "euclidean"),method = 'average')
plot(clusters)
rect.hclust(clusters, k=3, border="blue")
rect.hclust(clusters, k=2, border="red")
clusterCut <- cutree(clusters, 2)
table(clusterCut, vehicle2$Class)
ggplot(vehicle2, aes(Scat.Ra, Sc.Var.Maxis, color = Class)) + geom_point()

#complete
set.seed(1234)
clusters2<- hclust(dist(data.train,method = "euclidean"),method = 'complete')
plot(clusters2)
rect.hclust(clusters2, k=3, border="blue")
rect.hclust(clusters2, k=2, border="red")
clusterCut2 <- cutree(clusters2, 2)
table(clusterCut2, vehicle2$Class)

#single
set.seed(1234)
clusters3<- hclust(dist(data.train,method = "euclidean"),method = 'single')
plot(clusters3)
rect.hclust(clusters3, k=3, border="blue")
rect.hclust(clusters3, k=2, border="red")
clusterCut3 <- cutree(clusters3, 200)
table(clusterCut3, vehicle2$Class)


##3. Cophenetic correlation and Coorplot function

#Cophenetic correlation and Coorplot -- different methods: pearson, spearman,common
#pearson
vehicle_dendlist_cor <- cor.dendlist(vehicle_dendlist)
vehicle_dendlist_cor
corrplot::corrplot(vehicle_dendlist_cor, "pie", "lower")

#spearman
vehicle_dendlist_cor <- cor.dendlist(vehicle_dendlist, method_coef = "spearman")
vehicle_dendlist_cor
corrplot::corrplot(vehicle_dendlist_cor, "pie", "lower")

#plot
par(mfrow = c(2,2))
for(i in 1:3) {
vehicle_dendlist[[i]] %>% set("branches_k_color", k=2) %>% plot(axes = FALSE, horiz = TRUE)
title(names(vehicle_dendlist)[i])
}

#common
vehicle_dendlist_cor <- cor.dendlist(vehicle_dendlist, method = "common")
vehicle_dendlist_cor
corrplot::corrplot(vehicle_dendlist_cor, "pie", "lower")
