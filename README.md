The function run_analysis takes in the acclerometer and gyroscope data taken from a Samsung Galaxy II phone by 30 different subjects performing 6 different activities multiple times. Two data sets were gathered, from a "test" group and a "train" group. All the test and train observation data was combined.


STUDY DESIGN
Imported the following raw data files:

'activity_labels.txt': contains the activity labels

'features.txt': contains a 561-feature vector with time and frequency domain variables (17 statistics for 33 different measurements)

'subject_test.txt' and 'subject_train.txt': list which SUBJECT (numbered 1 through 30) was being observed.

'Y_test.txt' and 'Y_train.txt': 1-column files of the code for the activity observed. The activity name was a column added to this by using the factor() and relevel() functions on the activity labels data.

'X_test.txt' and 'X_train.txt': 561-column files of the measurement and statistic of the subject/activity observed in the corresponding rows in the subject and Y files.

The sub() and gsub() functions were used to to create more readable and descriptive variable names.

Only the mean and standard deviation column data were used in the tidy data. The grepl() function was used to determine which columns to delete from the X data.

The mean of each saved variable for each observation of a subject doing a certain activity was created for the final tidy set using the melt() and dcast() functions.
 

CODE BOOK
  activity_labels.txt (6 x 2, char)
   1 WALKING
   2 WALKING_UPSTAIRS
   3 WALKING_DOWNSTAIRS
   4 SITTING
   5 STANDING
   6 LAYING

  features.txt (561 x 2, char)
    1 tBodyAcc-mean()-X
    ...
    90 tBodyAccJerk-max()-X
    ...
    561 angle(Z,gravityMean)
    
    Signals were measured with the accelerometer and gyroscope in 3 directions, denoted by the "Acc" and "Gyro" in the variable names and "-X", "-Y" and "-Z" for different directions.
    The acceleration signal was then separated into body and gravity acceleration signals, denoted by "Body" and "Gravity".  
    Subsequently, body data was used obtain Jerk signals denoted by "Jerk" 
    The magnitude of these three-dimensional signals are denoted by "Mag". 
    Prefix 't' denotes time. 
    Prefix "f" denotes frequency domain signals produced by a Fast Fourier Transform (FFT) applied to some of these signals.
    
    Statistics applied to each measurement are denoted by:
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
      angle(): Angle between two vectors.

  subject_test (2947 x 1), subject_train.txt (7352 x 1)
    contain subject (ranging from 1 to 30) being observed

  Y_test.txt (2947 x 1), Y_train.txt (7352 x 1)  
    contain activity (ranging from 1 to 6) being observed
  
  X_test.txt (2947 x 561), X_train.txt (7352 x 561)
    contain observations of each variable; variable measured by each column corresponds to row number in features.txt
    Acceleration data was in gravitational units (g) and angular data was in radians/second, but all data was normalized to be in the range [-1,1].

  
  
  
