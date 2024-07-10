###THE FIRE OF MONTIFERRU###

# Student: Elsa Maria Frabetti

# The project aims to analyze the environmental conditions seen in three different scenarios 
# Before fire, right after it and two years later
# Period: July 2021 - August 2021 - August 2023

# Importing packages

library(imageRy) # spatial analysis
library(terra) # spatial analysis
library(viridis) # color scales suitable for color blind people
library(ggplot2) # to make graphs
library(patchwork) # to merge graphs 

# Importing images downloaded from Copernicus browser

# We have to identify the workbook from which R will take the images
setwd("C:/Users/Massimiliano/Desktop/Materiale Ecology in R/Duccio's exam")
# Always using "" when we exit from R

# Importing true color images

suppressWarnings({  # using this function to remove warnings
  luglio21 <- rast("pre-incendio tc.jpg")
  agosto21 <- rast("post-incendio tc.jpg") # using rast from terra to import images 
  agosto23 <- rast("agosto 23 tc.jpg") #we'll use it at the end
})
# band 1 = Red
# band 2 = Green
# band 3 = Blue

# Importing false color images

suppressWarnings({
  fcluglio21 <- rast("pre-incendio fc.jpg")
  fcagosto21 <- rast("post-incendio fc.jpg")
  fcagosto23 <- rast("agosto 23 fc.jpg") #we'll use it at the end
})
# band 1 = NIR
# band 2 = Red
# band 3 = Green

# Let's visualize those images together

par(mfrow=c(2,2)) # creating a multiframe 2x2
plot(luglio21) #before fire   # putting images inside the mf
plot(agosto21) #after fire
plot(fcluglio21) #before fire fc
plot(fcagosto21) #after fire fc

dev.off() # removing the previously done multiframe

## Spectral indices

# DVI - Difference Vegetation Index (NIR - RED) 

dviBF = fcluglio21[[1]] - fcluglio21[[2]] # before fire
dviAF = fcagosto21[[1]] - fcagosto21[[2]] # after fire

# Now we use the results to calculate NDVI
# NDVI = DVI / (NIR + RED) 
# This is a normalized index that doesn't depend on the images resolution 
# Values range goes from -1 to 1 

# NDVI - Normalized Difference Vegetation Index 
# We use it because it doesn't depend on the image resolution

ndviBF = dviBF/(fcluglio21[[1]] + fcluglio21[[2]]) # before fire
ndviAF = dviAF/(fcagosto21[[1]] + fcagosto21[[2]]) # after fire

par(mfrow=c(1,2))
plot(ndviBF, col=magma(100), main="before fire")
plot(ndviAF, col=magma(100), main="after fire")

dev.off()


## Classification

# Classifying on NDVI because we want to analyze vegetation
# We have to tell the number of classes 
# The initial sampling is random, so we can see slightly different results if web repeat the process more than once

suppressWarnings({
  lu21c <- im.classify(ndviBF, num_clusters = 2) #classificazione non visionata
  ag21c <- im.classify(ndviAF, num_clusters = 2)
})

# class 1 = vegetation
# class 2 = bare soil

classnames <- c("Vegetation", "Bare soil")
# We put them one over the other and we give them names 
GW <- colorRampPalette(c("forestgreen", "white"))(2) # creating my color scale
par(mfrow=c(2,1)) # 2 raws and 1 column 
plot(lu21c, col=GW, type="classes", levels=classnames, main="before fire")
plot(ag21c, col=GW, type="classes", levels=classnames, main="after fire")
# using type to specify that my data are classes
# using levels to put labels in the legenda
dev.off()

# Now we want to calculate the classes' percentages for a quantitative comparison

# Let's calculate the classes' frequencies
flu21 <- freq(lu21c)
fag21 <- freq(ag21c)

# Let's calculate the percentages
plu21 <- (flu21/ncell(lu21c))*100
pag21 <- (fag21/ncell(ag21c))*100
plu21 # vegetation = 51,1%,  bare soil = 48,9%
pag21 # vegetation = 35,1%, bare soil = 64,9%

