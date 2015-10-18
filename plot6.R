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
ladata <- NEI[NEI$fips == "06037", ]
lamvpol <- ladata[ladata$SCC %in% SCCSubsetMV1$SCC,]
K1 <- aggregate(Emissions~year, data = lamvpol, sum)
k12 <- merge(K, K1, by = c("year"))
colnames(k12) <- c("year", "Baltimore", "LosAngeles")
png(filename = "plot6.png")
plot(k12$year, k12$LosAngeles, type = "l",  ylim = c(0, 9000), main = "Comparison: LA vs Baltimore, Motor Vehicle PM 25 Emission", col = "blue", xlab = "Year", ylab = "Total PM25 Emission - Motor Vehicles")
  lines(k12$year, k12$Baltimore, type = "l", col = "red")
  legend("topright", lty = 1, lwd = 1 , bty = "n",col = c("blue", "red"), legend = c("Los Angeles", "Baltimore" ))
dev.off()