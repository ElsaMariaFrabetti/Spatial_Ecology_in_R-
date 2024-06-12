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
plot(ndviBF, col=viridis(100), main="before fire")
plot(ndviAF, col=viridis(100), main="after fire")
