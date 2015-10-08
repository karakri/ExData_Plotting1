#read the first line of the file to use as column names
header = read.table("household_power_consumption.txt", sep=";", nrows=1) 
#read in the lines beginning on 1/2/2007 and ending just before midnight 2/2/2007; assign column names
hpc = read.table("household_power_consumption.txt", sep=";", na.strings = "?", col.names = unlist(header), skip=grep("31/1/2007;23:59:00", readLines("household_power_consumption.txt")), nrows=2880)


#open the graphic device
png(file = "plot1.png")
#plot the histogram, set axis labels and color
hist(hpc$Global_active_power, main="Global active power", xlab="Global active power (kilowatts)", col="red")
#close the graphic device
dev.off() 