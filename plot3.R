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

## create plot in a png file
png(file = "plot3.png", width = 480, height = 480)
with(hpc, plot(Sub_metering_1 ~ Date_time, type = "l", xlab = "",
               ylab = "Energy sub metering"))
lines(x = hpc$Date_time, y = hpc$Sub_metering_2, col = "red")
lines(x = hpc$Date_time, y = hpc$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()