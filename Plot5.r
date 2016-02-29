#Exploratory Data Analysis


##
#Question #5: How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
##

##
##Answer: In 1999 the PM2.5 was newar 249. Levels fell sharply until 2002. From 2002 to 2005 the levels 
##        stablized. From 2005 to 2008, PM2.5 fell below 100.


library(plyr)
library(ggplot2)

setwd("C:\\data\\exploratory\\")
data <- readRDS("summarySCC_PM25.rds")
classification <- readRDS("Source_Classification_Code.rds")

mv.sourced <- unique(grep("Vehicles", classification$EI.Sector, ignore.case = TRUE, value = TRUE))
mv.sourcec <- classification[classification$EI.Sector %in% mv.sourced, ]["SCC"]
emMV.ba <- data[data$SCC %in% mv.sourcec$SCC & data$fips == "24510",]
balmv.pm25yr <- ddply(emMV.ba, .(year), function(x) sum(x$Emissions))
colnames(balmv.pm25yr)[2] <- "Emissions"

png("plot5.png")
qplot(year, Emissions, data=balmv.pm25yr, geom="line") + ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()
