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
household_power_consumption$Date <- as.Date(household_power_consumption$Date, format="%Y/%m/%d")

df = subset(household_power_consumption, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
df$Global_active_power <- as.numeric(df$Global_active_power)
df$Sub_metering_1 <- as.numeric(subSetData$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(subSetData$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(subSetData$Sub_metering_3)

# making date time
df$datetime <- as.POSIXct(paste(as.Date(df$Date), df$Time))

## Ploting ####
plot(df$datetime, df$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(df$datetime, df$Sub_metering_2, type="l", col="red")
lines(df$datetime, df$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()