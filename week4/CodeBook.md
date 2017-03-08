Introduction

The 'run_analysis.R' code performs all the steps mentioned in the objective of the project.

Variables List:

xTrain is the dataframe training data -- file X_train.txt
yTrain is the dataframe training labels -- file y_train.txt

yxTrain is the dataframe (column combination of xTrain & yTrain)

xTest is the test data -- file X_test.txt
yTest is the test labels -- file y_test.txt

yxTest is the dataframe (column combination of xTest & yTest)

subjectTrain is the dataframe --- subject_train (subject/volunteer) file into a datframe
subjectTest is the dataframe --- subject_test (subject/volunteer) file into a datframe

trainDF is the dataframe -- column combination of subjectTrain & yxTrain
testDF is the dataframe -- column combination of subjectTest & yxTest

mergedDataset is the dataframe -- row combination of trainDF & testDF

then activityID values are replaced by their corresponding activity name

featuresDF is the datframe which has all the measurement column names
mean & standard deviation related columns are extracted from this dataframe
and merged datset is also shortened to just mean & standard deviation columns.


Code Explained

1. the training & testing data are read into dataframe...
2. activity data is also added to the training & testing data (from y_train & y_test files)
3. subject data is also added to the training & testing data (from subject_train & subject_test files)
4. both test & train data are merged (row merge)
5. columns names of each measurement is read from features.txt then only mean & standard deviation 
related columns are kept along with activity & subjectID column... rest all columns are discarded
6. activityID replaced by corresponding activity name
7. the names of measurement columns are also read from feature files
8. The average of each measurement column is calculated per activity per subject
