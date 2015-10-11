
library(dplyr)
library(lubridate)
#Set the working directory creating a 'Data' folder
if(!file.exists(".data")){dir.create("./data")}
setwd("./data")

#Download zip file
fileUrl  <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./power.zip", method="curl")

#Reading data
dat  <- read.table("household_power_consumption.txt", sep=";",
                   header=TRUE)

#For this project, we will only be using data from the dates 2007-02-01 and 2007-02-02.
subset <- filter(dat,Date=="1/2/2007"| Date=="2/2/2007")

#Convert factor to an integer
y = as.numeric(as.character(subset$Global_active_power))
hist(y, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")

#Save the plot to a PNG file
dev.copy(png, file="plot1.png", width = 480, height=480, units="px")
dev.off()
