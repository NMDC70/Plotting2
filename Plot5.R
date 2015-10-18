NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
char2 <-c("Mobile - On-Road|Mobile - Non-Road|Mobile - Locomotives")
SCCSubsetMV1 <- SCC[grep(char2, SCC$EI.Sector), ]
baltmvpol <- baltimoredata[baltimoredata$SCC %in% SCCSubsetMV1$SCC,]
K <- aggregate(Emissions~year, data = baltmvpol, sum)
## EI.Sector gives the widest set of observations for Motor vehicles with 1694 rows
## subsetting on SCC.Level.Two we get 1452 rows which are all contained within the 1694 rows above
## subsetting on level three & four give 552 & 390 observations respectively
## I have defined Motor Vehicles to exlude Marine Vessels & Aircrafts from the "Mobile" set
png(filename = "plot5.png")
  plot(K$year, K$Emissions, type = "l", col = "red", main = "Baltimore: Motor Vehicle PM25 Emission trend", xlab = "Year", ylab = "Total PM25 Emissions from Motor Vehicles")
dev.off()