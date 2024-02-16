# Final script including all the different scripts during lectures

#---------------------

# Summary:
# 01 Beginning
# 02.1 Population density
# 02.2 Population distribution
# 03.1 Community multivariate analysis
# 03.2 Community overlap
# 04 Remote sensing data visualisation
# 05 Spectral indices
# 06 Time series
# 07 External data
# 08 Copernicus data
# 09 Classification
# 10 Variability
# 11 Principal Component Abalysis

#---------------------

# 01 Beginning

# Here I can write anything I want!!! 42 is the meaning of life univcerse and all!

# R as a calculator
2 + 3

# Assign to an object
zima <- 2 + 3
zima

duccio <- 5 + 3
duccio

final <- zima * duccio
final

final^2

# array
sophi <- c(10, 20, 30, 50, 70) # microplastics 
# fcuntions have parentheses and inside them there are arguments

paula <- c(100, 500, 600, 1000, 2000) # people

plot(paula, sophi)

plot(paula, sophi, xlab="number of people", ylab="microplastics")


people <- paula
microplastics <- sophi

plot(people, microplastics)
plot(people, microplastics, pch=19)
# https://www.google.com/search?client=ubuntu-sn&hs=yV6&sca_esv=570352775&channel=fs&sxsrf=AM9HkKknoSOcu32qjoErsqX4O1ILBOJX4w:1696347741672&q=point+symbols+in+R&tbm=isch&source=lnms&sa=X&ved=2ahUKEwia9brkm9qBAxVrQvEDHbEYDuMQ0pQJegQIChAB&biw=1760&bih=887&dpr=1.09#imgrc=lUw3nrgRKV8ynM

plot(people, microplastics, pch=19, cex=2)
plot(people, microplastics, pch=19, cex=2, col="blue")

#---------------------

# 02.1 Population density

##Code related to population ecology

#A package is needed for point pattern analysis
install.packages("spatstat") #putting external data inside R
library(spatstat) #to use the package you need the function library
install.packages("terra")
library(terra)

#Let's use the bei dataset, related to trees in the tropical forest
#Data description
#https://CRAN.R-project.org/package=spatstat

bei 

plot (bei) #plotting the data
plot(bei, cex =.2) #changing dimension - cex
plot(bei, cex=.2, pch=19) #changing the symbol
plot(bei, pch=19, cex=5)

bei.extra #addictional dataset
plot(bei.extra) #there are 2 variables inside, elevation and gradient
plot(bei.extra[[1]]) #I just want the first plot of bei.extra

#Using only part of the dataset - elev
plot(bei.extra$elev)
elevation <- bei.extra$elev
plot(elevation)

#Other method to select elements
elev <- bei.extra[[1]] 
plot(elev)

density_map <- density(bei) #passing from points to a continuous surface
density_map #tells you in console that it uses pixels instead of points
points(bei, cex=.2) #adding points to the continuous surface


##MULTIFRAME (mf) - put more than one plot together
par(mfrow=c(1,2)) #stating that mf has 1 row and 2 columns
plot(elev)
plot(density_map) 
#after doing par, you decide which plots you want to put in it
par(mfrow=c(2,1)) #my new mf has 2 rows and 1 column
plot(elev)
plot(density_map)
#doing so you can see that at higher elevations you have less trees

#Exercise
par(mfrow=c(1,3))
plot(elev)
plot(density_map)
plot(bei)
#created a new mf with 3 variables 

#To change the colors of the graph
c1 <- colorRampPalette(c("black", "red", "orange","yellow"))(100)
#the 100 are the number of color's shades that will appear in the graph  
plot(bei.extra[[1]], col=c1) #Changed the colors of the graph
plot(density_map, col=c1) #same thing with the other graph

#Exercise
cl2 <- colorRampPalette(c("cyan3", "bisque", "blueviolet", "coral3"))(100)
plot(density_map, col=cl2) 

#---------------------

#Why populations disperse over the landscape in a certain manner?
file <- system.file("external/species.shp", package="sdm")

rana <- vect(file)
rana$Occurrence
plot(rana)

#Selecting presences 
pres <- rana[rana$Occurrence==1, ] #selected only part of the occurrence
plot(pres)

##Exercise 1: select absence and call them abse
abs <- rana[rana$Occurrence==0, ]
plot(abs)

##Exercise 2: plot presences and absences one beside the other
par(mfrow=c(1,2))
plot(pres)
plot(abs)

#Our new friend in case of graphical nulling:
dev.off()

