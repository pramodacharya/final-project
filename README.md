The script run_analysis.R converts the raw datasets in folder "UCI HAR Dataset" to a tidy data.

The script requires packages dplyr and tidyr.

The script contains three new functions. 
The function "multiple.grep" is contructed to perform grep function for multiple elements.
The function "multiple.gsub" a function is contructed to substitute multiple elements.

The function "tidy.data" takes dir (dir = filepath for the folder "UCI HAR Dataset") as an argument, and then gives the tidy data in following steps.{
      1) sets the folder "UCI HAR Dataset" as the working directory
      2) loads test sets and training sets as dataframe and merges to a single data set with rbind() function
      3) reads the features from the "features.txt" file and set the features as the column header of teh merged dataset
      4) finds the column numbers for measurements on the mean and standard deviation for each measurement, by using multiple.grep() function, constructed at the begining of the script
      5) updates the merged data set by extracting the columns with mean and std in their header, using the column numbers found in step 4
      6) changes the column names of the merged dataset, by dropping "()" is dropped and replacing "-" with "_" using the function multiple.gsub()
      7) reads and loads the subject id number and the activity for each observation
      8) changes the activity levels from numbers to descriptive names using multiple.gsub
      9) updates the merged dataset by adding two columns for subject id number and activity for corresponding observations.
         The dataset found in step 9 is a messy dataset, which is the answer for the step 4 for the project. 
         The data set has 68 columns, 
         	subject id
         	activity and 
         	mean and standard deviations for following 33 features ( XYZ means along all three axes) 
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
 	10) The rest of the script is to make a tidy dataset as described in step 5 of the project.
 	11) It selects the the column for indepedent variables. All the features in frequency space can by calculated at
	  any time and similarly Jerks and the total magnitude can be calculated any time with three values along x, y and directions.
	12) The script drops all those columns with magnitudes, Jerks, frequency space features.
	13) uses multiple.grep() function and finds the column number for independent variables subject id, activity, mean and standard deviation of measurements along three direction (x, y and z) of  body acceleration, gravity acceleration and body gyroscope signals
	14) creates a new data set named tidy, by extracting the columns for indepedent variables from messy dataset named merged.
	15) gathers all the columns except subject id and activity
	16) separates the data set tidy into different columns based on variable type (BodyACc, BodyGyro, gravityAcc), statistic type (mean, std) and axis (x,y,z). 
	17) calculates average for both mean and standard deviation for each subject, for each activity, for each variable and along each axis.
	18) finally arranges the tidy data set  in ascending order of Subject.ID,Activity,Variables,Axes respectively.
	}
