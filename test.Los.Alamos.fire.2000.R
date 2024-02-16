###TEST WITH EXTERNAL DATA
##LOS ALAMOS FIRE 2000 
library(terra)
setwd("C:/Users/Massimiliano/Downloads")
losalamosPRE <- rast("los_alamos_l7_apr_14_2000.jpg")
plotRGB(losalamosPRE, r=1, g=2, b=3)
losalamosPOST <- rast("los_alamos_l7_jun_17_2000.jpg")
plotRGB(losalamosPOST, r=1, g=2, b=3)
par(mfrow=c(1,2))
dev.off()
plotRGB(losalamosPRE, r=2, g=3, b=1)
plotRGB(losalamosPOST, r=2, g=3, b=1)
