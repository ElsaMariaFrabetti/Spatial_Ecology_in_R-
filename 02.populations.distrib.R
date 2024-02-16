#First installing some packages
install.packages("sdm")
install.packages("rgdal")

#Checking if they work
library(sdm)
library(terra)
library(rgdal)

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
