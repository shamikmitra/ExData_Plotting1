##      This script is used to create 4 charts of the Global active power, Voltage, Submetering and Global reactive
##      power across the days of 1st and 2nd Feb 2007, and save it in a PNG file
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

## Open a PNG output device, set the paramater for 4 plots, create the plots and close the file
png(filename = "plot4.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
par(mfrow=c(2,2))

## Plot 1 - Global active power over Date
plot (Global_active_power ~ datetime, analysisdata, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## Plot 2 - Voltage over Date
plot (Voltage ~ datetime, analysisdata, type="l", ylab="Voltage")

## Plot 3 - Sub meterings 1, 2, and 3 over Date
plot (Sub_metering_1 ~ datetime, analysisdata, type="n", ylab="Energy sub metering", xlab="")
points(analysisdata$datetime, analysisdata$Sub_metering_1, type="l", col="black")
points(analysisdata$datetime, analysisdata$Sub_metering_2, type="l", col="red")
points(analysisdata$datetime, analysisdata$Sub_metering_3, type="l", col="blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1)

## Plot 4 - Global reactive power over Date
plot (Global_reactive_power ~ datetime, analysisdata, type="l", ylab="Global_reactive_power")

dev.off()

## Clear the table from the memory
rm(analysisdata)