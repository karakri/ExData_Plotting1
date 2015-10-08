#read the first line of the file to use as column names
header = read.table("household_power_consumption.txt", sep=";", nrows=1) 
#read in the lines beginning on 1/2/2007 and ending just before midnight 2/2/2007; assign column names
hpc = read.table("household_power_consumption.txt", sep=";", na.strings = "?", col.names = unlist(header), skip=grep("31/1/2007;23:59:00", readLines("household_power_consumption.txt")), nrows=2880)
#convert Date to a Date-Time class
hpc$Date = strptime(hpc$Date,"%d/%m/%Y")
#convert Time to a Date-Time class 
hpc$Time = strftime(strptime(hpc$Time,"%H:%M:%S"), "%H:%M:%S")
# create a new Date-Time variable with both date and time 
hpc$Datetime = strptime(paste(hpc$Date, hpc$Time), "%Y-%m-%d %H:%M:%S")

#open the graphic device
png(file = "plot2.png")
#plot the graph, clear x-axis numbering
plot(hpc$Datetime,hpc$Global_active_power, type="l", xaxt="n", xlab="", ylab="Global Active Power (kilowatts)")
# plot the x-axis numbering in week days
axis.POSIXct(1, at = seq(as.Date("2007/2/1"), as.Date("2007/2/3"), by = "days"), format = "%a")
#close the graphic device
dev.off() 