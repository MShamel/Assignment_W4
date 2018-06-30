
# Assignment, Getting and Cleaning Data, week 4

# read all files 
xtrain <- read.table("X_train.txt")
ytrain <- read.table("y_train.txt")
subjtrain <- read.table("subject_train.txt")
xtest <- read.table("X_test.txt")
ytest <- read.table("y_test.txt")
subjtest <- read.table("subject_test.txt")
features <- read.table("features.txt")


# merge activities from train and test
ytotal <- rbind(ytrain, ytest)
# the activites data frame is converted to vector
ytotalvec <- ytotal[ ,1]
# the activies number are replaces with descriptive names
ytotal1 <- sub("1", "walking", ytotalvec)
ytotal2 <- gsub("2", "walkingupstairs", ytotal1)
ytotal3 <- gsub("3", "walkingdownstairs", ytotal2)
ytotal4 <- gsub("4", "sitting", ytotal3)
ytotal5 <- gsub("5", "standing", ytotal4)
ytotal6 <- gsub("6", "laying", ytotal5)

# merge "train" and "test" files of subjects
subjtotal <- rbind(subjtrain, subjtest)
# merge "train" and "test" files of measurements
xtotal <- rbind(xtrain, xtest)
# merge subjects, activities and measurements in one dataframe
total <- cbind(subjtotal, ytotal6, xtotal)

# assign descriptive column names
colnames(total) <- c("subject", "activity", as.character(features[ , 2]))


# subset the means and standard deviations
sub1 <- total[ ,grep("mean", colnames(total))]
sub2 <- total[ ,grep("std", colnames(total))]

# combine the means and std variables then merge back the subject and activity columns
sub3 <- cbind(subject=total[ ,1], activity=total[ ,2], sub1, sub2)

# the sub3 dataframe is split in groups of values per subject per activity
# to give a list of 180 elements, each element is a dataframe of all values available for
# this subject&activity combination
mysplit <- split(sub3, list(sub3$subject,sub3$activity))

# L is a function that calculate column means for a dataframe of the number of columns as 
# mysplit, but skips the first two columns (subject and activity)
L <- function(x){
  colMeans(x[ ,3:81])
}

# the L function is applied to each of the dataframes in "mysplit", using sapply() function.
# then the result is transposed using the t() function
# the resultin dataframe is put in "tidydata"
tidydata <- t(sapply(mysplit, L))

# the tidydata dataframe is copied to text file "tidydata.txt"
write.table(tidydata, "tidydata.txt")

