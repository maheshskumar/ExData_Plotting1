#Ingest Data
powerConsumpData <- read.table(file="household_power_consumption.txt", sep=";", header = TRUE, na.strings = "?")
powerConsumpSubset <- subset(powerConsumpData, powerConsumpData$Date=="1/2/2007" | powerConsumpData$Date =="2/2/2007" )
head(powerConsumpSubset)
rm(powerConsumpData)
#Manipulate Data
powerConsumpSubset$Date <- as.Date(powerConsumpSubset$Date, format="%d/%m/%Y")
powerConsumpSubset$Time <- strptime(powerConsumpSubset$Time, format="%H:%M:%S")
powerConsumpSubset[1:1440,"Time"] <- format(powerConsumpSubset[1:1440,"Time"],"2007-02-01 %H:%M:%S")
powerConsumpSubset[1441:2880,"Time"] <- format(powerConsumpSubset[1441:2880,"Time"],"2007-02-02 %H:%M:%S")
#Plot
plot(powerConsumpSubset$Time,powerConsumpSubset$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
with(powerConsumpSubset,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(powerConsumpSubset,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(powerConsumpSubset,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
title(main="Energy sub-metering")