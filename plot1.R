# plot1.R

library(readr)
library(lubridate)
library(dplyr)

hh.power.consumption.file <- "household_power_consumption.txt"

# need only date (to filter on the specific two days) and global active power, third column
hh.power.con.types <- "c-n------"

hh.power.con.df <- read_delim(file=hh.power.consumption.file,delim=";",na="?",
                              col_types=hh.power.con.types)

# reduce to the specified two days, 
hh.power.con.df <- hh.power.con.df%>%mutate(Date=dmy(Date))%>%
  filter(Date%in%ymd(c("2007-02-01","2007-02-02")))

# initalize the PNG graphics driver (correct resolution is defaulted)
png("plot1.png")

# create the histogram
hist(hh.power.con.df$Global_active_power,
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     col="red")

dev.off()