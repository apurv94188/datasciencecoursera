#########  Project Week 4 Assignmment ##############
## for train dataset --- reading X_train dataset into a dataframe
fileXtrain <- "/home/apurv/Desktop/Course3/Week4/data/UCI HAR Dataset/train/X_train.txt"
xTrain <- fread(fileXtrain, header=FALSE)

## for test dataset --- reading X_test dataset into a dataframe
fileXtest <- "/home/apurv/Desktop/Course3/Week4/data/UCI HAR Dataset/test/X_test.txt"
xTest <- fread(fileXtest, header=FALSE)

## reading y_train (activity) dataset into a dataframe
fileYtrain <- "/home/apurv/Desktop/Course3/Week4/data/UCI HAR Dataset/train/y_train.txt"
yTrain <- fread(fileYtrain, header=FALSE)

## combining the yTrain & xTrain dataframe
yxTrain <- cbind(yTrain, xTrain)

## --- reading y_test (activity) dataset into a dataframe
fileYtest <- "/home/apurv/Desktop/Course3/Week4/data/UCI HAR Dataset/test/y_test.txt"
yTest <- fread(fileYtest, header=FALSE)

## combining the yTest & xTest dataframe
yxTest <- cbind(yTest, xTest)

## reading subject_train (subject/volunteer) file into a datframe
fileSubjectTrain <- "/home/apurv/Desktop/Course3/Week4/data/UCI HAR Dataset/train/subject_train.txt"
subjectTrain <- fread(fileSubjectTrain, header=FALSE)

## combining subjectTrain & yxTrain
trainDF <- cbind(subjectTrain, yxTrain)

## reading subject_test (subject/volunteer) file into a datframe
fileSubjectTest <- "/home/apurv/Desktop/Course3/Week4/data/UCI HAR Dataset/test/subject_test.txt"
subjectTest <- fread(fileSubjectTest, header=FALSE)

## combining subjectTest & yxTest
testDF <- cbind(subjectTest, yxTest)

### Naming first 2 columns and keeping rest of the colum names unchanged
colnames(trainDF) <- c("subjectID", "activityID", colnames(xTrain))
colnames(testDF) <- c("subjectID", "activityID", colnames(xTest))

# merginig of train & test data
mergedDataset <- rbind(trainDF, testDF)
#head(mergedDataset,2)

## reading feature file which contains names of columns of each measurement
library(data.table)
fileNm <- "/home/apurv/Desktop/Course3/Week4/data/UCI HAR Dataset/features.txt"
featuresDF <- fread(fileNm, header=FALSE)


## findng out all column index which has "mean()" or "std()" in their name --- 
## as they would represent mean or std columns
colIndexMeanStd <- grep("(mean|std)(.*)\\(\\)", featuresDF$V2)
featuresMeanSD <- featuresDF[colIndexMeanStd, 2]

## shifting column index so as to include subjectID and activity column as well
colIndexMeanStd <- colIndexMeanStd+2
colIndexMeanStd <- c(1,2, colIndexMeanStd)

## taking subjectId, activityID columns and columns representing mean or standard deviation
mergedDataset <- mergedDataset[,colIndexMeanStd, with=FALSE]


## cleaning variables which are not required (to clearn up the memory)
rm(xTrain)
rm(yTrain)
rm(xTest)
rm(yTest)
rm(yxTrain)
rm(yxTest)
rm(trainDF)
rm(testDF)
rm(subjectTrain)
rm(subjectTest)

## replacing activityID values with their respective activity name in activityID column
fileActivityName <- "/home/apurv/Desktop/Course3/Week4/data/UCI HAR Dataset/activity_labels.txt"
activityDF <- fread(fileActivityName, header=FALSE)
## naming the activity
for(i in 1:6)
{
    mergedDataset$activityID[mergedDataset$activityID==i] <- activityDF$V2[i]
}

##  renaming mean and sd columns so they can be easily perceived/understood
featuresMeanSD$V2 <- gsub("\\((.*)\\)", "", featuresMeanSD$V2)
colnames(mergedDataset) <- c("subjectID", "activity", featuresMeanSD$V2)

## cleaning variables which are not required (to clearn up the memory)
rm(colIndexMeanStd)
rm(activityDF)
rm(featuresDF)
rm(featuresMeanSD)

# head(mergedDataset,10)

################### 5th Step   ###############################
library(plyr)

## function that would calculate average of measurement columns
fnColAvg <- function(df) {
    return(colMeans(df[,-c(1,2)], na.rm=TRUE))
}

## making subjectID and activity column factors column
mergedDataset$subjectID <- factor(mergedDataset$subjectID)
mergedDataset$activity <- factor(mergedDataset$activity)

avgDataset <- ddply(mergedDataset, c("subjectID", "activity"), fnColAvg)
#avgDataset

## writing the final dataset to a text file
outputFileName <- "/home/apurv/Desktop/Course3/Week4/data/UCI HAR Dataset/projectOutput.txt"
write.table(avgDataset, outputFileName, row.names = FALSE)
