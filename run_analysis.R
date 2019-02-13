
# Purpose
#   Using the data collected from the accelerometers from the Samsung Galaxy S 
#   smartphone, work with the data and make a tidy data set, outputting the
#   resulting tidy data to a file named "Final_data.txt".
#   See README.md for details.


# Loading required packages
library(dplyr)


# Download the dataset

# Download zip file containing data if it hasn't already been downloaded
zUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zFile <- "UCI HAR Dataset.zip"

if (!file.exists(zFile)) {
  download.file(zUrl, zFile, mode = "wb")
}

# Unzip zip file containing data if data directory doesn't already exist
data <- "UCI HAR Dataset"
if (!file.exists(data)) {
  unzip(zFile)
}



# Assigning all data frames

# Read training data
tSub <- read.table(file.path(data, "train", "subject_train.txt"))
tVal <- read.table(file.path(data, "train", "X_train.txt"))
tAct <- read.table(file.path(data, "train", "y_train.txt"))

# Read test data
testSub <- read.table(file.path(data, "test", "subject_test.txt"))
testVal<- read.table(file.path(data, "test", "X_test.txt"))
testAct <- read.table(file.path(data, "test", "y_test.txt"))

# Read features, don't convert text labels to factors
feat <- read.table(file.path(data, "features.txt"), as.is = TRUE)


# Read activity labels
activities <- read.table(file.path(data, "activity_labels.txt"))
colnames(activities) <- c("activityId", "activityLabel")





# STEP 1 - Merge the training and the test sets to create one data set

MergedData <- rbind(
  cbind(tSub, tVal, tAct),
  cbind(testSub, testVal, testAct)
)


# Assign column names
colnames(MergedData) <- c("subject", feat[, 2], "activity")




# Step 2 - Extract only the measurements on the mean and standard deviation
#          for each measurement

# Determine columns of data set to keep based on column name
Keepcolumns <- grepl("subject|activity|mean|std", colnames(MergedData ))

# Keep data in these columns only
MergedData  <- MergedData[, Keepcolumns]




# Step 3 - Use descriptive activity names to name the activities in the data set


# Replace activity values with named factor levels
MergedData$activity <- factor(MergedData$activity, 
                                 levels = activities[, 1], labels = activities[, 2])




# Step 4 - Appropriately label the data set with descriptive variable names

# Get column names
MergedDataCols <- colnames(MergedData)

# Expand abbreviations and clean up names
MergedDataCols <- gsub("^f", "frequencyDomain", MergedDataCols)
MergedDataCols <- gsub("^t", "timeDomain", MergedDataCols)
MergedDataCols <- gsub("Acc", "Accelerometer", MergedDataCols)
MergedDataCols <- gsub("Gyro", "Gyroscope", MergedDataCols)
MergedDataCols <- gsub("Mag", "Magnitude", MergedDataCols)
MergedDataCols <- gsub("Freq", "Frequency", MergedDataCols)
MergedDataCols <- gsub("mean", "Mean", MergedDataCols)
MergedDataCols <- gsub("std", "StandardDeviation", MergedDataCols)
MergedDataCols <- gsub("BodyBody", "Body", MergedDataCols)

# Use new labels as column names
colnames(MergedData) <- MergedDataCols





# Step 5 - Create a second, independent tidy set with the average of each variable
#          for each activity and each subject


MergedDataMeans <- MergedData %>% 
  group_by(subject, activity) %>%
  summarise_each(funs(mean))

# Output to file "Final_data.txt"
write.table(MergedDataMeans, "Final_data.txt", row.names = FALSE, 
            quote = FALSE)





# Final check
str(MergedDataMeans)

# Final look at data
MergedDataMeans