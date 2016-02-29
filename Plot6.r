#Exploratory Data Analysis


##
## Question #6:  Compare emissions from motor vehicle sources in Baltimore City with emissions 
##               from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
##               Which city has seen greater changes over time in motor vehicle emissions?


##
## Answer: Baltimore has seen a large decline during the time period. In Los Angeles, there was a steep 
##         increase in emisions from 1999 to 2005, and then a steep decline from 2005 to 2008. I suspect that
##         there are other variables at work here that are not completely explained by the data.



library(ggplot2)

setwd("C:\\data\\exploratory\\")
data <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

data$year <- factor(data$year, levels=c('1999', '2002', '2005', '2008'))

# Baltimore City, Maryland
# Los Angeles County, California
MD.onroad <- subset(data, fips == '24510' & type == 'ON-ROAD')
CA.onroad <- subset(data, fips == '06037' & type == 'ON-ROAD')

# Aggregate
MD.DF <- aggregate(MD.onroad[, 'Emissions'], by=list(MD.onroad$year), sum)
colnames(MD.DF) <- c('year', 'Emissions')
MD.DF$City <- paste(rep('MD', 4))

CA.DF <- aggregate(CA.onroad[, 'Emissions'], by=list(CA.onroad$year), sum)
colnames(CA.DF) <- c('year', 'Emissions')
CA.DF$City <- paste(rep('CA', 4))

DF <- as.data.frame(rbind(MD.DF, CA.DF))

png('plot6.png')

ggplot(data=DF, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year)) + guides(fill=F) + 
  ggtitle('Total Emissions of Motor Vehicle Sources LA County vs. Baltimore') + 
  ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + facet_grid(. ~ City) + 
  geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1))

dev.off()

