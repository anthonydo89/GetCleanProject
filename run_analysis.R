run_analysis <- function() {
  ## working directory starts as my Documents folder
  ## data was saved in Documents/Data Science/Cleaning/Project/UCI HAR Dataset  
  ## setwd('~/Data Science/Cleaning/Project/UCI HAR Dataset/')
  activityLabels<-read.table('activity_labels.txt')
  ##
  ## 1 WALKING
  ## 2 WALKING_UPSTAIRS
  ## 3 WALKING_DOWNSTAIRS
  ## 4 SITTING
  ## 5 STANDING
  ## 6 LAYING
  ##
  features<-read.table('features.txt')
  ## features is a 561 x 2 data frame. one column is only the row number though.
  ## it lists the actual variable names, eg.
  ##
  ## 1 tBodyAcc-mean()-X
  ## ...
  ## 90 tBodyAccJerk-max()-X
  ## ...
  ## 561 angle(Z,gravityMean)
  ##
  ## There are 33 measured variables, and 17 statistics for each (561 = 33 x 17)
  ##
  SubTest<-read.table('test/subject_test.txt')
  ## SubTest is a 2947 x 1 data frame
  ## listing which SUBJECT (from 1 to 30) performed what activity (specified in YTest)
  ## SubTest only has a handful of people (9?) out of the 30
  YTest<-read.table('test/Y_test.txt')
  ## YTest is a 2947 x 1 data frame
  ## listing which ACTIVITY (from 1 to 6) is being performed
  XTest<-read.table('test/X_test.txt')
  ## XTest is a 2947 x 561 data frame
  ## the columns are the VARIABLES being measured. The rows are the subject/activity
  ##
  SubTrain<-read.table('train/subject_train.txt')
  ## train data has 7352 observations
  YTrain<-read.table('train/Y_train.txt')
  XTrain<-read.table('train/X_train.txt')
  
  SubAll<-rbind(SubTest,SubTrain)
  colnames(SubAll)="Subject"
  YAll<-rbind(YTest,YTrain)
  XAll<-rbind(XTest,XTrain)
  ## set column names
  colnames(XAll)<-features[,2]
  ## meanStdPattern<-"mean()|std()"
  colsToDelete<-!grepl("mean()|std()",features[,2])|grepl("meanFreq",features[,2])
  XAllData<-XAll[,!colsToDelete]
  ## XAllData should have 10299 observations of 66 variables =)
  ## Creating descriptive variable names
  descNamesX=sub("tBody","TimeBody",names(XAllData))
  descNamesX=sub("tGravity","TimeGravity",descNamesX)
  descNamesX=sub("fBody","FrequencyBody",descNamesX)
  descNamesX=sub("BodyBody","Body",descNamesX)
  descNamesX=sub("Acc","Acceleration",descNamesX)
  descNamesX=sub("Mag","Magnitude",descNamesX)
  descNamesX=sub("mean","Mean",descNamesX)
  descNamesX=sub("std","StdDev",descNamesX)
  descNamesX=gsub("-|\\()","",descNamesX)
  descNamesX=sub("X","-X-Axis",descNamesX)
  descNamesX=sub("Y","-Y-Axis",descNamesX)
  descNamesX=sub("Z","-Z-Axis",descNamesX)
  names(XAllData)=descNamesX
  ## Updating Activity list with descriptive names
  YLevels<-factor(activityLabels[,2])
  ## have to relevel this, as the automatic order was alphabetical
  YLevels=factor(YLevels,levels(YLevels) [c(4,6,5,2,3,1)])
  YAll$Activity<-YLevels[YAll$V1]
  YAllData<-data.frame(YAll$Activity)
  colnames(YAllData)<-"Activity"
  ## print(colnames(YAllData))
  ## combining everything
  DataSet=cbind(SubAll,YAllData,XAllData)
  ## re-cast as just the mean of each variable, by ID/activity
  library(reshape2)
  DataSetVars=as.character(colnames(DataSet[3:68]))
  DataSetMelt=melt(DataSet,id=c("Subject","Activity"),measure.vars=DataSetVars[1:66])
  ## print(colnames(DataSetMelt))
  DataSetCast=dcast(DataSetMelt,Subject + Activity~variable,mean)
  write.table(DataSetCast,file='TidyDataSet.txt',row.name=FALSE)
}
