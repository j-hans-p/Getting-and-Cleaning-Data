# Getting-and-Cleaning-Data
Final Project Code for Getting and Cleaning Data Course

This repo contains a single script, run_analysis.R that downloads and unzips data from: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Using that data, several tasks are completed:
1: The data, which is spread across several files is combined into a single tidy dataset called 'completedataset'containing 10,299 rows of data and 563 coloums
2: A new data table is created that contains only the subset of columns containing mean and std data
3: Activity names are used to replace activity code numbers and descriptive titles are given to each of the data columns
4: Finally, averages for each of the data columns are computed for each subject / activity combination and saved in a new data table: ave_by_subact
