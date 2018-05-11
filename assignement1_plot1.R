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

#Create graph1 
plot1 <- hist(data$Global_active_power, main = "Global Active Power",
col="red", xlab= "Global Active Power (kilowatts)", ) 
dev.copy(png,'plot1.png')
dev.off()
