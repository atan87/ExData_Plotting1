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

# set png output file
png("plot2.png", width = 480, height = 480,units = "px")


plot(x = raw.dat$date_time,
     y = raw.dat$Global_active_power,
     type = "lines",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

dev.off()
