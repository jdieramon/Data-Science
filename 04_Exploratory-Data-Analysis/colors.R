grey() #colors between 0 (white) - 1 (black)
grey(0)
grey(1)
grey(0.5)

## Generalization to create new colors: colorRamp()
pal <- colorRamp(c("red", "blue"))
pal(0)
pal(1)
pal(0.5)

## Similar, but it returns output slightly different : colorRampPalette()
pal <-  colorRampPalette(c("red", "blue"))
pal(2) #returns 2 colors
pal(10) #returns 10 colors

## RColorBrewer pckg.
#It provides color palettes for sequenctial, categorical and diverging data
library(RColorBrewer)
cols <- brewer.pal(3, "BuGn") #number of colors for your palette, name of the palette ("Blues", "Oranges", are also cool)
pal = colorRampPalette(cols)
image(volcano, col=pal(20))

## Scatterplot huge number of points
x <- rnorm(1000)
y <- rnorm(1000)
plot(x,y)
smoothScatter(x,y)

## Scatterplot with transparency
plot(x,y, pch=19)
plot(x,y,col=rgb(0,0,0,0.2), pch=19)
