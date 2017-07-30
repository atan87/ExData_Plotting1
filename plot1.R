library(tidyverse)
library(lubridate) #load for date parsing

# read_csv2 to read in ; delimited text file
raw.dat <- read.table("household_power_consumption.txt", na = "?", sep = ";", dec = ".", header = TRUE)

# parse date column
raw.dat$Date <- dmy(raw.dat$Date) 

# parse time
raw.dat$Time <- hms(raw.dat$Time)

# subset only dates 2007-02-01 & 2007-02-02
raw.dat <- subset(raw.dat, Date == "2007-02-01" | Date == "2007-02-02")

#convert numeric columns stored as characters
raw.dat[3:9] <- lapply(raw.dat[3:9], as.numeric)

# set png output file
png("plot1.png", width = 480, height = 480,units = "px")
hist(raw.dat$Global_active_power, 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power" ,
     col = "red",
     xlim = c(0,6),
     ylim = c(0,1200))

#close png connection
dev.off()
