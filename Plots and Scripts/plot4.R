library(data.table)
#Downloading file and unzipping
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "./household Power consumption.zip")
unzip('./household Power consumption.zip')

#Inspecting file
list.files()
file.size(list.files()[3])

#Reading file
pc<-read.table(list.files()[3],header=TRUE,sep=";",na.strings = "?")

#Inspecting object 
dim(pc)
names(pc)
head(pc)

#Converting Date.Time to a "date" variable
pc$Date.Time<-paste(pc$Date,pc$Time)
pc$Date.Time<-strptime(pc$Date.Time, "%d/%m/%Y %H:%M:%S")
pc2<-subset(pc,pc$Date.Time %between% c(strptime("2007-02-01","%Y-%m-%d"),strptime("2007-02-02 23:59:00","%Y-%m-%d %H:%M:%S")))


#Creating plot
par(mfcol=c(2,2))
with(pc2,plot(Date.Time,Global_active_power,type='l',ylab="Global Active Power", xlab=""))

with(pc2,plot(Date.Time,Sub_metering_1,type='l', xlab="",ylab ="Energy sub metering"))
with(pc2,lines(Date.Time,Sub_metering_2,type='l', col='red'))
with(pc2,lines(Date.Time, Sub_metering_3,type='l', col="blue"))
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"))

with(pc2,plot(Date.Time,Voltage,type='l',ylab="Voltage",xlab="datetime" ))

with(pc2,plot(Date.Time,Global_reactive_power,type='l',ylab="Global_reactive_power",xlab="datetime" ))

#Copying into a .png file
dev.copy(png,"plot4.png",width=480,height=480)
dev.off()
