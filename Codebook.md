# Code Book

The data set that this code book pertains to is located in the Final_data.txt file of this repository. See the README.md file of this repository for background information on this data set.
The structure of the data set is described in the Data section, its variables are listed in the Variables section, and the transformations that were carried out to obtain the data set based on the source data are presented in the Transformations section.

## Data

The Final_data.txt data file is a text file, containing space-separated values.

The first row contains the names of the variables, which are listed and described in the Variables section, and the following rows contain the values of these variables.

The run_analysis.R script performs the data preparation and then followed by the steps required as described in the course project’s definition.


## Download the dataset
* Dataset downloaded and extracted under the folder called UCI HAR Dataset


## Assign each data to variables
* feat <- features.txt : 561 rows, 2 columns 
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
* activities <- activity_labels.txt : 6 rows, 2 columns 
List of activities performed when the corresponding measurements were taken and its codes (labels)
* testSub<- test/subject_test.txt : 2947 rows, 1 column 
contains test data of 9/30 volunteer test subjects being observed
* testVal <- test/X_test.txt : 2947 rows, 561 columns 
contains recorded features test data
* testAct <- test/y_test.txt : 2947 rows, 1 columns 
contains test data of activities’code labels
* tSub <- test/subject_train.txt : 7352 rows, 1 column 
contains train data of 21/30 volunteer subjects being observed
* tVal <- test/X_train.txt : 7352 rows, 561 columns 
contains recorded features train data
* tAct<- test/y_train.txt : 7352 rows, 1 columns 
contains train data of activities’code labels

## Steps
1. Merges the training and the test sets to create one data set

* MergedData (10299 rows, 563 column) is created by using the rbind() to cbind() both tSub, tVal, tAct and tAct and testSub, testVal, testAct.


2. Extracts only the measurements on the mean and standard deviation for each measurement
* Keepcolumns (10299 rows, 88 columns) is created by subsetting Merged_Data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement
* Keep data in these columns only: MergedData  <- MergedData[, Keepcolumns]
3. Uses descriptive activity names to name the activities in the data set
* Entire numbers in code column of the MergedData replaced with corresponding activity taken from second column of the activities variable

4. Appropriately labels the data set with descriptive variable names
* code column in MergedData renamed into activities

* Start with character f in column’s name replaced by frequencyDomain
* Start with character t in column’s name replaced by timeDomain
* Acc in column’s name replaced by Accelerometer
* Gyro in column’s name replaced by Gyroscope
* Mag in column’s name replaced by Magnitude
* Freq in column's name replaced by Frequency
* mean in column's name replaced by Mean
* std in column's name replaced by StandardDeviation
* BodyBody in column’s name replaced by Body

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
* Final_data (180 rows, 88 columns) is created by sumarizing ExtMeanStd taking the means of each variable for each activity and each subject, after grouped by subject and activity.
* Export FinalData into Final_data.txt file.

*Do a final check and look at final data.

