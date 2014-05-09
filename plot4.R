setwd("C:/Users/Michael/Desktop")

## read file
df <- read.table("household_power_consumption.txt", sep=";", header=T,
                 colClasses = "character")

## convert column 1 to Date format
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

## extract data from 2007-02-01 and 2007-02-02
power <- df[df$Date=="2007-02-01"|df$Date=="2007-02-02",]

## convert column 2 to Date-Time format
power$Time <- paste(power$Date, power$Time)
power$Time <- strptime(power$Time, format = "%Y-%m-%d %H:%M:%S")

## convert character to numeric in columns 3 to 9
power[,3:9] <- sapply(power[,3:9], as.numeric)

## draw plot4.png
png("plot4.png")
par(mfrow = c(2,2))
with(power, plot(Time, Global_active_power, type = "l", xlab = "",
                 ylab = "Global Active Power"))
with(power, plot(Time, Voltage, type = "l", xlab = "datetime"))
with(power, plot(Time, Sub_metering_1, type = "l", xlab = "", 
     ylab = "Energy sub metering", ylim = c(0,38)))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = c(1,1,1), lwd = c(1,1,1), col = c(1,2,4), bty = "n") ##Add legend to plot
with(power, lines(Time, Sub_metering_2, col = 2))
with(power, lines(Time, Sub_metering_3, col = 4))
with(power, plot(Time, Global_reactive_power, type = "l", xlab = "datetime"))
dev.off()