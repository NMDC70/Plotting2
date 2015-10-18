NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
coal <- c("Coal|coal")
SCCSubsetcoal <- SCC[grep(coal, SCC$Short.Name), ]
## Compared with EI sector(total 99 observations) & other columns of SCC searching for coal 
## in Short.Name gives the largest subset (230 observations)
coal1 <- c("Comb|Fuel|Vessels|fired|Fired|Burning")
SCCSubsetcoal1 <- SCC[grep(coal1, SCCSubsetcoal$Short.Name), ]
## All 230 obervations however are not related to combustion of coal.
## We need to take all items where coal is used as Fuel, fired, burned for various different
## end use. Our final subset gives us an index vector with 127 values.
d1 <- NEI[NEI$SCC %in% SCCSubsetcoal1$SCC, ]
pcoalcomb <- aggregate(Emissions~year, data = d1, sum)
png(filename = "plot4.png")
  plot(pcoalcomb$year, pcoalcomb$Emissions, type = "l", col = "green", main = "United States Coal Combustion PM25 Emission trend", xlab = "Year", ylab = "Total PM25 Emissions from Coal Combustion")
dev.off()
