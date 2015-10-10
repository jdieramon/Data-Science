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

#4. Get the raw indices from the SCC file that are Vehicles-based
ind  <- grep("Coal", SCC$EI.Sector, ignore.case = TRUE)

#5. Get the SCC from those indices
target  <- SCC[ind,1]

#6. Filter by SCC indices and Baltimore city, group by year, and get total emissions 
vehicles.baltimore  <- filter(NEI, SCC %in% target,fips == "24510") %>%
        group_by(year) %>%
        summarise(total.Emissions = sum(Emissions))

#7. Plot
#Pick one of the following plots:
#7.1
with(vehicles.baltimore, barplot(names.arg = year,height = total.Emissions, 
                              ylab="Emissions (tons)", ylim=c(0,400)))
title(main="Pm2.5 emissions from motor vehicle sources in Baltimore")

#7.2
with(vehicles.baltimore, plot(year,total.Emissions, 
                ylab="Emissions (tons)", ylim=c(50,350 )))
with(vehicles.baltimore, lines(year,total.Emissions)
title(main="Pm2.5 emissions from motor vehicle sources in Baltimore")
abline(lm(vehicles.baltimore$total.Emissions ~ vehicles.baltimore$year), col=2)

#8. Save the plot to a PNG file
dev.copy(png, file="plot5.png", width = 600, height=480)
dev.off() 
