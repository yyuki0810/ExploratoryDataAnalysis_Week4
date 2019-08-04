library(dplyr)
library(tidyverse)

#donwload,and unzip the file.
#download.file(myURL,destfile = "./data/Week4Assignment.zip",method="curl")
unzip("./data/exdata-data-household_power_consumption.zip",exdir = "./data/Week4-1Assignment")
list.files("./data/Week4-1Assignment",recursive = T,full.names = T)->ls


#read the data frame and name it.(Step 0)

df1<-read.table(ls[1],skip = 1,sep = ";", na.strings = "?",colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
colnames(df1)<-c("Day","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

df1<-mutate(df1,Date=paste(Day,Time))

df1$Day<-as.POSIXct(strptime(df1$Day,"%d/%m/%Y"))
df1$Time<-as.POSIXct(strptime(df1$Time,"%H:%M:%S"))
df1$Date<-as.POSIXct(df1$Date,format="%d/%m/%Y %H:%M:%S")

df2<-filter(df1,"2007-2-1"<=Day&Day<="2007-2-2")

#Plot1
hist(df2$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()
