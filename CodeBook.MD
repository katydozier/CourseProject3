Introduction

#1 
Merge the training and the test sets to create one data set.

After setting the source directory, read in the training data into the following tables:
features reads in features.txt
activity type reads in activity_labels.txt
subjectTrain reads in subject_train.txt
XTrain reads in x_train.txt
yTrain reads in y_train.txt

Assign the following column names to training data:
activity type
subjectTrain
xTrain
yTrain

Create final training data set by merging yTrain, subjectTrain and xTrain.

Read in the test data into the following tables:
sujectTest reads in subject_test.txt
xTest reads in x_test.txt
yTest reads in y_test.txt

Assign the following column names to test data:
subjectTest
xTest
yTest

Create final test data set by merging yTrain, subjectTrain and xTrain.

Create a vector for column names from finalData set.

#2
Extract only the measurements on the mean and standard deviation for each measurement.

Create a logcal vector that contains TRUE values for the ID, mean and stdev columns and FALSE values for the others. Subset this data to keep only the necessary columns.

#3
Use descriptive activity names to name the activities in the data set.

Merge finalData subset with the activityType table to include the descriptive activity names and update colNames after merge.

#4
Appropriately label the data set with descriptive activity names.

Use gsub function for pattern replacement to clean up the data labels.

#5
Create a second, independent tidy data set with the average of each variable for each activity and each subject.

Per the project instructions, we need to produce only a data set with the average of each veriable for each activity and subject.
