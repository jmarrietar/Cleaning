## Project Getting and cleaning Data 

First step is Read the data and save them in data frames, X_test,Xtrain,y_test, y_train, subject_train,subject_test, activity labels, features. 

Next step is change the column names of y_test and y_train to Activity. 
- Change name column in subject_test  and in subject_train to Subject. 

Column bind y_test and subject_test in one ->A
Column bind y_train and subject_train in one ->B
Row bind A and B in C
Row bind X_test and X_train in one ->D (#Mergen training Set and Test set)

Change column names of D from features.txt
Select the names of the features 
Extract the measurement that contain mean or std. 

Extract only this measurements in another data frame  named E .
Add Activities and subject to Data Frame Column bind C and E ->FG

Appy ddply to FG to  divide by subject by Activity
Finally. 
Replace names of activities 
===================
