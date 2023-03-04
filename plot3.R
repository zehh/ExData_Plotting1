library(tidyverse)
library(lubridate)
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!dir.exists("data")){
        dir.create("data")
}
download.file(url,"data/data.zip")
unzip("data/data.zip", exdir = "data")
initialLine <- 66638
finalLine <- 69517
variableNames <- readLines("data/household_power_consumption.txt", n=1)
variableNames<-str_split_1(variableNames,";")
raw <- read_delim("./data/household_power_consumption.txt",
                  delim = ";", na="?", n_max = finalLine - initialLine + 1,
                  skip = initialLine - 1, col_names = variableNames)
raw <- mutate(raw,Date = dmy(Date))
raw<-mutate(raw,newTime = ymd_hms(paste(Date,Time)))
png("plot3.png")
        with(raw,plot(newTime,Sub_metering_1,type = "n",
                      ylab = "Energy sub metering"))
        with(raw,lines(newTime,Sub_metering_1,col = "black"))
        with(raw,lines(newTime,Sub_metering_2,col = "red"))
        with(raw,lines(newTime,Sub_metering_3,col = "blue"))
        legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
               col = c("black","red","blue"), lty = 1)
dev.off()