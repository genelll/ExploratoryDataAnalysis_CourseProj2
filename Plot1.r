#Exploratory Data Analysis


##
#Question : 1
##

##
#Answer:  YES, the data shows a consistant decline from the year 2000 through 2008
##


setwd("C:\\data\\exploratory\\")
data <- readRDS("summarySCC_PM25.rds")
classification <- readRDS("Source_Classification_Code.rds")
t.PM25yr <- tapply(data$Emissions, data$year, sum)
png("plot1.png")
plot(names(t.PM25yr), t.PM25yr, type="l", xlab = "Yr", ylab = expression
     ("Total" ~ PM[2.5] ~"Emissions (tons)"), main = expression("Total US" ~ 
     PM[2.5] ~ "Emissions by Year"), col="Blue")
dev.off()
