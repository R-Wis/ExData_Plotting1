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

## plot2 ----
png(filename = "plot2.png")
plot(dataset$datetime, dataset$Global_active_power, 
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)",
     main="")
dev.off()
