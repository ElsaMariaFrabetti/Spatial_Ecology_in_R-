###COPERNICUS###
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
