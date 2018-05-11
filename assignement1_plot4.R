library(dplyr)
library(lubridate)


#zip file link
Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
File <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"

#read data into r
unzip(File)
read.table("household_power_consumption.txt",sep = ";",header=TRUE) -> data

data<- data.frame(lapply(data, as.character), stringsAsFactors=FALSE)

#extract data from dates of interest
dates <- c("1/2/2007","2/2/2007") 
data <- data[data[[1]] %in% dates,]

#Create useable time and date column 
paste(data$Date, data$Time) -> data$Date_Time
dmy_hms(data$Date_Time,tz=Sys.timezone()) -> data$Date_Time

#change variable of interest to numeric 
as.numeric(data$Global_active_power) -> data$Global_active_power

#plot all 4 graphs together
par(mfrow=c(2,2))
#Graph1
plot(type="l", x=data$Date_Time, y=data$Global_active_power,  
ylab= "Global Active Power" ,xlab= "")
#Graph2
plot(type="l", x=data$Date_Time, y=data$Voltage,  
ylab= "Voltage",xlab= "datetime")
#Graph3
plot(type="l", x=data$Date_Time, y=data$Sub_metering_1,  
ylab= "Energy sub metering",xlab= "")
lines(y=data$Sub_metering_2, x=data$Date_Time,type="l", col="red")
lines(y=data$Sub_metering_3, x=data$Date_Time,type="l", col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
lty=c(1,1,1), lwd=c(2,2,2),col=c("black","red","blue")) 
#Graph4
plot(type="l", x=data$Date_Time, y=data$Global_reactive_power,  
ylab= "Global_reactive_power",xlab= "datetime")
dev.copy(png,'plot4.png')
dev.off()