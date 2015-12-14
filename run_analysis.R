
trainX <- read.table('train/X_train.txt', sep =  "", header = FALSE, colClasses = "numeric")
trainY <- read.table('train/Y_train.txt', sep =  "", header = FALSE, colClasses = "numeric")

testX <- read.table('test/X_test.txt', sep =  "", header = FALSE, colClasses = "numeric")
testY <- read.table('test/Y_test.txt', sep =  "", header = FALSE, colClasses = "numeric")

trainSubject <- read.table('train/subject_train.txt', sep =  "", header = FALSE, colClasses = "numeric")
testSubject <- read.table('test/subject_test.txt', sep =  "", header = FALSE, colClasses = "numeric")

# 1. Merges the training and the test sets to create one data set.
allX <- rbind(trainX, testX)
allY <- rbind(trainY, testY)
allSubject <- rbind(trainSubject, testSubject)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
info <- read.table('features.txt', sep = "", header=FALSE)
selectedX <- allX[,grep("mean|std", info[,2])]

# 3. Uses descriptive activity names to name the activities in the data set
act_info <- read.table('activity_labels.txt', stringsAsFactors=FALSE)
allY_desp <- act_info[allY$V1,2]

# 4. Appropriately labels the data set with descriptive variable names. 
names(selectedX) <- gsub("\\(\\)", "", info[grep("mean|std", info[,2]), 2])

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidydata <- aggregate(selectedX, by=list(subject = allSubject$V1, label = allY_desp), mean)

write.table(format(tidydata, scientific=T), "tidy.txt", row.names=F, col.names=F, quote=2)