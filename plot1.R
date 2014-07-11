# Exploratory Data Analysis / Project 1 / Plot 1

# download data file
url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (! file.exists("household_power_consumption.zip")) {
    download.file(url, destfile="./household_power_consumption.zip")
}

# uncompress data file
unzip("household_power_consumption.zip")

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
png("plot1.png")

# create requested graph
hist(data$global_active_power, col="red", main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

# close graphics device
dev.off()
