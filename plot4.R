################################################################################
#
# Author:         Andrew Crisp
# Filename:       plot4.R
# Comments:			  
#						      This script will:
#  					      1. Source the loadData.R script to load data.
#  					      2. Demonstrate  the change in PM2.5 emissions across the USA
#        		          from coal combustion-related sources for each of the
#        		          years 1999, 2002, 2005, 2008.
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

combInLevelOne <- grep("Comb",(summaryData$SCC.Level.One))
coalInLevelThree <- grep("Coal",summaryData$SCC.Level.Three[combInLevelOne])
interestingData<-summaryData[coalInLevelThree,]
interestingData<-interestingData[,c(18,20)]

totalPM25 <- interestingData %>%
  tbl_df %>%
  group_by(year) %>%
  summarise_each(funs(sum))

png("plot4.png", width=480, height=480)
barplot(height = totalPM25$Emissions, names.arg = totalPM25$year, main = "Total PM2.5 Emissions related to coal combustion", xlab = "Year", ylab = "Total PM2.5 Emissions")
dev.off()