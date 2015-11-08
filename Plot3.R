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
png("plot3.png",width=480,height=480)
plot(x$DateTime,x$Sub_metering_1,type = "l",xlab = "",ylab="Energy sub metering")
points(x$DateTime,x$Sub_metering_2,type="l",col="red")
points(x$DateTime,x$Sub_metering_3,type="l",col="blue")
legend(legend = names(x)[6:8],x="topright",lty=1,col=c("black","red","blue"))
dev.off()

        