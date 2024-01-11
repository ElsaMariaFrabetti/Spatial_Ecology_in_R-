##SIMULATION OF COLORBLIND VISION##

library(devtools)
devtools::install_github("clauswilke/colorblindr")
library(colorblindr)
library(ggplot2)

iris
head(iris)
fig <- ggplot(iris, aes(Sepal.Length, fill = Species)) + geom_density(alpha = 0.7)
fig
cvd_grid(fig) #cvd means color vision deficiency

fig <- ggplot(iris, aes(Sepal.Width, fill = Species)) + geom_density(alpha = 0.7)
fig
cvd_grid(fig)
