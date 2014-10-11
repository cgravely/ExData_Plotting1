plot1 <- function() {
  # This script reads in the dataset, Electric power consumption, from the UC Irvine Machine Learning Repository.
  
  # Set working directory
  setwd("C:/Coursera/ExploratoryDataAnalysis")
  
  # Read in the applicable portion of the dataset
  library(sqldf)
  temp <- tempfile()
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL,temp)
  con <- unzip(temp, "household_power_consumption.txt")
  dat <- read.csv.sql("household_power_consumption.txt", sql = "SELECT * from file WHERE Date IN ('1/2/2007','2/2/2007') ", sep = ";", header = TRUE)
  unlink(temp)
  
  # Create a new column that combines the date an time
  dat$one <- as.POSIXct(paste(dat$Date, dat$Time), format="%Y-%m-%d %H:%M:%S")
  
  # Create the plot
  library(datasets)
  hist(dat$Global_active_power, main="Global Active Power",  xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
  dev.copy(png, file="plot1.png", height=480, width=480)
  dev.off()
}