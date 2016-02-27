## Preprocessing ----
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

# Converting Date to from char to POSIXlt
dataset$Date <- strptime(dataset$Date, format="%d/%m/%Y")
#str(dataset)
# Subsetting desired date range
dataset <- dataset[dataset$Date>= strptime("2007-02-01",format="%F") 
                   & dataset$Date<= strptime("2007-02-02",format="%F") 
                   ,]
# Concatenating Date & Time to POSIXct
dataset$datetime <- as.POSIXct(paste(dataset$Date,dataset$Time),
                               format="%F %H:%M:%S")
#str(dataset)

## plot3 -----
png(filename = "plot3.png")
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
legend("topright",col=c("black","red","blue"),lwd=1,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       )
dev.off()