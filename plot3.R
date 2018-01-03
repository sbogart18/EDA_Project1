#Download zip file with data if necessary

if (!file.exists("household_power_consumption.txt")){
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dest="dataset.zip", mode="wb") 
    unzip ("dataset.zip", exdir = getwd())
}

#Read only data from Feb 1-2, 2007

data <- read.table("household_power_consumption.txt", header= T, na.strings = "?", sep = ";", 
                   skip = 66636, nrow = 2880)

#Note: dates are read in with dd/mm/YYYY format

names(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity",
                 "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

#Merge Date and Time into DateTime, which has class POSIXlt

data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- strptime(data$DateTime, "%Y-%m-%d %H:%M:%S")

#Create Plot3 in a png file
png("plot3.png", width = 480, height = 480)
with(data, plot(DateTime, Sub_metering_1, type = "l",
                xlab = "", ylab = "Energy sub metering"))
with(data, lines(DateTime, Sub_metering_2, col = "red", type = "l"))
with(data, lines(DateTime, Sub_metering_3, col = "blue", type = "l"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = names(data)[7:9])
dev.off()