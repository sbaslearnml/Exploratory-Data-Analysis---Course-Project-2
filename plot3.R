## download and unzip the file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile = "data.zip", method = "curl")
unzip ("data.zip", exdir = "./")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Filter Baltimore dtaa alone
BaltimoreNEI <- NEI[NEI$fips=="24510",]

# Aggregate by caculating sum of the total emissions by year
aggEmissionsbyyear <- aggregate(Emissions ~ year + type,BaltimoreNEI, sum)

## plot the graph and add the text lables
qplot(aggEmissionsbyyear$year, aggEmissionsbyyear$Emissions, group = aggEmissionsbyyear$type, col = aggEmissionsbyyear$type, geom = c("point", "line"), ylab = "Baltimore PM25 levels", xlab = "Year")

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()