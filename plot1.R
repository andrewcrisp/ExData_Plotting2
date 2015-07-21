################################################################################
#
# Author:         Andrew Crisp
# Filename: 			plot1.R
# Comments:			  
#						      This script will:
#  					      1. Source the loadData.R script to load data.
#  					      2. Demonstrate with Base graphics the total PM2.5 emissions
#    				          from all sources for each of the years 1999, 2002, 2005,
#    				          2008.
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
options(scipen = 5)

interestingData<-summaryData[,c(18,20)]

totalPM25 <- interestingData %>%
  tbl_df %>%
  group_by(year) %>%
  summarise_each(funs(sum))

png("plot1.png", width=480, height=480)
barplot(height = totalPM25$Emissions, names.arg = totalPM25$year, main = "Total PM2.5 Emissions by Year", xlab = "Year", ylab = "Total PM2.5 Emissions")
dev.off()

