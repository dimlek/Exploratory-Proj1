library(dplyr)
#Read only the first column of dataset (Dates)
x<- read.table("household_power_consumption.txt",sep=";",header=T,na.strings="?",as.is=T,colClasses=c(NA, "NULL", "NULL","NULL","NULL","NULL","NULL","NULL","NULL"))
#Select dates of interest and tore in variable 'keep'
keep<-grep(pattern='(^1/2/2007)|(^2/2/2007)',x$Date)
to_skip<-head(keep,n=1)
#Store table header
x<-read.table("household_power_consumption.txt",sep=";",header=T,nrows=2)
name_col<-names(x)
#Read in table, this time all columns but only rows of interest and assign header
x<-read.table("household_power_consumption.txt",sep=";",header=F,na.strings="?",as.is=T,skip = to_skip,nrows = length(keep))
names(x)<-name_col
#Merge Date and Time variables into one
x<-mutate(x,DateTime=paste(Date,Time))
x<-select(x,DateTime,Global_active_power:Sub_metering_3)
#Convert Date and time variable to "POSIXlt Class
x$DateTime<-strptime(x$DateTime,format = "%d/%m/%Y %H:%M:%S")
png("plot1.png",width=480,height=480)
hist(x$Global_active_power,xlab = "Global Active Power (kilowatts)",main = "Global Active Power",col="red")
dev.off()

        