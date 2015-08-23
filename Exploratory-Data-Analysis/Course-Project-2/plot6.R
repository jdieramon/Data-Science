ibrary(dplyr)
library(ggplot2)

#1. Set the working directory
if(!file.exists("./data")){dir.create("./data")}
setwd("./data")

#2. Download zip file
fileUrl  <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl,destfile="./pm25.zip", method="curl")

#3. Unzip and Read Data
files  <- unzip("pm25.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#4. Get the raw indices from the SCC file that are Vehicles-based (same criteria as explained in plot5.R)
ind  <- grep("Vehicle", SCC$EI.Sector)

#5. Get the SCC from those indices
target  <- SCC[ind,1]

#6. Filter by SCC indices and Baltimore/Los Angeles cities, group by year/fips, and get total emissions 
vehicles <- filter(NEI, SCC %in% target,fips == "24510"|fips == "06037") %>%
        group_by(year, fips) %>%
        summarise(total.Emissions = sum(Emissions))

#7. Some tidy data to get a clearer plot: change the fips codes by city name
los.angeles.ind  <- which(vehicles$fips=="06037")
baltimore.ind  <- which(vehicles$fips=="24510")
vehicles$fips[los.angeles.ind] = "Los Angeles"
vehicles$fips[baltimore.ind] = "Baltimore"

#8. Plot
qplot(year, total.Emissions, data=vehicles, facets=. ~ fips, 
      geom = c("point","smooth"), method = "lm",        
      color=fips, ylab="Emissions (tons)", main="Baltimore vs Los Angeles")

#9. Save the plot to a PNG file
dev.copy(png, file="plot6.png", width = 650, height=480)
dev.off()
