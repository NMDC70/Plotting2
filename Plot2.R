NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
baltimoredata <- NEI[NEI$fips == "24510", ]
polbalttotal <-aggregate(Emissions ~ year, data = baltimoredata, sum)
png(filename = "plot2.png")
  plot(polbalttotal$year, polbalttotal$Emissions, type = "l", col = "grey", main = "Baltimore PM25 Emission trend", xlab = "Year", ylab = "Total PM25 Emissions")
dev.off()