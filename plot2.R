setwd("C:/Users/Michael/Desktop")

## read file
df <- read.table("household_power_consumption.txt", sep=";", header=T)

## convert column 1 to Date format
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

## extract data from 2007-02-01 and 2007-02-02
power <- df[df$Date=="2007-02-01"|df$Date=="2007-02-02",]

## convert column 2 to Date-Time format
power$Time <- paste(power$Date, power$Time)
power$Time <- strptime(power$Time, format = "%Y-%m-%d %H:%M:%S")

## convert character to numeric in columns 3 to 9
power[,3:9] <- sapply(power[,3:9], as.numeric)

## draw plot2.png line plot
png("plot2.png")
plot(power$Time, power$Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()