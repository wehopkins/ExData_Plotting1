# plot2.R

library(readr)
library(lubridate)
library(dplyr)

hh.power.consumption.file <- "household_power_consumption.txt"

# need only date, time, and global active power, third column
hh.power.con.types <- "ccn------"

hh.power.con.df <- read_delim(file=hh.power.consumption.file,delim=";",na="?",
                              col_types=hh.power.con.types)

# reduce to the specified two days, add datetime for the time series plot
hh.power.con.df <- hh.power.con.df%>%mutate(Date=dmy(Date))%>%
  filter(Date%in%ymd(c("2007-02-01","2007-02-02")))%>%
  mutate(datetime=ymd_hms(paste(Date,Time)))

# initalize the PNG graphics driver (correct resolution is defaulted)
png("plot2.png")

# create the time series plot
with(hh.power.con.df,
     plot(datetime,Global_active_power,
          main="",
          xlab="",
          ylab="Global Active Power (kilowatts)",
          type="l"
     )
)

dev.off()