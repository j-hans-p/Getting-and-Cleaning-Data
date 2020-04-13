library(dplyr)
library(tidyr)
library(readr)
library(downloader)
library(data.table)

#Get project directory and create a data folder
wd = getwd()
if(!file.exists("data")){dir.create("data")}

#Download and unzip the zip file
fileurl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, dest="./dataset.zip", mode="wb") 
unzip(zipfile = "dataset.zip", exdir = "./data")

#Read files and create raw data tables
datapath = file.path("./data", "UCI HAR Dataset")
files = list.files(datapath, recursive=TRUE)

xtrain <- read.table(file.path(datapath, "train", "X_train.txt"),header = FALSE)
ytrain <- read.table(file.path(datapath, "train", "y_train.txt"),header = FALSE)
subject_train <- read.table(file.path(datapath, "train", "subject_train.txt"),header = FALSE)

xtest <- read.table(file.path(datapath, "test", "X_test.txt"),header = FALSE)
ytest <- read.table(file.path(datapath, "test", "y_test.txt"),header = FALSE)
subject_test <- read.table(file.path(datapath, "test", "subject_test.txt"),header = FALSE)

features <- read.table(file.path(datapath, "features.txt"),header = FALSE, stringsAsFactors = FALSE)
activity_labels <- read.table(file.path(datapath, "activity_labels.txt"),header = FALSE,stringsAsFactors = TRUE)

#Q1: Merge the training and the test sets to create one data set
test <- cbind(subject_test,ytest,xtest)
train <- cbind(subject_train,ytrain,xtrain)
completedataset <- rbind(test,train)

#Q2: Extracts only the measurements on the mean and standard deviation for each measurement
colnames(completedataset) <- c("Subject", "Activity",features[,2])
data_extract_mean_std_temp <- subset(completedataset, select = grep("mean|std", colnames(completedataset)))
data_extract_mean_std <- data_extract_mean_std_temp[,-grep("meanFreq", colnames(data_extract_mean_std_temp))]


#Q3 Uses descriptive activity names to name the activities in the data set
completedataset[,2] <- factor(completedataset[,2], labels= activity_labels[,2])

#Q4 Appropriately label the data set with descriptive variable names (note, this was also already done for Q2)
colnames(completedataset) <- c("Subject", "Activity",features[,2])

#Q5 From the data set in step 4, creates a second, independent tidy data set with the 
#   average of each variable for each activity and each subject.
ave_by_subact <- arrange(aggregate(completedataset[, 3:563], list(completedataset$Subject,completedataset$Activity), mean),Group.1)
colnames(ave_by_subact) <- c("Subject", "Activity",features[,2])

