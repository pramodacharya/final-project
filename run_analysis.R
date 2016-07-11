library(dplyr) $ this stores uses packages dplyr and tidyr
library(tidyr)

multiple.grep<-function(pattern, x, ...){ # a function is constructed to perform function grep for different elements at same operation
	greped <- numeric()
	for (i in 1:length(pattern)) {
		result <- grep(pattern[i],x, ...)
    		greped<- c(greped,result)
	} 
	greped
}

multiple.gsub <- function(pattern, replacement, x, ...) { # a function is constructed to substitute multiple elements at same operation
	substituted <- x
	for (i in 1:length(pattern)) {
	substituted <- gsub(pattern[i], replacement[i], substituted, ...)
  	}
  substituted
}

tidy.data <- function(dir){
		setwd(dir)                               # sets "UCI HAR Dataset" as the working directory.

		test <- read.table("test/X_test.txt")    # reads test dataset.
		train <- read.table("train/X_train.txt") # reads traub dataset.
		merged <- rbind(test,train)		     # merges the test and train datasets and makes one signle dataset.

		features <- as.character(data.frame(read.table("features.txt"),stringAsFactor=FALSE)[,2]) #reads the 561 element 'features' vector
		colnames(merged) =  features             # sets the variable names for the merged data according to the features.

		greped1 <- multiple.grep(c("-mean[()]","-std[()]"),colnames(merged)) # to select just the measurement for mean and standard deviation, 
													  # it selects the coolumn numbers whose headers contain mean or std
		merged <- merged[,greped1]  # updates merged datasets by selecting only the measurements with mean and std.
		
					# the following part changes the column names of the merged dataset, where "()" is dropped and "-" is replaced with "_".
		pattern1 <- c( "[-]mean\\(\\)[-]X","[-]mean\\(\\)[-]Y","[-]mean\\(\\)[-]Z","[-]std\\(\\)[-]X","[-]std\\(\\)[-]Y","[-]std\\(\\)[-]Z")
		replacement1 <- c( "_mean_x","_mean_y","_mean_z","_std_x","_std_y","_std_z")
		colnames(merged) <- multiple.gsub(pattern1,replacement1, colnames(merged))

						# the following part reads subject id numbers for test and train datasets and merges to a single character vector.
		subject.test <- as.character(data.frame(read.table("test/subject_test.txt"),stringAsFactor=FALSE)[,1]) 
		subject.train <- as.character(data.frame(read.table("train/subject_train.txt"),stringAsFactor=FALSE)[,1])
		subject <- as.numeric(c(subject.test,subject.train))
		
						# the following part reads activities for test and train datasets and merges to a single vector
		activity.test <- as.character(data.frame(read.table("test/y_test.txt"),stringAsFactor=FALSE)[,1])
		activity.train <- as.character(data.frame(read.table("train/y_train.txt"),stringAsFactor=FALSE)[,1])
		activity <- c(activity.test,activity.train)

						# the following part labels the activities appropriateley by changing from numbers to word.
		pattern2 <- as.character(c(1,2,3,4,5,6))
		replacement2 <- as.character(c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
		activity <- multiple.gsub(pattern2,replacement2,activity)

		merged <- cbind(Subject.ID = subject,Activity = activity, merged) # updates merged dataset by adding two columns to describe 
												   # subject and their activity for each observation.

			#The above updated dataset is the answer for the step 4 for the project which has 68 columns, including subject id, activity and the variables.
						

					# The rest of the script is to make a tidy dataset as described in step 5.
					
					# the following part selects teh column for indepedent variables. all the features in frequency space can by calculated 
					# any time and similarly Jerks and the magnitude can be calculated any time with three x,y and z values,
					# so we drop all these columns with magnitudes, Jerks, frequency space features.

				
		greped2 <- multiple.grep(c("Subject","Activity","tBodyAcc_mean","tBodyAcc_std","tBodyGyro_mean",
								"tBodyGyro_std","tGravityAcc_mean","tGravityAcc_std"), colnames(merged))

		tidy <- merged[,greped2]    # selects the independent columns from merged dataset
		pattern3 <- as.character(c("tB","tG","mean","std"))
		replacement3 <- as.character(c("B","G","Mean","STD"))
		colnames(tidy) <- multiple.gsub(pattern3,replacement3,colnames(tidy)) # changes the column names of tidy set

		tidy <- gather(tidy,variables,Values,BodyAcc_Mean_x:GravityAcc_STD_z) # gathers columns with independent features

		tidy <- separate(tidy,variables,c("Variables","Statistics","Axes")) # separates into different columns, eg. BodyAcc_mean_x changes into three columns
													  # with Varialbes = Bodyacc, Statistics = mean, and Axes = x

		tidy <- select(data.frame(tidy,Average = ave(tidy$Values,tidy[,1:5])),-Values) # calculates average for each subject, each activity
															 # and each variable along each axis.
		
		tidy <- data.frame(unique(tidy)) # removes the duplicate rows
		tidy <- spread(tidy,Statistics,Average) # splits the Statistics column into Mean and Standard deviation columns.
					# The above dataset is the tidy data set which has average for each subject, for each activity and for each variable.
					# It has 6 columns, Subject ID (from 1:30), Activity(from six activities), Variables (BodyAcc, GravityAcc, BodyGyro), 
					# Axes ( along x, y, z) and average for Mean and Standard deviation.
					# The dataset has 1620 unique rows. 
arrange(tidy,Subject.ID,Activity,Variables,Axes)
}
