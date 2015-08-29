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

#4. Group by year and Get total emissions
dat  <- group_by(NEI, year) %>%
        summarise(total.Emissions = sum(Emissions))

#5. Plot
#Pick one of the following plots (I prefer #5.1)
##5.1
with(dat, barplot(names.arg = year,height = total.Emissions, 
               ylab="Total Emissions (tons)"))
title(main=expression('PM'[2.5]*' emissions in the United States'))
###5.2
with(dat, plot(year,total.Emissions, ylab="Total Emissions (tons)"))
with(dat, lines(year, total.Emissions ))
title(main=expression('PM'[2.5]*' emissions in the United States'))
abline(lm(dat$total.Emissions ~ dat$year), col=2)

#6.Save the plot to a PNG file
dev.copy(png, file="plot1.png", width = 480, height=480)
dev.off()
