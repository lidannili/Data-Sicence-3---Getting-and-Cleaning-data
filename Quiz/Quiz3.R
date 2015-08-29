#Q1
#Create a logical vector that identifies the households on greater than 10 acres who sold more
#than $10,000 worth of agriculture products. Assign that logical vector to the variable 
#agricultureLogical. 
#Apply the which() function like this to identify the rows of the data frame where the 
#logical vector is TRUE. which(agricultureLogical) What are the first 3 values that result?

setwd('/Users/PAN/Desktop/Learn/Coursera/DataScience/Getting and Cleaning Data/Quiz')
fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
download.file(fileUrl,destfile = 'survey.csv', method ='curl')
data<-read.csv('survey.csv')
#agricultureLogical<-ifelse(data$ACR==3 & data$AGS==6,TRUE,FALSE)
agricultureLogical<-(data$ACR==3 & data$AGS==6)
which(agricultureLogical)[1:3]

#Q2
#Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? 
#(some Linux systems may produce an answer 638 different for the 30th quantile)

install.packages("jpeg")
library(jpeg)
fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
download.file(fileUrl,destfile = 'jeff.jpg', method ='curl')
img<- readJPEG('jeff.jpg',native=TRUE)
quantile(img,probs=c(0.3,0.8))

#Q3
#Match the data based on the country shortcode. 
#How many of the IDs match? Sort the data frame in descending order by GDP rank (so United States is last). 
#What is the 13th country in the resulting data frame? 
install.packages("dplyr")
library("dplyr")
fileUrl1 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv '
fileUrl2 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv' 
download.file(fileUrl1,destfile = 'GDP.csv', method ='curl')
download.file(fileUrl2,destfile = 'FED.csv', method ='curl')
GDP<-read.csv("GDP.csv", header=F, skip=5, nrows=190) 
FED<-read.csv("FED.csv")
#View(GDP)
#View(FED)
mergedata <- merge(GDP,FED,by.x='V1',by.y='CountryCode',sort=TRUE)
#View(mergedata)
GDPranking<-arrange(mergedata,desc(V2))

#Q4
#What is the average GDP ranking for the "High income: OECD" and 
#"High income: nonOECD" group?
mergedata1<-filter(mergedata,Income.Group=="High income: OECD")
View(mergedata1)
mean(mergedata1$V2)
mergedata2<-filter(mergedata,Income.Group=="High income: nonOECD")
mean(mergedata2$V2)

#Q5Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. 
#How many countries are Lower middle income but among the 38 nations with highest GDP?
quantile <- c(0.2,0.4,0.6,0.8,1)
q <- quantile(mergedata$V2, quantile)
q1 <- mergedata$V2 <= 38
xtabs(q1 ~ mergedata$Income.Group)