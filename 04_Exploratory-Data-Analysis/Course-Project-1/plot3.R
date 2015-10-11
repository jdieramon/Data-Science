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

#Merging Date + Time and formating to "POSIXlt" "POSIXt" 
x = paste(subset$Date,subset$Time)
data.time  <- strptime(x, "%d/%m/%Y %H:%M:%S")

##Convert factor to an integer
y1 = as.numeric(as.character(subset$Sub_metering_1))
y2 = as.numeric(as.character(subset$Sub_metering_2))
y3 = as.numeric(as.character(subset$Sub_metering_3))
plot(data.time, y1, xlab="", ylab = "Energy sub metering",
     type="l")
lines(data.time, y2, col="red")
lines(data.time, y3, col="blue")
legend("topright", lwd=2,col = c("black","red","blue"), 
       legend= c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

#Save the plot to a PNG file
dev.copy(png, file="plot3.png", width = 480, height=480, units="px")
dev.off()
