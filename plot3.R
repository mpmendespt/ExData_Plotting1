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

# Convert to numeric: for data axis
df[,"Sub_metering_1"] <- as.numeric(df[,"Sub_metering_1"])
df[,"Sub_metering_2"] <- as.numeric(df[,"Sub_metering_2"])
df[,"Sub_metering_3"] <- as.numeric(df[,"Sub_metering_3"])

# Add DateTime column for time axis
df$DateTime <- paste(df$Date, df$Time, sep=" ")

# output to png
png("plot3.png", width=480, height=480)

plot(as.POSIXct(df$DateTime), df[,"Sub_metering_1"], type="l", 
     xlab="", ylab="Energy sub metering")

# Add the rest of submetering
lines(as.POSIXct(df$DateTime), df[,"Sub_metering_2"], col="Red")
lines(as.POSIXct(df$DateTime), df[,"Sub_metering_3"], col="Blue") 

# Build plot legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("Black", "Red", "Blue"), lwd=1)

dev.off()

