library(data.table)
#Downlaod and unzip file.
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                          destfile = "household_power_consumption.zip", method = "curl")
powerzip<- unzip("household_power_consumption.zip", files = "household_power_consumption.txt", list = FALSE
                   )
powerdata <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)
head(powerdata)
summary(powerdata)
names(powerdata)

powerdata[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
powerdata[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]
powerDT <- powerdata <- powerdata[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

## Plot 1
hist(powerDT[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()