# Let's create arrays for the classes' values
ylu21 <- c(51, 49)
yag21 <- c(35, 65)

# Now we create the dataframe
DF <- data.frame(classnames, ylu21, yag21)
DF

# Now we visualize those data graphically

glu21 <- ggplot(DF, aes(x=classnames, y=ylu21, color=classnames)) +
  geom_bar(stat="identity", aes(fill=classnames)) + ylim(c(0,100)) +
  ggtitle("Before fire") + xlab("Classes") + ylab("Percentage")

gag21 <- ggplot(DF, aes(x=classnames, y=yag21, color=classnames)) +
  geom_bar(stat="identity", aes(fill=classnames)) + ylim(c(0,100)) +
  ggtitle("After fire") + xlab("Classes") + ylab("Percentage")

glu21 + gag21 # first we created the two graphs then we merge them 
# aes() allows us to change aesthetic parameters, color= is referred to the edge, fill= to the inside
# geom_bar() is bar charts, "identity" allows to visualize exactly the given value 
# ylim is important to have the same scale in both graphs 


## Let's calculate the spectral variability 
# An higher variability can be associated to an higher habitat heterogeneity 
# We calculate SD with the method of the Moving Window 
# SD is calculated on 1 variable 
# So we analyze the principal components to find PC1
# In this was we can choose the most informative variable
# For pca we choose 3 bands: NIR, R and G  

# July 2021
pairs(fcluglio21) # the correlation between bands is pretty low
pclu21 <- im.pca2(fcluglio21)
# PC1 = 44.2, PC2 = 26.2, PC3 = 4.3

totpcL <- sum(44.222716, 26.204578,  4.305954)
# percentages of variability from principal components
(44.222716/totpcL)*100 # PC1 = 59.2%
(26.204578/totpcL)*100 # PC2 = 35%
(4.305954/totpcL)*100 # PC3 = 5.8%

# August 2021
pairs(fcagosto21)
pcag21 <- im.pca2(fcagosto21)
# PC1 = 54.2, PC2 = 31.6, PC3 = 3.2

totpcA <- sum(54.209964, 31.622260,  3.199238)
(54.209964/totpcA)*100 # PC1 = 60.9%
(31.622260/totpcA)*100 # PC2 = 35.5%
(3.199238/totpcA)*100 # PC3 = 3.6%

# Let's use the method of the moving window on PC1 
# Calculating MW using the function focal()
# We use two MW of different sizes for every PC1

# July 2021
sdL3 <- focal(pclu21$PC1, matrix(1/9, 3, 3), fun=sd) # MW 3x3
sdL9 <- focal(pclu21$PC1, matrix(1/81, 9, 9), fun=sd) # MW 9x9

# August 2021
sdA3 <- focal(pcag21$PC1, matrix(1/9, 3, 3), fun=sd) # MW 3x3
sdA9 <- focal(pcag21$PC1, matrix(1/81, 9, 9), fun=sd) # MW 9x9

# function focal arguments: 
# 1st : PC1
# 2nd: the size of our MW
# 3rd: the function that we calculate with the MW (in this case is sd) 

# Now we plot the 4 images 
stack <- c(sdL3, sdL9, sdA3, sdA9)
plot(stack, col=viridis(100))


## Let's compare 2021 with 2023

par(mfrow=c(1,2)) # compare tc images
plot(luglio21, main="July 2021") 
plot(agosto23, main="August 2023")

# Let's calculate NDVI for august 2023

dvi23 <- fcagosto23[[1]] - fcagosto23[[2]]
ndvi23 <- dvi23/(fcagosto23[[1]] + fcagosto23[[2]])

# Let's calculate the NDVI difference between images 

dif21 = ndviAF - ndviBF # after - before fire 2021
dif23 = ndvi23 - ndviBF # summer 2023 - before fire
coldif <- colorRampPalette(c("blue3", "white", "red2"))(100)
par(mfrow=c(1,2))
plot(dif21, col=coldif, main="Right after the fire")
plot(dif23, col=coldif, main="Two years after the fire")

# We witness a graudal restoration of the area without big peaks 
# Uniform diffusion resulted from secondary succession



