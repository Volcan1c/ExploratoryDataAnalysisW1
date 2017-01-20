library(dplyr)
setwd("~/plots")

#Reading the data and changing formats
datas <- read.table("household_power_consumption.txt", sep=";", header = TRUE)
datas[, 1] <- dmy(datas[, 1])
plotdata <- filter(datas, Date == "2007-02-02" | Date == "2007-02-01")
plotdata <- mutate(plotdata, weekday = weekdays(plotdata[,1], abbreviate = TRUE))
plotdata <- mutate(plotdata, datetime = paste(as.character(plotdata[, 1]),as.character(plotdata[, 2])))
plotdata$datetime <- strptime(plotdata$datetime, format="%Y-%m-%d %H:%M:%S")

#Plot construction
par(mfcol = c(1, 1))
plot(plotdata$datetime, as.numeric(paste(plotdata$Sub_metering_1)), type = "l", ylab = "Energy sub metering", xlab = "")
points(plotdata$datetime, as.numeric(paste(plotdata$Sub_metering_2)), type = "l", col = "red")
points(plotdata$datetime, as.numeric(paste(plotdata$Sub_metering_3)), type = "l", col = "blue")
legend("topright", legend = names(plotdata)[7:9], lty=1, col = c("black", "red", "blue"))

dev.copy(png, file = "plot3.png")
dev.off()