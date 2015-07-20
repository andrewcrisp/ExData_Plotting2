################################################################################
#
# Author:       	Andrew Crisp
# Filename: 			loadData.R
# Comments:			  
#						      This script will:
#  					      1. Check for and acquire the dataset as necessary.
#  					      2. Sanitize the data.
#    				      
################################################################################
################################################################################
### Load dataset
################################################################################
if(!file.exists("Source_Classification_Code.rds")){
  if(!file.exists("exdata-data-NEI_Data.zip")){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    destFile <- "exdata-data-NEI_Data.zip"
    download.file(url=fileUrl, destfile=destFile)
  }
  unzip("exdata-data-NEI_Data.zip")
}
if(!file.exists("summarySCC_PM25")){
  if(!file.exists("exdata-data-NEI_Data.zip")){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    destFile <- "exdata-data-NEI_Data.zip"
    download.file(url=fileUrl, destfile=destFile)
  }
  unzip("exdata-data-NEI_Data.zip")
}
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
summaryData <- merge(x=SCC, y=NEI, by="SCC")