library(plyr)

# Downloading dataset
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip dataSet to /data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")


# Merging the training and the test sets to create one data set:

## Reading files

### Reading trainings tables:
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
sub_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

### Reading testing tables:
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
sub_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

### Reading feature vector:
features <- read.table('./data/UCI HAR Dataset/features.txt')

### Reading activity labels:
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

## Assigning column names:
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(sub_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(sub_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

## Merging all data in one set:
merge_train <- cbind(y_train, sub_train, x_train)
merge_test <- cbind(y_test, sub_test, x_test)
setAllInOne <- rbind(merge_train, merge_test)

# Extracting only the measurements on the mean and standard deviation for each measurement

## Reading column names:
colNames <- colnames(setAllInOne)

## Create vector for defining ID, mean and standard deviation:
mean_and_std <- (grepl("activityId" , colNames) | 
                   grepl("subjectId" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames) 
)

## Making nessesary subset from setAllInOne:
setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]

# Using descriptive activity names to name the activities in the data set:
setWithActivityNames <- merge(setForMeanAndStd, activityLabels,
                              by='activityId',
                              all.x=TRUE)

# Appropriately labeling the data set with descriptive variable names.
# Already done in above steps .

#  Creating a second, independent tidy data set with the average of each variable for each activity and each subject:

## Making tidy data set 
tidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
tidySet <- tidySet[order(tidySet$subjectId, tidySet$activityId),]

## Writing  tidy data set in txt file
write.table(tidySet, "tidySet.txt", row.name=FALSE)
