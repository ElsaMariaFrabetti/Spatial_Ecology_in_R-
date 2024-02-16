###Classifying satellite images### 

#Estimating the amount of change 
library(terra)
library(imageRy)
install.packages("patchwork")
library(patchwork)
im.list()

sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
#From the plot you can see that there are three levels of intensity 
sunc <- im.classify(sun, num_clusters = 3) 
plot(sunc)
par(mfrow=c(1,2))
dev.off()
plotRGB(sun, 1, 2, 3)

##Classify satellite data
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")                    
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")    
#in this combination water should be black but there are several deposits inside so its white
#We'll use 2 clusters
m1992c <- im.classify(m1992, num_clusters = 2)
plot(m1992c[[1]])
#Classes: forest=1; human=2
m2006c <- im.classify(m2006, num_clusters = 2)
plot(m2006c[[1]])
#Classes: forest=2; human=1
par(mfrow=c(1,2))

##Let's calculate what is the proportion of each class
f1992 <- freq(m1992c[[1]])
f1992 #it tell me the frequency 
tot1992 <- ncell(m1992c[[1]]) #it tells me the total number of pixels
tot1992
p1992 <- f1992 * 100 / tot1992 #it gives me the percentage 
p1992 #the values we're interested in are the counts
#Forest: 83%; Humans: 17%

#Percentage of 2006
f2006 <- freq(m2006c[[1]])
f2006
tot2006 <- ncell(m2006c[[1]])
tot2006
p2006 <- f2006 * 100 / tot2006
p2006
#Forest: 45%; Humans: 55%

##Building the final table 
class <- c("forest", "human")
y1992 <- c(83, 17)
y2006 <- c(45, 55)
tab <- data.frame(class, y1992, y2006)
tab

##Creating the final plot
library(ggplot2)
p1 <- ggplot(tab, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
#With aes(aesthetic)  and with geom_bar you choose an istogram 
p2 <- ggplot(tab, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")  
p1 + p2 #this way we can see the 2 istograms next to each other

##Final plot rescaled
p1 <- ggplot(tab, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tab, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2 #the scale it's clearer because we add the 0-100 tab behind the graphs
  
