###VISUALIZE SATELLITE DATA###


install.packages("devtools")
devtools::install_github("ducciorocchini/imageRy") 
library(devtools)
library(imageRy)
library(terra)

10 + 10 #simple operation
duccio <- 10 + 10 #this is an object
duccio
adam <- 5+3 #objects
duccio + adam

#Arrays
diameter <- c(100, 10, 50, 20, 15)
iron <- c(10, 1000, 20, 700, 900)

#Function
plot(iron, diameter) #iron and diameter are arguments
plot(iron, diameter, pch=19)
plot(iron, diameter, pch=19, cex=2)
plot(iron, diameter, pch=19, cex=2, col="red")

?plot() #if you want info about functions

im.list() #now we'll use a package
#Importing data, Blue band
b2 <- im.import("sentinel.dolomites.b2.tif") #b2 is blue wavelenght
b2
#Green band
b3 <- im.import("sentinel.dolomites.b3.tif") #b3 is the green wavelenght
b3
#Red dand
b4 <- im.import("sentinel.dolomites.b4.tif")
b4
#NIR band
b8 <- im.import("sentinel.dolomites.b8.tif")
b8

plot(b2)
c1 <- colorRampPalette(c("darkblue", "blue", "lightblue")) (100)
plot(b2, col=c1)

#Exercise 1: plot the green band with a new color palette
plot(b3)
c2 <- colorRampPalette(c("darkgreen", "green", "lightgreen")) (100)
plot(b3, col=c2)

#Exercise 2: plot all the bands
par(mfrow=c(2,2))
c3 <- colorRampPalette(c("darkred", "red","darkorange")) (100)
c4 <- colorRampPalette(c("purple", "violet", "pink")) (100)
plot(b2, col=c1)
plot(b3, col=c2)
plot(b4, col=c3)
plot(b8, col=c4)

##Sentinel-2 image
sentdo <- c(b2, b3, b4, b8)
clall <- colorRampPalette(c("black", "darkgrey", "grey")) (100)
plot(sentdo, col=clall)
plot(sentdo[[4]]) #to consider only one element

dev.off() #cleaning graphs

##RGB space##
im.plotRGB(sentdo, 3, 2, 1) #it plots the first 3 layers in the RGB components
im.plotRGB(sentdo, 4, 3, 2) #now I use also NIR 

#Multiframe with the natural colors image and the false color image
par(mfrow=c(1,2))
im.plotRGB(sentdo, 3, 2, 1)
im.plotRGB(sentdo, 4, 3, 2)

im.plotRGB(sentdo, 3, 4, 2)
im.plotRGB(sentdo, 3, 2, 4)

#What is the band carrying the highest information?
pairs(sentdo)

--------------------------
#Importing different bands then changing their colors
b2 <- im.import("sentinel.dolomites.b2.tif") #Importing the data named sentinel.dolomites
c1 <- colorRampPalette(c("black", "grey", "lightgrey")) (100)
plot(b2, col=c1)
b3 <- im.import("sentinel.dolomites.b3.tif")
plot(b3, col=c1)
b4 <- im.import("sentinel.dolomites.b4.tif")
plot(b4, col=c1)
b8 <- im.import("sentinel.dolomites.b8.tif")
plot(b8, col=c1)

#Comparing all the images to see the differences
par(mfrow = c(2,2))
plot(b2, col=c1)
plot(b3, col=c1)
plot(b4, col=c1)
plot(b8, col=c1)

#STACK IMAGES - now the images should become one thing 
stacksent <- c(b2, b3, b4, b8) #sent is for sentinel
stacksent
dev.off() #it closes all the devices
plot(stacksent, col=c1)
plot(stacksent[[4]], col=c1) #double parenthesis because it's in 2 dimension


#Exercise: plot in a mf the bands with different color ramps
c2 <- colorRampPalette(c("black", "blue", "lightblue")) (100)
plot(b2, col=c2)
c3 <- colorRampPalette(c("black", "green", "lightgreen")) (100)
plot(b3, col=c3)
c4 <- colorRampPalette(c("black", "darkred", "red")) (100)
plot(b4, col=c4)
c8 <- colorRampPalette(c("black", "orange", "yellow")) (100)
plot(b8, col=c8)
par(mfrow = c(2,2))


###RGB###
#It's red-green-blue space, so we can use just 3 bands at a time
#x is the image then there are the bands
#stacksent: 
#b2 blue element 1, stacksent [[1]] 
#b3 green element 2, stacksent [[2]]
#b4 red element 3, stacksent [[3]]
#b8 nir element 4
im.plotRGB(stacksent, r=3, g=2, b=1) #we see the plant with a very low spectro resolution










