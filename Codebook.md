# Code Book

The data set that this code book pertains to is located in the FinalData.txt file of this repository. See the README.md file of this repository for background information on this data set.
The structure of the data set is described in the Data section, its variables are listed in the Variables section, and the transformations that were carried out to obtain the data set based on the source data are presented in the Transformations section.

## Data

The FinalData.txt data file is a text file, containing space-separated values.

The first row contains the names of the variables, which are listed and described in the Variables section, and the following rows contain the values of these variables.

The run_analysis.R script performs the data preparation and then followed by the steps required as described in the course project’s definition.


## Download the dataset
* Dataset downloaded and extracted under the folder called UCI HAR Dataset


## Assign each data to variables
* features <- features.txt : 561 rows, 2 columns 
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
* activities <- activity_labels.txt : 6 rows, 2 columns 
List of activities performed when the corresponding measurements were taken and its codes (labels)
* testSubjects <- test/subject_test.txt : 2947 rows, 1 column 
contains test data of 9/30 volunteer test subjects being observed
* testValues <- test/X_test.txt : 2947 rows, 561 columns 
contains recorded features test data
* testActivity <- test/y_test.txt : 2947 rows, 1 columns 
contains test data of activities’code labels
* trainingSubjects <- test/subject_train.txt : 7352 rows, 1 column 
contains train data of 21/30 volunteer subjects being observed
* trainingValues <- test/X_train.txt : 7352 rows, 561 columns 
contains recorded features train data
* trainingActivity <- test/y_train.txt : 7352 rows, 1 columns 
contains train data of activities’code labels

## Steps
1. Merges the training and the test sets to create one data set
* X (10299 rows, 561 columns) is created by merging trainingValues and testValues using rbind() function
* Y (10299 rows, 1 column) is created by merging trainingActivity and testActivity using rbind() function
* Subject (10299 rows, 1 column) is created by merging trainingSubjects and testSubjects  using rbind() function
* Merged_Data (10299 rows, 563 column) is created by merging Subject, Y and X using cbind() function

2. Extracts only the measurements on the mean and standard deviation for each measurement
* ExtMeanStd (10299 rows, 88 columns) is created by subsetting Merged_Data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

3. Uses descriptive activity names to name the activities in the data set
* Entire numbers in code column of the ExtMeanStd replaced with corresponding activity taken from second column of the activities variable

4. Appropriately labels the data set with descriptive variable names
* code column in ExtMeanStd renamed into activities
* Acc in column’s name replaced by Accelerometer
* Gyro in column’s name replaced by Gyroscope
* BodyBody in column’s name replaced by Body
* Mag in column’s name replaced by Magnitude
* Start with character f in column’s name replaced by Frequency
* Start with character t in column’s name replaced by Time

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
* FinalData (180 rows, 88 columns) is created by sumarizing ExtMeanStd taking the means of each variable for each activity and each subject, after grouped by subject and activity.
* Export FinalData into FinalData.txt file.


