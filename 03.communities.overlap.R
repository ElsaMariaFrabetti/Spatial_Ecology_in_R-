###CAMERA TRAPS DATA###

#Data from Kerinchi-Seblat National Park in Sumatra, Indonesia (Ridout and Linkie, 2009)
#Ridout and Linkie estimated overlap of daily activity patterns from camera trap data
#Journal of Agricultural, Biological and Environmental Statistics, 14(3), 322-337


##Relation among species in time
install.packages("overlap")
library(overlap)

data(kerinci) #data
summary(kerinci)
head(kerinci)

#The unit of time is the day, so values range from 0 to 1
#The package works entirely in radians: fitting density curves uses trigonometric functions (sin, cos, tan)

kerinci$timeRad <- kerinci$Time * 2 * pi #this speeds up simulations, the conversion is straightforward with the operation

#I want only the data on tiger individuals 
tiger <- kerinci[kerinci$Sps=="tiger", ] #selecting the species
timetig <- tiger$timeRad #selecting time for the tiger
densityPlot(timetig, rug=TRUE)

#Exercise 1: select only the data on macaque individuals
macaque <- kerinci[kerinci$Sps=="macaque", ]
head(macaque)
timemac <- macaque$timeRad
densityPlot(timemac, rug=TRUE)

overlapPlot(timetig, timemac) #overlap the two graphs
legend("topright", c("Tigers", "Macaques"), lty=c(1,2), col=c("black", "blue"), bty="n")

#Species
kerinci$Sps
summary(kerinci$Sps)

#Tapir
tap <- kerinci[kerinci$Sps == 'tapir', ]
timetap <- tap$timeRad
densityPlot(timetap, rug=TRUE)

overlapPlot(timemac, timetap)
