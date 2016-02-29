#Exploratory Data Analysis


##
##Question #2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.
##

##
##Answer:  YES, the data shows a consistant decline from 1999 to 2002. After that there was increase until 2005, and then
##          another decline from 2005 to 2008.
##


setwd("C:\\data\\exploratory\\")
data <- readRDS("summarySCC_PM25.rds")
classification <- readRDS("Source_Classification_Code.rds")

## Step 2: obtain the subsets to plot
baltimore <- subset (data, fips == "24510")
t.PM25yr <- tapply(baltimore$Emissions, baltimore$year, sum)

## Step 3: plot prepare to plot to png
png("plot2.png")
plot(names(t.PM25yr), t.PM25yr, type = "l", xlab="Year", ylab= expression("Total" ~ PM[2.5] ~ "Emissions (tons)"), main=expression("Total for Baltimore" ~ PM[2.5] ~ "Emissions by Year"), col = "blue")
dev.off()     