##Exercise 3: plot pres and abs altogether with 2 different colors
plot(pres, col="dark blue")
points(abs, col="light blue")
#I obtain all the points together in the plot with different colors

###PREDICTORS: environmental variables 

#elevation predictor
elev <- system.file("external/elevation.asc", package="sdm")
elevmap <- rast(elev) #from terra package
plot(elevmap)
points(pres, cex=.5)
#I obtained the map with the points indicating frogs' presence

#Temperature predictor
temp <- system.file("external/temperature.asc", package="sdm")
tempmap <- rast(temp) #from terra package
plot(tempmap)
points(pres, cex=.5)

##Exercise 4: do the same with vegetation cover
vege <- system.file("external/vegetation.asc", package="sdm")
vegemap <- rast(vege) 
plot(vegemap)
points(pres, cex=.5)

prec <- system.file("external/precipitation.asc",package="sdm")
precmap <- rast(prec)
plot(precmap)
points(pres, cex=.5)


###FINAL MULTIFRAME
par(mfrow=c(2,2))
plot(elevmap)  #adding elev
points(pres, cex=.5)
plot(tempmap) #adding temp
points(pres, cex=.5)
plot(vegemap)
points(pres, cex=.5)
plot(precmap)
points(pres, cex=.5)

#---------------------

# 03.1 Community multivariate analysis

##Install vegan package 
install.packages("vegan")
library(vegan)
data(dune)
ord <- decorana(dune)
ord

##Call: decorana(veg = dune)
#Detrended correspondence analysis with 26 segments.
#Rescaling of axes with 4 iterations. 

plot(ord)

head(dune)
ord <- decorana(dune)

ldc1 = 3.7004
ldc2 = 3.1166
ldc3 = 1.30055
ldc4 = 1.47888
total = ldc1 + ldc2 + ldc3 + ldc4

pldc1 = ldc1 * 100 / total
pldc2 = ldc2 * 100 / total
pldc3 = ldc3 * 100 / total
pldc4 = ldc4 * 100 / total
pldc1
pldc2
pldc1 + pldc2
plot(ord)

#---------------------

# 03.2 Community overlap

##Relation among species in time
install.packages("overlap")
library(overlap)

data(kerinci) #data
summary(kerinci)
head(kerinci)

#The unit of time is the day, so values range from 0 to 1
#The package works entirely in radians: fitting density curves uses trigonometric functions (sin, cos, tan)

kerinci$timeRad <- kerinci$Time * 2 * pi #this speeds up simulations, the conversion is straightforward with the operation

#I want only the data on tiger individuals 
tiger <- kerinci[kerinci$Sps=="tiger", ] #selecting the species
timetig <- tiger$timeRad #selecting time for the tiger
densityPlot(timetig, rug=TRUE)

#Exercise 1: select only the data on macaque individuals
macaque <- kerinci[kerinci$Sps=="macaque", ]
head(macaque)
timemac <- macaque$timeRad
densityPlot(timemac, rug=TRUE)

overlapPlot(timetig, timemac) #overlap the two graphs
legend("topright", c("Tigers", "Macaques"), lty=c(1,2), col=c("black", "blue"), bty="n")

#Species
kerinci$Sps
summary(kerinci$Sps)

#Tapir
tap <- kerinci[kerinci$Sps == 'tapir', ]
timetap <- tap$timeRad
densityPlot(timetap, rug=TRUE)

overlapPlot(timemac, timetap)

#---------------------

# 04 Remote sensing data visualisation

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

#---------------------

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

#---------------------

# 05 spectral indices

###VEGETATION INDICES###

library(imageRy)
library(terra)
im.list()
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")

#Bands: 1=NIR, 2=RED, 3=GREEN 
im.plotRGB(m1992, r=1, g=2, b=3)
im.plotRGB(m1992, 1, 2, 3)
im.plotRGB(m1992, r=2, g=1, b=3)
im.plotRGB(m1992, r=2, g=3, b=1)

#Import the recent image
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(m2006, r=2, g=3, b=1)

#Build a multiframe with 1992 and 2006 together
par(mfrow=c(1,2))
im.plotRGB(m1992, r=2, g=3, b=1)
im.plotRGB(m2006, r=2, g=3, b=1)

#DVI = NIR - RED
#Bands: 1=NIR, 2=RED, 3=GREEN
dvi1992 = m1992[[1]] - m1992[[2]]
plot(dvi1992)
c1 <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(dvi1992, col=c1)

##CALCULATE DVI OF 2006
dvi2006 = m2006[[1]] - m2006[[2]]
plot(dvi2006, col=c1)

