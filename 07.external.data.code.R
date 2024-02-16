###EXTERNAL DATA###

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
