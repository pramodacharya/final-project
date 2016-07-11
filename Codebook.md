The initial data contain 561 features. Which contains the following signals
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

and the following set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

The tidy data set made from the script contains only mean value and Standard deviation. The script drops the dependent variables like total magnitude, 
jerk, and all the frequency space variables. 

The final tidy data set contains 6 columns 

Subject id <- it has value from 1 to 30 as 30 different people participated in teh experiment.

Activity <- 6 activities were performed by each person which are  WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

Variables <- BodyAcc, GravityAcc and Body Gyro signals

Axes <- three axes x, y and z along whcih the signals were measured for each variable

Mean <- the average for the mean value of each variable for each activity and each subject

Std <- the average for the standard deviation value of each variable for each activity and each subject

The final tidy dataset has 1620 rows and 6 columns.




