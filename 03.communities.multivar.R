##Install vegan package 
install.packages("vegan")
library(vegan)
data(dune)
ord <- decorana(dune)
ord

##Call: decorana(veg = dune)
#Detrended correspondence analysis with 26 segments.
#Rescaling of axes with 4 iterations. 

plot(ord)

head(dune)
ord <- decorana(dune)

ldc1 = 3.7004
ldc2 = 3.1166
ldc3 = 1.30055
ldc4 = 1.47888
total = ldc1 + ldc2 + ldc3 + ldc4

pldc1 = ldc1 * 100 / total
pldc2 = ldc2 * 100 / total
pldc3 = ldc3 * 100 / total
pldc4 = ldc4 * 100 / total
pldc1
pldc2
pldc1 + pldc2
plot(ord)
