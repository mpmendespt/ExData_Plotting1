# http://stackoverflow.com/questions/5345132/sys-setlocale-request-to-set-locale-cannot-be-honored
Sys.setlocale("LC_TIME", "C")

#install.packages("sqldf", dependencies=TRUE)
#
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
df[,"Global_active_power"] <- as.numeric(df[,"Global_active_power"])
# Add DateTime column for time axis
df$DateTime <- paste(df$Date, df$Time, sep=" ")

# output to png
png("plot2.png", width=480, height=480)
plot(as.POSIXct(df$DateTime), df[,"Global_active_power"], type="l", 
     xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