#NDVI
ndvi1992 = (m1992[[1]] - m1992[[2]]) / (m1992[[1]] + m1992[[2]])
ndvi1992 = dvi1992 / (m1992[[1]] + m1992[[2]])
plot(ndvi1992, col=c1)

ndvi2006 =dvi2006 / (m2006[[1]] + m2006[[2]])
plot(ndvi2006, col=c1)

par(mfrow=c(1,2))
plot(ndvi1992, col=c1)
plot(ndvi2006, col=c1)

clvir <- colorRampPalette(c("violet", "darkblue","blue", "green", "yellow")) (100)
par(mfrow=c(1,2))
plot(ndvi1992, col=clvir)
plot(ndvi2006, col=clvir)

#Speeding up calculation
ndvi2006a <- im.ndvi(m2006, 1, 2)
plot(ndvi2006a, col=c1)

#---------------------

# 06 Time series

library(imageRy)
library(terra)

im.list()

#Import data
EN01 <- im.import("EN_01.png")
EN13 <- im.import("EN_13.png")
par(mfrow=c(2, 1))
im.plotRGB.auto(EN01)
im.plotRGB.auto(EN13)

#using the first element (band) of images
dif = EN01[[1]] - EN13[[1]] #in this way I see the difference between the 2 images
plot(dif)

cldif <- colorRampPalette(c("blue", "white", "red")) (100)
plot(dif, col=cldif)

###TEMPERATURE IN GREENLAND###
im.list()
g2000 <- im.import("greenland.2000.tif")
g2000
clg <- colorRampPalette(c("black","blue", "white", "red")) (100)
plot(g2000, col=clg)
g2005 <- im.import("greenland.2005.tif")
g2010 <- im.import("greenland.2010.tif")
g2015 <- im.import("greenland.2015.tif")

par(mfrow=c(2,1))
plot(g2000, col=clg)
plot(g2015, col=clg)

stackg <- c(g2000, g2005, g2010, g2015) #I put the 4 images together
plot(stackg, col=clg) #Plotting the 4 images without the function mf

#Make the difference between first and final elements of stack
difg = g2000[[1]] - g2015[[1]]
plot(difg, col=clg)
difg = stackg[[1]] - stackg[[4]] #alternative method 
plot(difg, col=cldif)

#Make an RGB plot using different years
im.plotRGB(stackg, r=1, g=2, b=3) #it's blueish that means that T was lower in the last period 

#---------------------

# 07 External data

setwd("C:/Users/Massimiliano/Downloads") #set working directory
library(terra)
naja <- rast("Najafiraq.Image.EarthObservatory.jpg") #it's the same function as im.import that we used until now
plot(naja)
plotRGB(naja, r=1, g=2, b=3)

#Download another image from the same site and import it in here
setwd("C:/Users/Massimiliano/Downloads")
najaaug <- rast("Najafiraq.Image.2.jpg")
plotRGB(najaaug, r=1, g=2, b=3)
najadif = naja[[1]] - najaaug[[1]]
cl <- colorRampPalette(c("brown", "grey", "orange")) (100) 
plot(najadif, col=cl)

#Download your own image
sakura <- rast("sakurajima_oli_2015141_lrg.jpg")
plotRGB(sakura, r=1, g=2, b=3)
plotRGB(sakura, r=2, g=3, b=1)
plotRGB(sakura, r=3, g=1, b=2)
par(mfrow=c(1,3))


#Matogrosso image can be downloaded directly from EO-NASA

#---------------------

# 08 Copernicus data

install.packages("ncdf4")
library(ncdf4)
library(terra)
setwd("C:/Users/Massimiliano/Downloads")
SoilM2023 <- rast("c_gls_SSM1km_202311250000_CEURO_S1CSAR_V1.2.1.nc")
SoilM2023
plot(SoilM2023) #there are 2 images, the important one is ssm
plot(SoilM2023[[1]]) #now I want to plot just the first image
cl <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(SoilM2023[[1]], col=cl)

##Crop the image
ext <- c(24, 26, 55, 57) #minlong, maxlong, minlat, maxlat
SoilM2023c <- crop(SoilM2023, ext) #we use the function crop to modify the image
plot(SoilM2023c) 
plot(SoilM2023c[[1]], col=cl)

#New image
SM2020 <- rast("c_gls_SSM1km_202010090000_CEURO_S1CSAR_V1.1.1.nc")
plot(SM2020)
SM2020crop <- crop(SM2020, ext)
plot(SM2020crop)
plot(SM2020crop[[1]], col=cl)

