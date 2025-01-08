# dataHandlingSkills_R
Code snippets to demonstrate some common data handling or statistical test usage in R. 

R commands are stored as text files with a ".R" extension. This is a convention to denote these text files contain R commands.  To use the commands, the easiest option is to download/copy the R file to your own computer and open them in R or Rstudio. You can then execute the commands line-by-line or all at once. 

If any *data* need to be loaded, they are stored in files in the sub-folder [data](/data/) and you will need to download these too and save them in a location that is accessible from R  (e.g. in a sub-folder called "data").


# Getting started with R

The code snippets in this folder assume you know some R basics on how to load and work with data.  

For absolute beginners, I recommend Dan Navarro's online book ["Learning Statistics with R"](https://learningstatisticswithr.com/book).  Assuming you have already have access to an installed version of R, then you could start at [starting R]( https://learningstatisticswithr.com/book/introR.html#startingR)
 You should bookmark this book as everything in there is useful and it explains many idiosynchronies of R and of Statistical thinking.


# List of Code snippets with links

## BIOL10401

 - Calculating atomic coordinates [R/atomicCoordinates.R](R/atomicCoordinates.R)
 - Correlation example   [correlationAndLinearModel_absorbance](/R/correlationAndLinearModel_absorbance.R)
 - [Data analysis (pH indicator flourescence)](R/fluoresceneRatioCalibration.R)
 - [Adding error bars to plots](R/plotCalibrationErrorBars.R)

## BIOL10412/22

 - 1 Variability and Sampling
[R/mean_variance.R](R/mean_variance.R)
 - 2 Testing for Differences
[R/students_t_test.R](R/students_t_test.R)
 - 3 Investigating Associations
[R/correlation_test.R](R/correlation_test.R)
 - 4 Dealing with Categorical Data
[R/chi_square_tests.R](R/chi_square_tests.R)
 - 5 Comparing More Than Two Groups
[R/one_way_ANOVA.R](R/one_way_ANOVA.R)
 - 6 Dealing with Two Factors
[R/two_way_ANOVA.R](R/two_way_ANOVA.R)
 - 7 Regression and Curve Fitting
[R/linear_regression.R](R/linear_regression.R)
 - 8 Non-Parametric Statistics

 - 9 More Non-Parametric Tests

 - 10 Designing Experiments and Presenting Results