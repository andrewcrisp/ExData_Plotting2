################################################################################
#
# Author:         Andrew Crisp
# Filename:       plot5.R
# Comments:  		  
#						      This script will:
#  					      1. Source the loadData.R script to load data.
#  					      2. Demonstrate  the change in PM2.5 emissions from motor 
#          	          vehicle sources in Baltimore City, Maryland for each of 
#          	          the years 1999, 2002, 2005, 2008.
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

interestingData <- summaryData[which(summaryData$fips == "24510"), c(8,18,19,20)]
TwoVehicles <- grep("Vehicle",interestingData$SCC.Level.Two)
interestingData <- interestingData[TwoVehicles,]


totalPM25 <- interestingData %>%
  tbl_df %>%
  group_by(SCC.Level.Two,type,year) %>%
  summarise_each(funs(sum))

png("plot5.png", width=480, height=480)
g <- ggplot(totalPM25, aes(x = factor(year), y = Emissions, fill = factor(SCC.Level.Two)))
g <- g + geom_bar(stat="identity", position = position_dodge()) + 
  scale_fill_discrete(name="Vehicle type") +
  labs(title = expression("Motor vehicle emissions, Baltimore City, Maryland")) +
  labs(x = "year", y = expression("Total " * PM[2.5] * " Emissions")) + 
  theme(legend.position = c(.7,.75))

print(g)
dev.off()

