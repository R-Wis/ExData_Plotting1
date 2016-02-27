## Preprocessing ---------------------------------------------------------------
# Assuming file exist in working directory

dataset <- read.table(paste0(getwd(),"/","household_power_consumption.txt"),
                      header=TRUE,
                      na.strings = "?",
                      sep = ";",
                      dec = ".",
                      stringsAsFactors = FALSE,
                      strip.white = TRUE,
                      comment.char=""
                      )
#str(dataset)

# Converting Date from char to POSIXlt-----------------------------------------#
dataset$Date <- strptime(dataset$Date, format="%d/%m/%Y")
#str(dataset)
# Subsetting date range
dataset <- dataset[dataset$Date>= strptime("2007-02-01",format="%F") 
                   & dataset$Date<= strptime("2007-02-02",format="%F") 
                   ,]
# Concatenating Date & Time to POSIXct-----------------------------------------#
dataset$datetime <- as.POSIXct(paste(dataset$Date,dataset$Time),
                               format="%F %H:%M:%S")
#str(dataset)

## plot4 -----------------------------------------------------------------------
png(filename = "plot4.png")
par(mfrow=c(2,2))
# 1----------------------------------------------------------------------------#
plot(dataset$datetime, dataset$Global_active_power, 
     type="l",
     xlab="",
     ylab="Global Active Power"
     )

# 2----------------------------------------------------------------------------#
plot(dataset$datetime, dataset$Voltage,
     type="l",
     xlab="datetime",
     ylab="Voltage"
     )

# 3 ---------------------------------------------------------------------------#
plot(dataset$datetime,dataset[,7],
     type="l",
     col="black",
     xlab="",
     ylab="Energy sub metering"
     )
lines(dataset$datetime,dataset[,8],
      col="red"
      )
lines(dataset$datetime,dataset[,9],
      col="blue"
      )
legend("topright",col=c("black","red","blue"),lwd=1,bty="n",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       )

# 4----------------------------------------------------------------------------#
plot(dataset$datetime, dataset$Global_reactive_power,
     type="l",
     xlab="datetime",
     ylab="Global_reactive_power"
     )
dev.off()