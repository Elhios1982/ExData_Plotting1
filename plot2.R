library("dplyr")
library("lubridate")
setwd("C:/coursera/data-science/ExData/ExData_Plotting1")

## Defining variables for the URL of the file and the name and location_ 
## for the zip file
urlFile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "./data/exData_household_power_consumption.zip"

## Creates the folder "./data" if it doesn't exist
if(!dir.exists("./data")){
  dir.create("./data")
}

## Downloads the source file if it doesn't exist
if(!file.exists(zipFile)){
  download.file(urlFile, zipFile)
}

## Unzips the file in "./data" folder
unzip(zipFile, overwrite = TRUE, exdir = "./data")

## Loads data set into hhPwr data frame and using lubridate casts Date and Time columns
columnClasses <- c("character","character","numeric","numeric","numeric", "numeric", "numeric", "numeric", "numeric")
hhPwr <- read.csv("./data/household_power_consumption.txt", sep =";", header = TRUE, 
                  colClasses = columnClasses , na.strings = "?") %>%
  tbl_df() %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  mutate(Date = dmy(Date)) %>%
  mutate(Time = hms(Time)) 

## Creates plot
png("plot2.png", width=480, height=480)
with(hhPwr, plot(ymd_hms(paste(Date,paste(hour(Time), minute(Time), second(Time), sep = ":"), sep = " ")), Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()  







