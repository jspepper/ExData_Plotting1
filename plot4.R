
# read in just the rows we need
data <- read.table(file="household_power_consumption.txt",
    sep=";", skip=66637, nrow=2880)

# add names to the columns
names(data) <- c("date", "time", "global_active_power",
    "global_reactive_power", "voltage", "global_intensity",
    "sub_metering_1", "sub_metering_2", "sub_metering_3")

# combine the date and time
data <- cbind(data, paste(data$date, data$time))
names(data)[10] <- c("datetime")

# convert the new column to a date/time
data$datetime <- strptime(data$datetime, "%d/%m/%Y %H:%M:%S")

# open png graphics device
png("plot4.png")

# partition into 4 graphs
par(mfrow=c(2,2))

# create graph 1
plot(data$datetime, data$global_active_power, type="l",
    ylab="Global Active Power", xlab="")

# create graph 2
plot(data$datetime, data$voltage, type="l",
    ylab="Voltage", xlab="datetime")

# create graph 3
plot(data$datetime, data$sub_metering_1, type="l",
     ylab="Energy sub metering", xlab="")
lines(data$datetime, data$sub_metering_2, col="red")
lines(data$datetime, data$sub_metering_3, col="blue")
legend("topright", bty="n", lty=1, col=c("black", "red", "blue"),
    legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# create graph 4
plot(data$datetime, data$global_reactive_power, type="l",
    ylab="Global_reactive_power", xlab="datetime")

# close graphics device
dev.off()

