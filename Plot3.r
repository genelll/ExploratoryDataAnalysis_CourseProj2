#Exploratory Data Analysis


##
##Question #3:  Of the four types of sources indicated by the type (point, nonpoint, onroad, 
##              nonroad) variable, which of these four sources have seen decreases in emissions 
##              from 1999-2008 for Baltimore City? Which have seen increases in emissions from 
##              1999-2008? Use the ggplot2 plotting system to make a plot answer this question.
##


##
##Answer:  The data shows that all 4 sources have seen decreases in emissions, however some of the
##        show more volatility than others. nonpoint showed a period of steep decline from 1990 to 2002
##        and then gradual decline after that. the point source showed periods of sharp increase as well
##        as periods of decline. Non-road and on-road showed similar paths of gradual decline over time.
##

library(ggplot2)
library(plyr)

setwd("C:\\data\\exploratory\\")
data <- readRDS("summarySCC_PM25.rds")
classification <- readRDS("Source_Classification_Code.rds")

baltimore <- subset (data, fips == "24510")
typePM25.year <- ddply(baltimore, .(year, type), function(x) sum(x$Emissions))

colnames(typePM25.year)[3] <- "Emissions"

png("plot3.png") 
qplot(year, Emissions, data=typePM25.year, color=type, geom ="line") + ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Emmissions")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (in tons)"))
dev.off()
