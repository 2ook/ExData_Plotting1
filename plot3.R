#downloading zip file from source into local folder, unzipping and reading into R

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,destfile = "household_power_consumption.zip")
data <- read.table(unz("household_power_consumption.zip", "household_power_consumption.txt"),header=TRUE,sep=";",colClasses=c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'),na.strings='?')

#subsetting data for the 2 desired days and removing the rest of the data set

sub <- subset(data,data$Date=='1/2/2007' | data$Date=='2/2/2007')
rm(data)

#converting 'Date' and 'Time' variables to DateTime

sub$Date2 <- paste(sub$Date, sub$Time)
sub$Date2 <- strptime(sub$Date2,format='%d/%m/%Y %H:%M:%S')

#plot 3

png(file = 'plot3.png')
plot(sub$Date2,sub$Sub_metering_1,type='l',ylab='Energy sub metering',xlab="")
lines(sub$Date2,sub$Sub_metering_2,col='red')
lines(sub$Date2,sub$Sub_metering_3,col='blue')
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c('black','red','blue'),lty=c(1,1))
dev.off()