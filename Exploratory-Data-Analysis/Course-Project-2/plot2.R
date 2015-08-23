library(dplyr)

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

#4. Group by year, filter by Baltimore fips and Get total emissions 
baltimore  <- group_by(NEI, year) %>%
        filter(fips == "24510") %>%
        summarise(total.Emissions = sum(Emissions))

#5. Plot
with(baltimore, plot(year,total.Emissions, ylab="Total Emissions (tons)"))
title(main="Pm2.5 emissions in Baltimore, MD")
abline(lm(baltimore$total.Emissions ~ baltimore$year), col=2)

#6. Save the plot to a PNG file
dev.copy(png, file="plot2.png", width = 480, height=480)
dev.off()
