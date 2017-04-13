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
png(file = "plot1.png")

# plot the histogram
hist(filtered_data$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")

dev.off()