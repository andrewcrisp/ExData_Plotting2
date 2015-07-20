################################################################################
#
# Author:         Andrew Crisp
# Filename:   		plot2.R
# Comments:			  
#						      This script will:
#  					      1. Source the loadData.R script to load data.
#  					      2. Demonstrate with Base graphics the total PM2.5 emissions
#    				          from Baltimore City, Maryland for each of the years 1999,
#    				          2002, 2005, 2008.
#    				      
################################################################################
################################################################################
### Imports
################################################################################
library(dplyr)

################################################################################
### Load dataset
################################################################################
source('loadData.R')

interestingData <- summaryData[which(summaryData$fips == "24510"), c(18,20)]

totalPM25 <- interestingData %>%
  tbl_df %>%
  group_by(year) %>%
  summarise_each(funs(sum))

png("plot2.png", width=480, height=480)
barplot(height = totalPM25$Emissions, names.arg = totalPM25$year, main = "Total PM2.5 Emissions by Year in Baltimore City, Maryland", xlab = "Year", ylab = "Total PM2.5 Emissions")
dev.off()