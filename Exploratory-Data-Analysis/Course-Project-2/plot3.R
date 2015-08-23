library(dplyr)
library(ggplot2)

#Set the working directory
if(!file.exists("./data")){dir.create("./data")}
setwd("./data")

#Download zip file
fileUrl  <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl,destfile="./pm25.zip", method="curl")

#Unzip and Read Data
files  <- unzip("pm25.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Filter by Baltimore fips, Group by year and type, and Get total emissions 
baltimore  <- filter(NEI, fips == "24510") %>%
        group_by(year, type) %>%
        summarise(total.Emissions = sum(Emissions)) 

#Plot
qplot(year, total.Emissions, data=baltimore,facets=. ~ type, 
      geom = c("point","smooth"), method = "lm",        
      ylab="Total Emissions (tons)", main="Emissions for Baltimore (MD)")

#Save the plot to a PNG file
dev.copy(png, file="plot3.png", width = 650, height=480)
dev.off()
