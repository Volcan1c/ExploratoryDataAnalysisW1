library(dplyr)
setwd("~/plots")

#Reading the data and changing formats
datas <- read.table("household_power_consumption.txt", sep=";", header = TRUE)
datas[, 1] <- dmy(datas[, 1])
plotdata <- filter(datas, Date == "2007-02-02" | Date == "2007-02-01")
plotdata[, 3] <- as.numeric(paste(plotdata[, 3]))
plotdata <- mutate(plotdata, weekday = weekdays(plotdata[,1], abbreviate = TRUE))
plotdata <- mutate(plotdata, datetime = paste(as.character(plotdata[, 1]),as.character(plotdata[, 2])))
plotdata$datetime <- strptime(plotdata$datetime, format="%Y-%m-%d %H:%M:%S")

#Plot construction
par(mfcol = c(1, 1))
plot(plotdata$datetime, plotdata$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.copy(png, file = "plot2.png")
dev.off()