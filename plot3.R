if(!file.exists("./target.csv")){
  file <- "./household_power_consumption.txt"
  data <- read.table(file, sep = ";", header = TRUE, na.strings = "?")
  
  ## subset the dates wanted
  tdata <- subset(data, Date %in% c("1/2/2007", "2/2/2007"))
  
  ## change Date & Time into DateTime
  tdata$DateTime <- paste(tdata$Date, tdata$Time)
  tdata <- subset(tdata, select = -c(Date,Time) )
  preferred_order = c(8,1:7)
  tdata <- tdata[ ,names(tdata)[c(preferred_order)]]
  
  ## convert to Date/Time classes
  tdata$DateTime <- strptime(tdata$DateTime, format="%e/%m/%Y %H:%M:%S")
  
  ## write to target.rdata
  write.table(tdata, file = "target.csv", sep = ";")
  
} else {
  file <- "./target.csv"
  tdata <- read.table(file, sep = ";", header = TRUE, na.strings = "?")
}

##########################################################################
## Plot 3
##########################################################################


png("plot3.png", width = 480, height = 480)
with(tdata, plot(as.POSIXct(DateTime), Sub_metering_1, type = "l", 
                 xlab = "", ylab = "Energy sub metering"))
with(tdata, lines(as.POSIXct(DateTime), Sub_metering_2, type = "l", col = "red"))
with(tdata, lines(as.POSIXct(DateTime), Sub_metering_3, type = "l", col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty=1)
dev.off()