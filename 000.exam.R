###DUCCIO EXAM###

#Importing packages

library(imageRy)
library(terra)
library(viridis)
library(ggplot2)
library(patchwork)

#Importing images downloaded from Copernicus browser

setwd("C:/Users/Massimiliano/Desktop/Materiale Ecology in R/Duccio's exam")

#Importing true color images

suppressWarnings({
  luglio21 <- rast("pre-incendio tc.jpg")
  agosto21 <- rast("post-incendio tc.jpg")
  agosto23 <- rast("agosto 23 tc.jpg") #we'll use it at the end
})
# band 1 = Red
# band 2 = Green
# band 3 = Blue

#Importing false color images

suppressWarnings({
  fcluglio21 <- rast("pre-incendio fc.jpg")
  fcagosto21 <- rast("post-incendio fc.jpg")
  fcagosto23 <- rast("agosto 23 fc.jpg") #we'll use it at the end
})
# band 1 = NIR
# band 2 = Red
# band 3 = Green

#Let's visualize those images together

par(mfrow=c(2,2))
plot(luglio21) #before fire
plot(agosto21) #after fire
plot(fcluglio21) #before fire fc
plot(fcagosto21) #after fire fc

dev.off()

##Spectral indices

# DVI

dviBF = fcluglio21[[1]] - fcluglio21[[2]]
dviAF = fcagosto21[[1]] - fcagosto21[[2]]

# NDVI

ndviBF = dviBF/(fcluglio21[[1]] + fcluglio21[[2]])
ndviAF = dviAF/(fcagosto21[[1]] + fcagosto21[[2]])

par(mfrow=c(1,2))
plot(ndviBF, col=magma(100), main="before fire")
plot(ndviAF, col=magma(100), main="after fire")

dev.off()

##Classification

suppressWarnings({
  lu21c <- im.classify(ndviBF, num_clusters = 2) #classificazione non visionata
  ag21c <- im.classify(ndviAF, num_clusters = 2)
})

# class 1 = vegetation
# class 2 = bare soil

classnames <- c("Vegetation", "Bare soil")
GW <- colorRampPalette(c("forestgreen", "white"))(2)
par(mfrow=c(2,1))
plot(lu21c, col=GW, type="classes", levels=classnames, main="before fire")
plot(ag21c, col=GW, type="classes", levels=classnames, main="after fire")

dev.off()

#Now we want to calculate the classes' percentages for a quantitative comparison

#Let's calculate the classes' frequencies
flu21 <- freq(lu21c)
fag21 <- freq(ag21c)

#Let's calculate the percentages
plu21 <- (flu21/ncell(lu21c))*100
pag21 <- (fag21/ncell(ag21c))*100
plu21 # vegetation = 51,1%,  bare soil = 48,9%
pag21 # vegetation = 35,1%, bare soil = 64,9%

#Let's create arrays for the classes' values
ylu21 <- c(51, 49)
yag21 <- c(35, 65)

#Now we create the dataframe
DF <- data.frame(classnames, ylu21, yag21)
DF

#Now we visualize those data graphically

glu21 <- ggplot(DF, aes(x=classnames, y=ylu21, color=classnames)) +
  geom_bar(stat="identity", aes(fill=classnames)) + ylim(c(0,100)) +
  ggtitle("Before fire") + xlab("Classes") + ylab("Percentage")

gag21 <- ggplot(DF, aes(x=classnames, y=yag21, color=classnames)) +
  geom_bar(stat="identity", aes(fill=classnames)) + ylim(c(0,100)) +
  ggtitle("After fire") + xlab("Classes") + ylab("Percentage")

glu21 + gag21


##Let's calculate the spectral variability 

# July 2021
pairs(fcluglio21) #the correlation between bands is pretty low
pclu21 <- im.pca2(fcluglio21)
# PC1 = 44.2, PC2 = 26.2, PC3 = 4.3

totpcL <- sum(44.222716, 26.204578,  4.305954)
# percentages of variability from principal components
(44.222716/totpcL)*100 # PC1 = 59.2%
(26.204578/totpcL)*100 # PC2 = 35%
(4.305954/totpcL)*100 # PC3 = 5.8%

# August 2021
pairs(fcagosto21)
pcag21 <- im.pca2(fcagosto21)
# PC1 = 54.2, PC2 = 31.6, PC3 = 3.2

totpcA <- sum(54.209964, 31.622260,  3.199238)
(54.209964/totpcA)*100 # PC1 = 60.9%
(31.622260/totpcA)*100 # PC2 = 35.5%
(3.199238/totpcA)*100 # PC3 = 3.6%

#Let's use the method of the moving window on PC1 

# July 2021
sdL3 <- focal(pclu21$PC1, matrix(1/9, 3, 3), fun=sd) 
sdL9 <- focal(pclu21$PC1, matrix(1/81, 9, 9), fun=sd)

# August 2021
sdA3 <- focal(pcag21$PC1, matrix(1/9, 3, 3), fun=sd)
sdA9 <- focal(pcag21$PC1, matrix(1/81, 9, 9), fun=sd)

#Now we plot the 4 images 
stack <- c(sdL3, sdL9, sdA3, sdA9)
plot(stack, col=viridis(100))

#par(mfrow=c(2,2))
#plot(sdL3, col=viridis(100), main="Before fire (MW3x3)")
#plot(sdL9, col=viridis(100), main="Before fire (MW9x9)")
#plot(sdA3, col=viridis(100), main="After fire (MW3x3)")
#plot(sdA9, col=viridis(100), main="After fire (MW9x9)")


##Let's compare 2021 with 2023

par(mfrow=c(1,2)) #compare tc images
plot(luglio21, main="July 2021") 
plot(agosto23, main="August 2023")

#Let's calculate NDVI for august 2023

dvi23 <- fcagosto23[[1]] - fcagosto23[[2]]
ndvi23 <- dvi23/(fcagosto23[[1]] + fcagosto23[[2]])

#Let's calculate the NDVI difference between images 

dif21 = ndviAF - ndviBF
dif23 = ndvi23 - ndviBF
coldif <- colorRampPalette(c("blue3", "white", "red2"))(100)
par(mfrow=c(1,2))
plot(dif21, col=coldif, main="Right after the fire")
plot(dif23, col=coldif, main="Two years after the fire")



