# read the data, assumes the file is located in a folder called data within the working directory
all_data <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)

library(dplyr)

# add a 10th column called Date_Time that is a combination of the Date and Time columns
all_data <- mutate(all_data, Date_Time = paste(Date, Time))

# convert the Date_Time column to POSIXct so that it can be used for date comparison
all_data [,10] <- as.POSIXct(all_data[,10], format = "%d/%m/%Y %H:%M:%S", tz = Sys.timezone())

# filter the data to select only data for the dates 1st Feb 2007 and 2nd Feb 2007 
filtered_data <- all_data %>% filter(Date_Time >= as.POSIXct("01/02/2007 00:00:00", format = "%d/%m/%Y %H:%M:%S", tz=Sys.timezone()) 
                                     & Date_Time < as.POSIXct("03/02/2007 00:00:00", format = "%d/%m/%Y %H:%M:%S", tz=Sys.timezone()) )

# make the plot in a png file
png(file = "plot3.png")

with(filtered_data, plot(Date_Time, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))

with(filtered_data, lines(Date_Time, Sub_metering_1, type = "l"))

with(filtered_data, lines(Date_Time, Sub_metering_2, type = "l", col = "red"))

with(filtered_data, lines(Date_Time, Sub_metering_3, type = "l", col = "blue"))

legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()