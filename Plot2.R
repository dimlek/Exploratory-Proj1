library(dplyr)
x<- read.table("household_power_consumption.txt",sep=";",header=T,na.strings="?",as.is=T,colClasses=c(NA, "NULL", "NULL","NULL","NULL","NULL","NULL","NULL","NULL"))
keep<-grep(pattern='(^1/2/2007)|(^2/2/2007)',x$Date)
to_skip<-head(keep,n=1)
x<-read.table("household_power_consumption.txt",sep=";",header=T,nrows=2)
name_col<-names(x)
x<-read.table("household_power_consumption.txt",sep=";",header=F,na.strings="?",as.is=T,skip = to_skip,nrows = length(keep))
names(x)<-name_col
x<-mutate(x,DateTime=paste(Date,Time))
x<-select(x,DateTime,Global_active_power:Sub_metering_3)
x$DateTime<-strptime(x$DateTime,format = "%d/%m/%Y %H:%M:%S")
png("plot2.png",width=480,height=480)
plot(x$DateTime,x$Global_active_power,type = "l",xlab = "",ylab="Global Active Power (kilowatts)")
dev.off()

        