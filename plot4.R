plot4 <- function() {
  # This script reads in the dataset, Electric power consumption, from the UC Irvine Machine Learning Repository.
  
  # Set working directory
  setwd("C:/Coursera/ExploratoryDataAnalysis")
  
  # Read in the applicable portion of the dataset
  library(sqldf)
  temp <- tempfile()
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL,temp)
  con <- unzip(temp, "household_power_consumption.txt")
  dat <- read.csv.sql("household_power_consumption.txt", sql = "SELECT * from file WHERE Date IN ('1/2/2007','2/2/2007') ", sep = ";", header = TRUE, colClasses=c("character", "character", NA, NA, NA, NA, NA, NA, NA))
  unlink(temp)
  
  # Create a new column that combines the date an time
  dat$one <- as.POSIXct(paste(dat$Date, dat$Time), format="%d/%m/%Y %H:%M:%S")
  
  # Create the plots
  library(datasets)
  png("C:/Coursera/ExploratoryDataAnalysis/plot4.png")
  par(mfrow = c(2,2))
  with(dat, {
    plot(one, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
    plot(one, Voltage, type="l", xlab="datetime", ylab="Voltage")
    plot(one, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
    with(dat, points(one, Sub_metering_2, type="l", col="Red"))
    with(dat, points(one, Sub_metering_3, type="l", col="Blue"))
    legend("topright", lty = 1,bty="n",col = c("black","blue","red"), legend = c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"))
    plot(one, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  })
  dev.off()
}