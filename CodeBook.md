
# Source Data

As source data for work was used Human Activity Recognition Using Smartphones Data Set. A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones Here are the data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# R Script

File with R code "run_analysis.R" perform 5 following steps (in accordance assigned task of course work):

Merging the training and the test sets to create one data set.
1. Reading files
  a. Reading trainings tables
  b. Reading testing tables
  c. Reading feature vector
  d. Reading activity labels
2. Assigning column names
3. Merging all data in one set

Extracting only the measurements on the mean and standard deviation for each measurement
1. Reading column names
2. Create vector for defining ID, mean and standard deviation
3. Making nessesary subset from setAllInOne

Using descriptive activity names to name the activities in the data set

Appropriately labeling the data set with descriptive variable names

Creating an independent tidy data set with the average of each variable for each activity and each subject
1. Making tidy data set
2. Writing tidy data set in txt file


# Variables:

1. x_train, y_train, x_test, y_test, sub_train and sub_test contain the data from the downloaded files.

2. x_data, y_data and sub_data merge the previous datasets to further analysis.

3. features contains the correct names for the x_data dataset .

4. merge_train contains cbind of y_train, sub_train and x_train .

5. merge_test contains cbind of y_test, sub_test and x_test.
