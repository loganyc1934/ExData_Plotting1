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
## Plot 1
##########################################################################
png("plot1.png", width = 480, height = 480)
hist(tdata$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")
dev.off()


