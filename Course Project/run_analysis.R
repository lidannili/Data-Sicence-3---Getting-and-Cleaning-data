#You should create one R script called run_analysis.R that does the following. 
#1.Merges the training and the test sets to create one data set.
#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
#3.Uses descriptive activity names to name the activities in the data set
#4.Appropriately labels the data set with descriptive variable names. 
#5.From the data set in step 4, creates a second, independent tidy data set with the average 
#of each variable for each activity and each subject.
setwd("/Users/PAN/Desktop/Learn/Coursera/DataScience/Getting and Cleaning Data/Course Project/UCI HAR Dataset")
install.packages("data.table")
library(data.table)
install.packages("plyr")
library(plyr)

#1
features <- read.table('./features.txt',header=FALSE)
subject_train<- read.table('./train/subject_train.txt',header=FALSE) 
#Each row identifies the subject who performed the activity for each window sample. 
#Its range is from 1 to 30. 
x_train<-read.table('./train/X_train.txt',header=FALSE)#Training set
y_train<-read.table('./train/y_train.txt',header=FALSE)#Training lables
colnames(subject_train)="Subject ID"
colnames(x_train)=features[,2]
colnames(y_train)="Activity Type"

subject_test = read.table('./test/subject_test.txt',header=FALSE)
x_test<-read.table('./test/X_test.txt',header=FALSE)#Test set
y_test<-read.table('./test/y_test.txt',header=FALSE)#Test lables
colnames(subject_test)="Subject ID"
colnames(x_test)=features[,2]
colnames(y_test)="Activity Type"

test<-cbind(y_test,subject_test,x_test)
train<-cbind(y_train,subject_train,x_train)
x<-rbind(x_train,x_test)
y<-rbind(y_train,y_test)
subject<-rbind(subject_train, subject_test)


#2
mean_std <- grep("-(mean|std)\\(\\)", features[, 2])
#grep, grepl, regexpr and gregexpr search for matches to argument 
#pattern within each element of a character vector: they differ in 
#the format of and amount of detail in the results.

# subset the desired columns
x <- x[, mean_std]

#3
#3.Uses descriptive activity names to name the activities in the data set
activity_labels <-read.table('./activity_labels.txt',header=FALSE) 
y[,1]<-activity_labels[y[, 1], 2]
#4.Appropriately labels the data set with descriptive variable names. 
combine<-cbind(subject,y,x)
#5.From the data set in step 4, creates a second, independent tidy data set with the average 
#of each variable for each activity and each subject.
tidydata <- ddply(combine, .("Subject ID", "Activity Type"), function(x) colMeans(x[, 3:68]))
write.table(tidydata, "tidydata.txt", row.name=FALSE)
