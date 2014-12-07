require("dplyr")

## read the data file up to line 70,000 (the data we need ends before this point) 
furl <- "household_power_consumption.txt"
house <- read.csv(furl, sep = ";", nrows = 70000, header = TRUE, na.strings = "?",
              colClasses = c("character",
                             "character",
                             "numeric",
                             "numeric",
                             "numeric",
                             "numeric",
                             "numeric",
                             "numeric",
                             "numeric")
              )
## select data for the 2 specified dates
house <- filter(house, Date == "1/2/2007" | Date == "2/2/2007")
## paste date+time together and create a new Date_time column of class posixct
x <- strptime(paste(house$Date, house$Time), format="%d/%m/%Y %H:%M:%S")
hpc <- mutate(house, Date_time = as.POSIXct(x))

## create histogram in a png file
png(file = "plot1.png", width = 480, height = 480)
with(hpc, hist(Global_active_power, col = "red", main = "Global Active Power",
               xlab = "Global Active Power (kilowatts)"))
dev.off()