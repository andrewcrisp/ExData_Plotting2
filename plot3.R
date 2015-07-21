################################################################################
#
# Author:         Andrew Crisp
# Filename:     	plot3.R
# Comments:			  
#						      This script will:
#  					      1. Source the loadData.R script to load data.
#  					      2. Demonstrate with ggplot2 graphics the change in PM2.5 
#      			          emissions from Baltimore City, Maryland by type of source 
#      			          for each of the years 1999, 2002, 2005, 2008.
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

interestingData <- summaryData[which(summaryData$fips == "24510"), c(18,19,20)]

totalPM25 <- interestingData %>%
  tbl_df %>%
  group_by(type,year) %>%
  summarise_each(funs(sum))

png("plot3.png", width=480, height=480)
g <- ggplot(totalPM25, aes(x = year, y = Emissions))
g <- g + geom_point() +
        geom_smooth(method="lm") +
        facet_grid(type ~ .) +
        labs(title = expression("Total " * PM[2.5] * " Emissions by Year per Type in Baltimore City, Maryland")) +
        labs(x = "year", y = expression("Total " * PM[2.5] * " Emissions")) +
        coord_cartesian(ylim = c(0,2500))
print(g)
dev.off()