### Introduction

Run_analysis.R is a script created for the Getting and Cleaning Data course 
project. The course project works with data from the Human Activity Recognition 
Using Smartphones Dataset Version 1.0 produced by Jorge L. Reyes-Ortiz, 
Davide Anguita, Alessandro Ghio, Luca Oneto for Smartlab. The steps the script 
follows are:
1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation 
   for each measurement. 
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names. 
5) From the data set in step 4, creates a second, independent tidy data set 
   with the average of each variable for each activity and each subject.

### Reading data
To understand what each of the variables is in the provided data set, the script
references features.txt, which provides a list describing what each column 
represents in the both the test and train data sets.

### Limit the data set to only measurements of standard deviation and mean
The grep function is used to select only the columns containing the string 
"mean" or "std" 

### Create activity descriptions for the data
The included data in the test and train sets only includes an activity number 
rather than an actitivty description. By referencing activity_labels.txt, which 
provides a references table aligning the activity numbers with their 
descriptions run.analysis is able to add a column of activity descriptions to 
the data. The plyr package is used to join the reference activity labels with 
the test and train data sets. 

### Bind the subject number column and activity description column to data
The subject and the activty generating each of the measurements are provided 
as a separate txt files. The data can be merged together using cbind assuming 
the observations correctly ordered. This step creates the labeled test and train
data sets.

### Merge the test and train data sets
The labeled data sets are merged together adding to the number of observed
measurements for each subject and activity

### Data cleaning
The merged data set of "test_train_merged" contains the unnecessary column of 
activity numbers. The column names of the merged data also contain 
invalid characters ()- that were replaced with dots. These characted are 
removed by the script. The word body is also repeated in the column names and 
is removed.

### Clean data set is aggregated
The clean data set has multiple measurements of the same activity for each 
subject. The mean of all measurments is created by subject and activity using 
aggregate.

### Data is transformed to a clean long form data set
Using melt the data is transformed from a data frame with 81 variables to 4
by migrating each of the columns of measurements into the column "measurement 
description". The mean for each type of measurement is provided for each subject 
and activity.

### Data set is exported for upload to Coursera submission
Final data is uploaded as txt. 





