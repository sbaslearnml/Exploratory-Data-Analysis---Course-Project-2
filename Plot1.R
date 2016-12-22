## download and unzip the file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile = "data.zip", method = "curl")
unzip ("data.zip", exdir = "./")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Aggregate by caculating sum of the total emissions by year
aggEmissionsbyyear <- aggregate(Emissions ~ year,NEI, sum)

## plot the graph and add the text lables
plot(aggEmissionsbyyear, type = "l", ylab = "Total Emissions (PM25)", xlab = "Year" , col = "green")
text(aggEmissionsbyyear$year, aggEmissionsbyyear$Emissions, round(aggEmissionsbyyear$Emissions))

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()