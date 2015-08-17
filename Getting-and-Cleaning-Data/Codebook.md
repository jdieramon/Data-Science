#Code Book
This codebook is based on the data reported in publication [1] and used as raw material for the "Getting and Cleaning Data" 
Course Project. 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones
using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012).
Vitoria-Gasteiz, Spain. Dec 2012

RAW DATA
The data for the project can be download from: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

TIDY DATA
The "run_analysis.R" scrip does the following : (1) Merges the training and the test sets to create one data set. 10299 observations x 561 measurements or variables; (2) Extracts only the measurements on the mean and standard deviation for each measurement. The signals measured as available in the 'features.txt' file. Our criteria was to extract from those signals the first two variables described in the "features_info.txt" file:   mean():Mean Value,   std(): Standard deviation.
There are 17 signals. 8 signals show X, Y, Z directions : 8signals * 3directions * 2variables = 48 measurements.   9 signals * 2 variables = 18 measurements. Total = 48 + 18 = 66 measurements. Data after extraction : 10299 observations x 66 measurements or variables; (3)Uses descriptive activity names to name the activities in the data set. Names are taken from "features.txt" file; (4) Appropriately labels the data set with descriptive variable names. from "activity_labels.txt"; (5) Creates a tidy data set with the average of each variable for each activity and each subject. 180 x 68
