library(utils)

# We read the data
testData <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
testActivity <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
trainData <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
trainActivity <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)

# Next step we use the descriptive activity names to the name of activities in data set.
activities <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE,colClasses="character")
testActivity$V1 <- factor(testData_act$V1,levels=activities$V1,labels=activities$V2)
trainActivity$V1 <- factor(trainData_act$V1,levels=activities$V1,labels=activities$V2)

# Rename the labels of the data variables according with the descriptive activity
features <- read.table("./UCI HAR Dataset/features.txt",header=FALSE,colClasses="character")
colnames(testData)<-features$V2
colnames(testActivity)<-c("Activity")
colnames(testSubject)<-c("Subject")
colnames(trainActivity)<-c("Activity")
colnames(trainSubject)<-c("Subject")
colnames(trainData)<-features$V2


# Merge the test and training using the rbind function (in this case function merge was helpless)
testData<-cbind(testData,testActivity)
testData<-cbind(testData,testSubject)
trainData<-cbind(trainData,trainActivity)
trainData<-cbind(trainData,trainSubject)
mergeData<-rbind(testData,trainData)
write.table(mergeData,file="./mergeData.txt")

# Subsets using sampply according with specifications
mergeDataMean<-sapply(mergeData,mean,na.rm=TRUE)
mergeDataStd<-sapply(mergeData,sd,na.rm=TRUE)
write.table(cbind(mergeDataMean,mergeDataStd),file="./tidyData.txt")


# Creates another data set with the means per activity.
DT <- data.table(mergeData)
tidyData2<-DT[,lapply(.SD,mean),by="Activity,Subject"]

