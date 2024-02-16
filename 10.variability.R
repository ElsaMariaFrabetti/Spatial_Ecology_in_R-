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
