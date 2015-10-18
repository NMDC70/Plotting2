NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
baltimoredata <- NEI[NEI$fips == "24510", ]
z <- aggregate(Emissions~type+year, data = baltimoredata, sum)
png(filename = "plot3.png")
  ggplot(data=z, aes(x=year, y=Emissions, group=type, shape = type)) + geom_line() +geom_point()
dev.off()