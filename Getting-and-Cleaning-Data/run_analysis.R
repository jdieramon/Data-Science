library("dplyr")

#Getting the data from the Web
fileUrl  <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, "./dataarchive.zip", method = "curl")

#1. Load the Training set
setwd("./UCI HAR Dataset/train")
datTrain  <- read.table("X_train.txt")
datTrain  <- tbl_df(datTrain)
dim(datTrain) #7352 meassurements on 561 features

#2. Load the Test set
setwd("../test")
datTest  <- read.table("X_test.txt")
datTest  <- tbl_df(datTest)
dim(datTest) #2947 meassurements on 561 features

#3. Load features
setwd("../")
feat  <- read.table("features.txt")
dim(feat)

#4. Merges the training and the test sets to create one data set.
data  <- rbind(datTest,datTrain)
dim(data)

#5.Extracts only the measurements on the mean and standard deviation for each measurement
#Index with features with :  mean(), sd()
ind  <- c(1:6,41:46, 81:86,121:126,161:166,201:202,214:215,227:228, 240:241, 253:254, 266:271, 345:350,424:429,
          503:504, 516:517, 529:530, 542:543)
data  <- data[ind]
dim(data)

#5. Double-Check if columns in Test and Train sets are in the same order
colnames(datTest) == colnames(datTrain)

#6. Add info on subjects
#6a Training set
setwd("./train")
subjectTrain  <- read.table("subject_train.txt")
dim(subjectTrain)
#6b Test set
setwd("../test")
subjectTest  <- read.table("subject_test.txt")
dim(subjectTrain)
#6c Merge both vectors
subjects  <- c(subjectTrain$V1,subjectTest$V1)
length(subjects)

#7. Descriptive activities
#7a Training set
setwd("../train")
labelsTrain  <- read.table("y_train.txt")
#7b Test set
setwd("../test")
labelsTest  <- read.table("y_test.txt")
#7c Merge vectors
labels  <- c(labelsTrain$V1, labelsTest$V1)

#8 Merges info on subjects + labels to the data set
data  <- cbind(subjects,labels,data)

#9. Add descriptive name to the activities in the data set (from activity_labels.txt)
data  <- within(data, {
        activity = ifelse(data3$labels==5,"STANDING",
                ifelse(data3$labels==6, "LAYING",
                       ifelse(data3$labels==4, "SITTING",
                              ifelse(data3$labels==3, "WALKING_DOWN",
                                     ifelse(data3$labels==2, "WALKING_UP",
                                            ifelse(data3$labels==1, "WALKING",0))))))
})

fun  <- group_by(data,subjects,activity)
pack  <- summarise(fun, mean(V1),mean(V2),mean(V3),mean(V4),mean(V5),mean(V6), mean(V41),mean(V42),mean(V43),mean(V44),
                  mean(V45),mean(V46), mean(V81),mean(V82),mean(V83), mean(V84), mean(V85),mean(V86), mean(V121), mean(V122),
                  mean(V123), mean(V124), mean(V125),mean(V126),mean(V161), mean(V162),mean(V163),mean(V164), mean(V165),
                  mean(V166),mean(V201),mean(V202),mean(V214),mean(V215), mean(V227),mean(V228), mean(V240),mean(V241),
                  mean(V253), mean(V254), mean(V266),mean(V267), mean(V268), mean(V269),mean(V270),mean(V271),mean(V345),
                  mean(V346),mean(V347),mean(V348),mean(V349), mean(V350), mean(V424), mean(V425),mean(V426),mean(V427),
                  mean(V428),mean(V429), mean(V503),mean(V504), mean(V516),mean(V517), mean(V529), mean(V530), mean(V542),
                  mean(V543))

#10. Assign names to columns
colnames(pack)[c(3:68)] = as.character(features$V2[ind])

#11. Create the tidy file
write.table(pack, file= "tidy data.txt", row.names = FALSE)
