# plot4.R

library(readr)
library(lubridate)
library(dplyr)

hh.power.consumption.file <- "household_power_consumption.txt"

# need date, time, global active power, global reactive power, voltage, and sub metering 1, 2 & 3
hh.power.con.types <- "ccnnn-nnn"

hh.power.con.df <- read_delim(file=hh.power.consumption.file,delim=";",na="?",
                              col_types=hh.power.con.types)

# reduce to the specified two days, add datetime for the time series plot
hh.power.con.df <- hh.power.con.df%>%mutate(Date=dmy(Date))%>%
  filter(Date%in%ymd(c("2007-02-01","2007-02-02")))%>%
  mutate(datetime=ymd_hms(paste(Date,Time)))

# initalize the PNG graphics driver (correct resolution is defaulted)
png("plot4.png")

# set column-wise 2 row 2 column display
old.par <- par(mfcol=c(2,2))

# create the Global active power time series plot
with(hh.power.con.df,
     plot(datetime,Global_active_power,
          main="",
          xlab="",
          ylab="Global Active Power (kilowatts)",
          type="l"
     )
)

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
              legend=names(hh.power.con.df)[6:8],
              col=c("black","red","blue"),
              lty="solid",
              bty="n"
       )
     }
)

# create the Voltage time series plot
with(hh.power.con.df,
     plot(datetime,Voltage,
          main="",
          type="l"
     )
)

# create the Global reactive power time series plot
with(hh.power.con.df,
     plot(datetime,Global_reactive_power,
          main="",
          type="l"
     )
)

# restore global graphics parameters
par(old.par)

dev.off()