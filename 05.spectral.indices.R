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
