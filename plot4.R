# http://stackoverflow.com/questions/5345132/sys-setlocale-request-to-set-locale-cannot-be-honored
Sys.setlocale("LC_TIME", "C")

library(sqldf)
library(tcltk) 
# From stackoverflow.com
# How to read a text file to R selectively?
# http://stackoverflow.com/questions/23577700/how-to-read-a-text-file-to-r-selectively


mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
myFile <- "household_power_consumption.txt"
df <- read.csv.sql(myFile,mySql, header = TRUE,sep = ";")
# Convert date strings to Date classes 
df$Date  <- as.Date(df$Date , "%d/%m/%Y")

# Convert to numeric: for data axises
df$Global_active_power <- as.numeric(df$Global_active_power)
df$Voltage <- as.numeric(df$Voltage)
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)

# Add DateTime column for time axis
df$DateTime <- paste(df$Date, df$Time, sep=" ")

# output to png
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

# First plot
plot(as.POSIXct(df$DateTime), df$Global_active_power, type="l", 
     ylab="Global Active Power", xlab="")

# Second plot
plot(as.POSIXct(df$DateTime), df$Voltage, type="l", 
     ylab="Voltage", xlab="datetime")

# Third plot
plot(as.POSIXct(df$DateTime), df$Sub_metering_1, type="l", 
     xlab="", ylab="Energy sub metering")
lines(as.POSIXct(df$DateTime), df$Sub_metering_2, col="Red")
lines(as.POSIXct(df$DateTime), df$Sub_metering_3, col="Blue") 
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("Black", "Red", "Blue"), lwd=1, bty="n")

# Fourth plot
plot(as.POSIXct(df$DateTime), df$Global_reactive_power, type="l", 
     ylab="Global_reactive_power", xlab="datetime")

dev.off()

