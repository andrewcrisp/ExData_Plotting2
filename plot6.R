################################################################################
#
# Author:         Andrew Crisp
# Filename:       plot6.R
# Comments:    	  
#						      This script will:
#  					      1. Source the loadData.R script to load data.
#  					      2. Compare PM2.5 emissions from motor 
#          	          vehicle sources in Baltimore City, Maryland with those
#                     from Los Angeles County, California for each of the years
#                     1999, 2002, 2005, 2008.
#    				      
################################################################################
################################################################################
### Imports
################################################################################
library(dplyr)
library(ggplot2)

################################################################################
### Load dataset
################################################################################
source('loadData.R')
options(scipen = 5)

BaltimoreCity <- summaryData[which(summaryData$fips == "24510"), c(8,16,18,20)]
LACounty <- summaryData[which(summaryData$fips == "06037"), c(8,16,18,20)]
interestingData <- rbind(BaltimoreCity, LACounty)
TwoVehicles <- grep("Vehicle",interestingData$SCC.Level.Two)

interestingData <- interestingData[TwoVehicles,]


totalPM25 <- interestingData %>%
  tbl_df %>%
  group_by(fips,SCC.Level.Two,year) %>%
  summarise_each(funs(sum))

png("plot6.png", width=480, height=480)
g <- ggplot(totalPM25, aes(x = factor(year), y = Emissions, fill = factor(fips)))
g <- g + geom_bar(stat="identity", position = position_dodge()) + 
  scale_fill_discrete(name="Location", labels=c("LA County","Baltimore City")) +
  #facet_grid(SCC.Level.Two ~ .) +
  labs(title = expression("Motor vehicle emissions, LA County vs Baltimore City")) +
  labs(x = "year", y = expression("Total " * PM[2.5] * " Emissions")) + 
  theme(legend.position = c(.85,.9))

print(g)
dev.off()