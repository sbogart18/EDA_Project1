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

#Create Plot2 in a png file
png("plot2.png", width = 480, height = 480)
with(data, plot(DateTime, Global_active_power, type = "l",
                xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()
