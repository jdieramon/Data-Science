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

#4. Get the raw indices from the SCC file that are coal-based
ind  <- grep("Coal", SCC$EI.Sector)

#5. Get the SCC from those indices
target  <- SCC[ind,1]

#6. Filter by SCC indices, group by year and get total emissions 
coal  <- filter(NEI, SCC %in% target) %>%
        group_by(year) %>%
        summarise(total.Emissions = sum(Emissions))

#7. Plot
with(coal, plot(year,total.Emissions, ylim=c(300000,600000), 
                ylab="Emissions (tons)"))
title(main="Pm2.5 total emissions from coal combustion-related sources")
abline(lm(coal$total.Emissions ~ coal$year), col=2)

#8. Save the plot to a PNG file
dev.copy(png, file="plot4.png", width = 650, height=480)
dev.off() 
