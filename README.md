Getting and Cleaning Data Project

One R script has been created according to the following project specifications:

You should create one R script called run_analysis.R that does the following: 
1. Merges the training and the test sets to create one data set. 
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set 
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

You can find additional information about the variables, data and transformations in the CodeBook.MD file.

Before running script:
1. Download the data source (found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and put into a folder on your local drive. This creates a UCI HAR Dataset folder.
2. Put run_analysis.R in the UCI HAR Dataset folder, then set it as your working directory using setwd() function in RStudio.
3. Run source("run_analysis.R"), then it will generate a new file tidy_data.txt in your working directory.
