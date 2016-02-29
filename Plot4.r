#Exploratory Data Analysis


##
#Question #4:  Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
##

##
#Answer:  From 1999 to 2008 coal combustion-related couses have drastically declined. 
##


library(plyr)
library(ggplot2)

setwd("C:\\data\\exploratory\\")
data <- readRDS("summarySCC_PM25.rds")
classification <- readRDS("Source_Classification_Code.rds")

coalcomb.scc <- subset(classification, EI.Sector %in% c("Fuel Comb - Comm/Instutional - Coal", 
                                             "Fuel Comb - Electric Generation - Coal", "Fuel Comb - Industrial Boilers, ICEs - 
                                             Coal"))

coalcomb.scc1 <- subset(classification, grepl("Comb", Short.Name) & grepl("Coal", Short.Name))

dif1 <- setdiff(coalcomb.scc$SCC, coalcomb.scc1$SCC)
dif2 <- setdiff(coalcomb.scc1$SCC, coalcomb.scc$SCC)

coalcomb.codes <- union(coalcomb.scc$SCC, coalcomb.scc1$SCC)
coal.comb <- subset(NEI, SCC %in% coalcomb.codes)
coalcomb.pm25year <- ddply(coal.comb, .(year, type), function(x) sum(x$Emissions))
colnames(coalcomb.pm25year)[3] <- "Emissions"

png("plot4.png")
qplot(year, Emissions, data=coalcomb.pm25year, color=type, geom="line") + stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", color = "green", aes(shape="total"), geom="line")
dev.off()







