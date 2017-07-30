library(tidyverse)
library(lubridate) #load for date parsing

# read_csv2 to read in ; delimited text file
raw.dat <- read.table("household_power_consumption.txt", na = "?", sep = ";", dec = ".", header = TRUE)

# subset only dates 2007-02-01 & 2007-02-02
raw.dat <- raw.dat %>% filter(Date == "1/2/2007" | Date == "2/2/2007")

#concatane date and time column
raw.dat <- raw.dat %>% mutate(date_time = paste(Date,Time,sep = " "))

#convert date_time combined column
raw.dat$date_time <- dmy_hms(raw.dat$date_time)

#convert numeric columns stored as characters
raw.dat[3:9] <- lapply(raw.dat[3:9], as.numeric)

png("plot4.png", width = 480, height = 480, units = "px")

#set 4x4 grid for graphs
par(mfrow = c(2,2))

#plot 1
plot(x = raw.dat$date_time,
     y = raw.dat$Global_active_power,
     type = "lines",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

#plot 2
plot(x = raw.dat$date_time,
     y = raw.dat$Voltage,
     type = "lines",
     xlab = "datetime",
     ylab = "Voltage")

#plot 3
#first line
plot(x = raw.dat$date_time,
     y = raw.dat$Sub_metering_1,
     type = "lines",
     xlab = "",
     ylab = "Energy sub metering"
)
#second line
lines(raw.dat$date_time,
      raw.dat$Sub_metering_2,
      col = "red")

#third line
lines(x = raw.dat$date_time,
      y = raw.dat$Sub_metering_3,
      col = "blue")

#add legend
legend(x = "topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1,
       col = c("black", "red", "blue")
)

#plot 4
plot(x = raw.dat$date_time,
     y = raw.dat$Global_reactive_power,
     type = "lines",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()

