###TIME SERIES###
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
