# Assignment_W4
Assignment of Week4, of Getting and Cleaning Data course, Coursera

The repository contains the following:
1. This README.md file
2. tidydata.txt ; containg the result of step five in the quiz.  Please use "tidydata <- read.table("tidydata.txt")" to load it, then view() in R-studio
3. run_analysis.R ; containig the script used to develop the tidydata
4. codebook_mytidydata.md ; the codebook for tidydata, generated with the help of dataMaid package

The following is the explanation of the R script used to process the week4 assignment
of Getting and Cleaning Data course.
The R script file is "run_analysis.R"
Prepared by Mohamed Roshdy,  29th June, 2018

In the first section, all provided text files are read and assigned to data frames;

the activities from train and test data are merged into dataframe "ytotal" using rbind()

the activites data frame is converted to vector ytotalvec

the activies number are replaced with descriptive names, on 6 steps.  In every step
one of the numbers is replaced with an activity name using sub() function

the "train" and "test" files of subjects are merged into "subjtotal" using rbind
the "train" and "test" files of measurements are merged in "xtotal" using rbind

The columns of subjects, activities and measurements are all merged in one dataframe
"total" using cbind

Descriptive names are assigned to columns of "total".
The subjects and activities are assigned by direct character strings, while the variables
descriptive names are taken from the features file

The variables related to means and standard deviations are subsetted from the "total"
dataframe, using the grep() function.  it is done in 2 steps, one for the word mean 
(into sub1) and one for the word std (into sub2).

sub1 and sub2 are combined into sub3.  during the subsetting of sub1 and sub2 the subjct
and activity columns are croped out.  So now i add them back into sub3 dataframe

The sub3 dataframe is split in groups of values per subject per activity.  Since there 
are 30 subjects and 6 activities, then there will be 180 subject&activity combination,
each is a dataframe with various number of rows.  the two splitting factors are used together
in the (list) argument of split() function.
The split results in a list of 180 elements, each element is a dataframe.  The result is 
put into "mysplit" 

L is a function that calculates column means for a dataframe with 81 column (matching the 
dataframes in "mysplit" list.  But it skips the first 2 columns and acts on the rest.
 
The L function is applied to each of the dataframes in "mysplit", using sapply() function.
the reult is a dataframe with variable names in the rows, so i transposed it using t()
function to keep it consistent with the previous dataframes.
The resulting dataframe is put in "tidydata", each row name is a combination of a subject and activity , e.g. "2.laying" means the row contains avarages related to subject 2 when doing activity "laying"

The tidydata is copied to text file "tidydata.txt"

 
