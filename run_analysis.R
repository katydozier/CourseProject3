## 1. Merge the training and the test sets to create one data set.

## Set working directory to the location where the UCI HAR Dataset was unzipped:
setwd('/Users/katy.dozier/Desktop/Coursera/gettingcleaningcourseproj/UCI HAR Dataset/')

## Read in the training data:
features = read.table('./features.txt',header=FALSE) ## imports features.txt
activityType = read.table('./activity_labels.txt',header=FALSE) ## imports activity_labels.txt
subjectTrain = read.table('./train/subject_train.txt',header=FALSE) ##imports subject_train.txt
xTrain = read.table('./train/x_train.txt',header=FALSE) ## imports x_train.txt
yTrain = read.table('./train/y_train.txt',header=FALSE) ## imports y_train.txt

## Assign column names to training data:
colnames(activityType)  = c('activityId','activityType')
colnames(subjectTrain)  = "subjectId"
colnames(xTrain)        = features[,2] 
colnames(yTrain)        = "activityId"

## Create final training set by merging yTrain, subjectTrain, and xTrain:
trainingSet = cbind(yTrain,subjectTrain,xTrain)

## Read in the test data:
subjectTest = read.table('./test/subject_test.txt',header=FALSE) ## imports subject_test.txt
xTest = read.table('./test/x_test.txt',header=FALSE) ## imports x_test.txt
yTest = read.table('./test/y_test.txt',header=FALSE) ## imports y_test.txt

## Assign column names to test data:
colnames(subjectTest) = "subjectId"
colnames(xTest) = features[,2]
colnames(yTest) = "activityId"


## Create final test set by merging yTest, subjectTest, and xTest:
testData = cbind(yTest,subjectTest,xTest)


## Combined training and test data to create final data set:
finalData = rbind(trainingSet,testData)

## Create a vector for column names from finalData to be used to select desired mean() & stddev() columns:
colNames  = colnames(finalData)

## 2. Extract only the measurements on the mean & standard deviation for each measurement.

## Create logicalVector that contains TRUE values for ID, mean() & stddev() columns and FALSE for others:
logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames))

## Subset finalData table based on logicalVector to keep only desired columns:
finalData = finalData[logicalVector==TRUE]

## 3. Use descriptive activity names to name activities in data set.

## Merge finalData set with the acitivityType table to include descriptive activity names:
finalData = merge(finalData,activityType,by='activityId',all.x=TRUE)

## Update the colNames vector to include the new column names after merge:
colNames  = colnames(finalData)

## 4. Appropriately label data set with descriptive activity names. 

## Clean up variable names:
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
}

## Reassign the new descriptive column names to the finalData set:
colnames(finalData) = colNames

## 5. Create a second, independent tidy data set with average of each variable for each activity and each subject.

## Create new table, finalDataNoActivityType without the activityType column:
finalNoActivityTypeData  = finalData[,names(finalData) != 'activityType']

## Summarize the finalNoActivityTypeData table to include just mean of each variable for each activity and each subject:
tidyData    = aggregate(finalNoActivityTypeData[,names(finalNoActivityTypeData) != c('activityId','subjectId')],by=list(activityId=finalNoActivityTypeData$activityId,subjectId = finalNoActivityTypeData$subjectId),mean)

## Merge tidyData with activityType to include descriptive acitvity names:
tidyData    = merge(tidyData,activityType,by='activityId',all.x=TRUE)

## Export tidyData set:
write.table(tidyData, './tidyData.txt',row.names=FALSE,sep='\t')