#---------------------

# 09 Classification

###Classifying satellite images### 

#Estimating the amount of change 
library(terra)
library(imageRy)
install.packages("patchwork")
library(patchwork)
im.list()

sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
#From the plot you can see that there are three levels of intensity 
sunc <- im.classify(sun, num_clusters = 3) 
plot(sunc)
par(mfrow=c(1,2))
dev.off()
plotRGB(sun, 1, 2, 3)

##Classify satellite data
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")                    
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")    
#in this combination water should be black but there are several deposits inside so its white
#We'll use 2 clusters
m1992c <- im.classify(m1992, num_clusters = 2)
plot(m1992c[[1]])
#Classes: forest=1; human=2
m2006c <- im.classify(m2006, num_clusters = 2)
plot(m2006c[[1]])
#Classes: forest=2; human=1
par(mfrow=c(1,2))

##Let's calculate what is the proportion of each class
f1992 <- freq(m1992c[[1]])
f1992 #it tell me the frequency 
tot1992 <- ncell(m1992c[[1]]) #it tells me the total number of pixels
tot1992
p1992 <- f1992 * 100 / tot1992 #it gives me the percentage 
p1992 #the values we're interested in are the counts
#Forest: 83%; Humans: 17%

#Percentage of 2006
f2006 <- freq(m2006c[[1]])
f2006
tot2006 <- ncell(m2006c[[1]])
tot2006
p2006 <- f2006 * 100 / tot2006
p2006
#Forest: 45%; Humans: 55%

##Building the final table 
class <- c("forest", "human")
y1992 <- c(83, 17)
y2006 <- c(45, 55)
tab <- data.frame(class, y1992, y2006)
tab

##Creating the final plot
library(ggplot2)
p1 <- ggplot(tab, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
#With aes(aesthetic)  and with geom_bar you choose an istogram 
p2 <- ggplot(tab, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")  
p1 + p2 #this way we can see the 2 istograms next to each other

##Final plot rescaled
p1 <- ggplot(tab, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tab, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2 #the scale it's clearer because we add the 0-100 tab behind the graphs

#---------------------

# 10 Variability

library(imageRy)
library(terra)
library(viridis)

im.list()

sent <- im.import("sentinel.png")
# band 1 = NIR 
# band 2 = red
# band 3 = green
im.plotRGB(sent, 1, 2, 3) 
im.plotRGB(sent, r=2, g=1, b=3)

nir <- sent[[1]]
plot(nir)

##MOVING WINDOW##
#You move a window of 3x3 pixels from place to place making the calculation of standard variation and the value to calculate has to be in the centre of your moving window
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd) #matrix indicates the dimension, and after you have to specify the function
plot(sd3)
viridis <- colorRampPalette(viridis(7)) (255)
plot(sd3, col=viridis)

#Calculate variability in a 7x7 pixels moving window
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
plot(sd7, col=viridisc)

par(mfrow=c(1,2))
plot(sd3, col=viridisc)
plot(sd7, col=viridisc)

im.plotRGB(sent, r=2, g=1, b=3)
plot(sd7, col=viridisc)

#---------------------

# 11 Principal Component Analysis

#We'll perform the PCA and use PC1 to calculate sd 

library(imageRy)
library(terra)
library(viridis)
im.list()

sent <- im.import("sentinel.png")

#Perform PCA on sent: 
pairs(sent)
sentpc <- im.pca2(sent)
sentpc
pc1 <- sentpc$PC1
plot(pc1)
viridisc <- colorRampPalette(viridis(7))(255)
plot(pc1, col=viridisc)

#Calculating sd on top of pc1:
pc1sd3 <- focal(pc1, matrix(1/9, 3,3), fun=sd)
plot(pc1sd3, col=viridisc)
pc1sd7 <- focal(pc1, matrix(1/49, 7,7), fun=sd)
plot(pc1sd7, col=viridisc)

par(mfrow=c(2,3))
im.plotRGB(sent, 2, 1, 3)

#Sd from the variability script:
plot(sd3, col=viridisc) 
plot(sd7, col=viridisc) 
plot(pc1, col=viridisc)
plot(pc1sd3, col=viridisc)
plot(pc1sd7, col=viridisc)

#Stack all the standard deviation layers: 
sdstack <- c(sd3, sd7, pc1sd3, pc1sd7)
plot(sdstack, col=viridisc)
names(sdstack) <- c("sd3", "sd7", "pc1sd3", "pc1sd7")
plot(sdstack, col=viridisc)

#---------------------
  
