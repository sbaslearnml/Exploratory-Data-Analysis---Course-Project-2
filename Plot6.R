## download and unzip the file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile = "data.zip", method = "curl")
unzip ("data.zip", exdir = "./")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## extract the SCC identifies for coal sector
SCC.motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
SCC.motor <- SCC[SCC.motor, ]
SCC.identifiers <- as.character(SCC.motor$SCC)

## Filter for motor related recods in Baltimore
BaltimoreLANEI <- NEI[NEI$fips %in% c("24510","06037"), ]

BaltimoreLAMotorNEI <- BaltimoreLANEI[BaltimoreLANEI$SCC %in% SCC.identifiers,]

# Aggregate by caculating sum of the total emissions by year
aggEmissionsbyyear <- aggregate(Emissions ~ year + fips,BaltimoreLAMotorNEI, sum)

## plot the graph and add the text lables
library(ggplot2)
qplot(aggEmissionsbyyear$year, aggEmissionsbyyear$Emissions, group =aggEmissionsbyyear$fips  ,geom = c("point", "line"), ylab = "PM25 levels from motor vehicles", xlab = "Year", col = aggEmissionsbyyear$fips)

dev.copy(png, file="plot6.png", height=480, width=480)
dev.off()