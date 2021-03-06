## init ####



## getting data ####
if (!file.exists("household_power_consumption.txt")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile = "Dataset.zip")
  unzip("Dataset.zip")
  fileConn<-file("date_downloaded.txt")
  writeLines(date(), fileConn)
  close(fileConn)
}

## Loading data ####
household_power_consumption <- read.table("~/R/Exploratory-Data-Analysis/Project1/household_power_consumption.txt",  header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
household_power_consumption$Date <- as.Date(household_power_consumption$Date, format="%d/%m/%Y")

df = subset(household_power_consumption, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
df$Global_active_power <- as.numeric(df$Global_active_power)

# making date time
df$datetime <- as.POSIXct(as.Date(df$Date), df$Time)

## Ploting ####
hist(df$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()