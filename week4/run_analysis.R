#########  Project Week 4 Assignmment ##############

## reading X_train dataset into a data frame
fileXtrain <- "train/X_train.txt"
xTrain <- fread(fileXtrain, header=FALSE)


## reading X_test dataset into a data frame
fileXtest <- "test/X_test.txt"
xTest <- fread(fileXtest, header=FALSE)

##  nrow(xTrain)   ## just checking the total row
##  nrow(xTest)   ## just checking the total row

## reading y_train dataset into a data frame
fileYtrain <- "train/y_train.txt"
yTrain <- fread(fileYtrain, header=FALSE)

## merging y_train dataset and X_train dataset
yxTrain <- cbind(yTrain, xTrain)

## reading y_test dataset into a data frame
fileYtest <- "test/y_test.txt"
yTest <- fread(fileYtest, header=FALSE)

## merging y_test dataset and X_test dataset
yxTest <- cbind(yTest, xTest)

## reading subject_train column into a dataframe
fileSubjectTrain <- "train/subject_train.txt"
subjectTrain <- fread(fileSubjectTrain, header=FALSE)

## merging the subject_train column to train dataset
trainDF <- cbind(subjectTrain, yxTrain)

## reading subject_test column into a dataframe
fileSubjectTest <- "test/subject_test.txt"
subjectTest <- fread(fileSubjectTest, header=FALSE)

## merging the subject_test column to test dataset
testDF <- cbind(subjectTest, yxTest)


### Naming columns of train dataset and test dataset --- before merging them
colnames(trainDF) <- c("subjectID", "activityID", colnames(xTrain))
colnames(testDF) <- c("subjectID", "activityID", colnames(xTest))

### merging train dataset & test dataset
mergedDataset <- rbind(trainDF, testDF)

### calculating mean of all the features row wise (subjectID & activityID not included)
measureMean <- rowMeans(mergedDataset[,-c(1,2)])

### calculating standard deviation of all the features row wise
measureStdDev <- apply(mergedDataset[,-c(1,2)], 1, sd)  ## here 1 corresponds to Row

### combining the mean & standard deviation (calculated in previous step) to the dataset
mergedDataset <- cbind(mergedDataset[,c(1,2)], measureMean, measureStdDev, mergedDataset[,-c(1,2)])


### reading activity names corresponding to each activity ID from activity_labels files
fileActivityName <- "activity_labels.txt"
activityDF <- fread(fileActivityName, header=FALSE)

## replacing activity ID with corresponding activity name in the dataset
for(i in 1:6)
{
    mergedDataset$activityID[mergedDataset$activityID==i] <- activityDF$V2[i]
}

## naming the all the feature names from feature.txt file
fileFeatureName <- "features.txt"
featureDF <- fread(fileFeatureName, header=FALSE)

## replacing the system assigned column name of each feature with its actual name (as per the feature.txt file)
colnames(mergedDataset) <- c("subjectID", "activity", "meanOfMeasurement", "StdDevOfMeasurement", featureDF$V2)

## writing dataframe to csv file
file2write <- "projectOutput.csv"
write.table(mergedDataset, file2write, row.names = FALSE, sep=",")




