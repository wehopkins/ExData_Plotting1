# plot3.R

library(readr)
library(lubridate)
library(dplyr)

hh.power.consumption.file <- "household_power_consumption.txt"

# need only date, time, and sub metering 1, 2 & 3
hh.power.con.types <- "cc----nnn"

hh.power.con.df <- read_delim(file=hh.power.consumption.file,delim=";",na="?",
                              col_types=hh.power.con.types)

# reduce to the specified two days, add datetime for the time series plot
hh.power.con.df <- hh.power.con.df%>%mutate(Date=dmy(Date))%>%
  filter(Date%in%ymd(c("2007-02-01","2007-02-02")))%>%
  mutate(datetime=ymd_hms(paste(Date,Time)))

# initalize the PNG graphics driver (correct resolution is defaulted)
png("plot3.png")

# create the time series plot
with(hh.power.con.df,
     {
       plot(datetime,Sub_metering_1,
            main="",
            xlab="",
            ylab="Energy sub metering",
            type="l",
            ylim=range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3))
       )
       lines(datetime,Sub_metering_2,col="red")
       lines(datetime,Sub_metering_3,col="blue")
       legend("topright",
              legend=names(hh.power.con.df)[3:5],
              col=c("black","red","blue"),
              lty="solid"
       )
     }
)

dev.off()