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
png(file = "plot4.png")
par(mfrow=c(2,2)) #prepare canvas for 4 graphs

#plot the first graph (same as plot2.R)
plot(hpc$Datetime,hpc$Global_active_power, type="l", xaxt="n", xlab="", ylab="Global Active Power") 
# plot the x-axis numbering in week days
axis.POSIXct(1, at = seq(as.Date("2007/2/1"), as.Date("2007/2/3"), by = "days"), format = "%a")

#plot the second graph, clear x-axis numbering, set axis lables
plot(hpc$Datetime,hpc$Voltage, type="l", xaxt="n", xlab="datetime", ylab="Voltage")
# plot the x-axis numbering in week days
axis.POSIXct(1, at = seq(as.Date("2007/2/1"), as.Date("2007/2/3"), by = "days"), format = "%a")

#plot the third graph (same as plot3.R)
plot(hpc$Datetime,hpc$Sub_metering_1, type="l", xaxt="n", xlab="", ylab="Energy sub metering")
points(hpc$Datetime,hpc$Sub_metering_2, type ="l", col="red")
points(hpc$Datetime,hpc$Sub_metering_3, type ="l", col="blue")
axis.POSIXct(1, at = seq(as.Date("2007/2/1"), as.Date("2007/2/3"), by = "days"), format = "%a")
#add legend, slightly smaller, without the border
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black","red","blue"), bty = "n", cex=0.9)

#plot the fourth graph, clear x-axis numbering, set axis lables
plot(hpc$Datetime,hpc$Global_reactive_power, type="l", xaxt="n",xlab="datetime", ylab="Global_reactive_power")
# plot the x-axis numbering in week days
axis.POSIXct(1, at = seq(as.Date("2007/2/1"), as.Date("2007/2/3"), by = "days"), format = "%a")
#close the graphic device
dev.off() 