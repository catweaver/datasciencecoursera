# This script processes data from the Human Activity Recognition Using Smartphones 
# Dataset Version 1.0 produced by Jorge L. Reyes-Ortiz, Davide Anguita, 
# Alessandro Ghio, Luca Oneto for Smartlab. The steps the script follows are:
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation 
#    for each measurement. 
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names. 
# 5) From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

# Download data
fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,destfile="./wearbles.ZIP", method="curl")
unzip("wearbles.ZIP")
setwd("UCI HAR Dataset")
# Read in data and create column names based on the accompanying readme file
activitylabels<-read.table("activity_labels.txt",col.names=c("Activity_Number","Activity_Name"))
features<-read.table("features.txt")
testlabels<-read.table("./test/y_test.txt", col.names=c("Activity_Number"))
testsubject<-read.table("./test/subject_test.txt", col.names=c("Subject_Number"))
trainlabels<-read.table("./train/y_train.txt", col.names=c("Activity_Number"))
trainsubject<-read.table("./train/subject_train.txt", col.names=c("Subject_Number"))

# Rename the columns in the test and train data set using the variable 
# translation from features.txt
testdata<-read.table("./test/X_test.txt", col.names=features[,2])
traindata<-read.table("./train/X_train.txt", col.names=features[,2])

# Subset the test data to only include columns with mean or std in the name
meanstdtestdata<-testdata[,c(grep("mean|std",colnames(testdata)))]
meanstdtraindata<-traindata[,c(grep("mean|std",colnames(traindata)))]

# Create a table matching the activity descriptions from the activity_labels.txt 
# file with the numerical activity data codes that are provided in test data 
# row labels (y_test_.txt) by joining the two tables on the activity number
library(plyr)
test_labels_with_names<-join(testlabels,activitylabels)
train_labels_with_names<-join(trainlabels,activitylabels)

# Bind the activity labels column (describes which type of activity generates 
# the corresponding data contained in each row of the test data) and subject 
# number with the test data set 

labeledtestdata<-cbind(test_labels_with_names, testsubject, meanstdtestdata)
labeledtraindata<-cbind(train_labels_with_names, trainsubject, meanstdtraindata)

# Merge the data sets together to inlcude both train and test observations for 
# each feature
test_train_merged<-merge(labeledtestdata, labeledtraindata, all=TRUE)

# Drop activity number variable (no longer needed because we have activity_name)
test_train_variables<-names(test_train_merged) %in% c("Activity_Number")
test_train_merged<-test_train_merged[!test_train_variables]

# Eliminate "." from variable names 
names(test_train_merged) <- gsub("[.]", "", names(test_train_merged))
# Eliminate repeated word Body from variables having "BodyBody" in their name
names(test_train_merged) <- gsub("BodyBody", "Body", names(test_train_merged))

# Create second data set with the mean of measurements for each subject
# & actvity combination 

# Create list of independent variables that should be aggregated 
fields_to_aggregate<-list(
Subject_Number=test_train_merged$Subject_Number,
Activity_Name=test_train_merged$Activity_Name
)

# Aggregate the data set to have a single observation for each unique 
# combination of the variables listed in "fields_to_aggregate" by averaging 
# obseravtions for all other dependent variables using the mean function
mean_test_train<-aggregate(test_train_merged[,3:81],fields_to_aggregate,mean)

# Transform the data to long form with a single variable specifying the type of 
# measurement
melted_data<-melt(mean_test_train, id=c("Activity_Name","Subject_Number"))
head(melted_data)
names(melted_data)<-c("activity_name","subject_number",
                      "measurement_description","mean")
# Export final data set as a txt file for upload using write.table function 
setwd("..")
write.table(melted_data, "./final_test_train_data.txt",row.names=FALSE)
