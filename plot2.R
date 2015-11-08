##      This script is used to create a line chart of the Global active power across the days of 1st and 2nd
##      Feb 2007, and save it in a PNG file
##      
##      Date            Developer           Comments
##      2015 Nov 07     Shamik Mitra        Initial Version

## Read the data into a temporary table, subset it for the 2 days and then remove the temporary table from memory
library(data.table)
readdata <- fread(input="data/household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
analysisdata <- subset(readdata, Date == "1/2/2007" | Date == "2/2/2007", na.rm=TRUE)
rm(readdata)

## Create a new date time column
analysisdata$datetime <- as.POSIXct(strptime(paste(analysisdata$Date, analysisdata$Time), format="%d/%m/%Y %H:%M:%S"))

## Open a PNG output device, create the plot and close the file
png(filename = "plot2.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
plot (Global_active_power ~ datetime, analysisdata, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()

## Clear the table from the memory
rm(analysisdata)