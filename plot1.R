##      This script is used to create a histogram of the Global active power across the days of 1st and 2nd
##      Feb 2007, and save it in a PNG file
##      
##      Date            Developer           Comments
##      2015 Nov 07     Shamik Mitra        Initial Version

## Read the data into a temporary table, subset it for the 2 days and then remove the temporary table from memory
library(data.table)
readdata <- fread(input="data/household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
analysisdata <- subset(readdata, Date == "1/2/2007" | Date == "2/2/2007")
rm(readdata)

## Open a PNG output device, create the histogram and close the file
png(filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
hist(analysisdata$Global_active_power, col="red", breaks=12, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off()

## Clear the table from the memory
rm(analysisdata)