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

