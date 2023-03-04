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
png("plot1.png")
with(raw,hist(Global_active_power, col = "red", breaks = 15,
              main = "Global Active Power",
              xlab = "Global Active Power (kilowatts)",
              ylab = "Frequency"))
dev.off()