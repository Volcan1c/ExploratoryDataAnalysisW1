library(dplyr)
setwd("~/plots")

#Reading the data and changing formats
datas <- read.table("household_power_consumption.txt", sep=";", header = TRUE)
datas[, 1] <- dmy(datas[, 1])
plotdata <- filter(datas, Date == "2007-02-02" | Date == "2007-02-01")
plotdata[, 3] <- as.numeric(paste(plotdata[, 3]))

#Plot construction
par(mfcol = c(1, 1))
hist(plotdata$Global_active_power, breaks = 15, col="red", xlab = "Global Active Power (killowatts)", main = "Global Active Power")

dev.copy(png, file = "plot1.png")
dev.off()