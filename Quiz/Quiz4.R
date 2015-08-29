#Q1
#Apply strsplit() to split all the names of the data frame on the characters "wgtp". 
#What is the value of the 123 element of the resulting list?

setwd('/Users/PAN/Desktop/Learn/Coursera/DataScience/Getting and Cleaning Data/Quiz')
fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
download.file(fileUrl,destfile = 'survey.csv', method ='curl')
data<-read.csv('survey.csv')
x<-names(data)
strsplit(x,"wgtp")

#Q2 & 3
#Remove the commas from the GDP numbers in millions of dollars and average them.
#What is the average? 
setwd('/Users/PAN/Desktop/Learn/Coursera/DataScience/Getting and Cleaning Data/Quiz')
fileUrl1 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv '
download.file(fileUrl1,destfile = 'GDP.csv', method ='curl')
GDP<-read.csv("GDP.csv", header=F, skip=5, nrows=190) 
x<-gsub(",","",GDP[,5])
numy<-as.numeric(x)
grep("^United",GDP[,4])

#Q4
setwd('/Users/PAN/Desktop/Learn/Coursera/DataScience/Getting and Cleaning Data/Quiz')
fileUrl1 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv '
fileUrl2 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv' 
download.file(fileUrl1,destfile = 'GDP.csv', method ='curl')
download.file(fileUrl2,destfile = 'FED.csv', method ='curl')
GDP<-read.csv("GDP.csv", header=F, skip=5, nrows=190) 
FED<-read.csv("FED.csv")
#View(GDP)
#View(FED)
mergedata <- merge(GDP,FED,by.x='V1',by.y='CountryCode',sort=TRUE)
View(mergedata)
x<-as.character(mergedata[,19])
length(grep("Fiscal year end: June",x))

#Q5
#How many values were collected in 2012? 
#How many values were collected on Mondays in 2012?
install.packages("quantmod")
library(quantmod)
install.pacakges("lubridate")
library(lubridate)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
length(sampleTimes)
x <- year(sampleTimes) == 2012
length(sampleTimes[x])
y <- weekdays(sampleTimes)=="Monday"
length(sampleTimes[x & y])
