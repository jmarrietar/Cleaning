setwd("C:/Users/JosePortatil/Dropbox/COURSERA/Getting and Cleaning Data/PROJECT")
#READ INFORMATION
X_test<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
X_train<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")

y_test<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
y_train<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")

subject_train<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
subject_test<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")

activity_labels<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
features<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")

#renaiming 
colnames(y_test)[colnames(y_test) == "V1"] <- "Activity"
colnames(subject_test)[colnames(subject_test) == "V1"] <- "Subject"

colnames(y_train)[colnames(y_train) == "V1"] <- "Activity"
colnames(subject_train)[colnames(subject_train) == "V1"] <- "Subject"


#BINDING DATA FRAMES

A<-cbind(y_test,subject_test)
B<-cbind(y_train,subject_train)
C<- rbind(A,B)
D<- rbind(X_test,X_train) #Mergen training Set and Test set

#Change column names of D from features.txt
#Select the names of the features 
nombres<-features$V2

#Change the name of the columns by this
colnames(D)<-nombres


#Extract the measurement that contain mean or std. 
mean_str <- c(".*mean.*", ".*std.*")
mean_str_header <- unique (grep(paste(mean_str,collapse="|"),features$V2, value=TRUE))

#Extract only this measurements in another data frame 
E<-D[,mean_str_header]

#Add Activities and subject to Data Frame 
str(E)
FG<-cbind(C,E)

#Lo uso para dividir by SUBJECT by ACTIVITY 
library(plyr)
H<-ddply(FG, .(Subject,Activity), numcolwise(mean))

#Remplazar Valores de as actividades
require(car)
H$Activity<-as.character(H$Activity)
H$Activity<-factor(H$Activity)
H$Activity<-with(H,recode(Activity,"'1'='WALKING';
                        '2'='WALKING_UPSTAIRS';
                          '3'='WALKING_DOWNSTAIRS';
                            '4'='SITTING';
                            '5'='STANDING';
                            '6'='LAYING';"))

write.table(H, file = "tidy_data.txt")


