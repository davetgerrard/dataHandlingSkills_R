# This is an R script demonstrating some simple data manipulation functions in R.
#  Lines beginning with '#' are comments (like this line)
#  Other lines are commands that you can run in R
# Start at the top and run each line of command in turn
# Pay attention to the output generated by each command.
# If you are new to using R please read my advice here:
#  https://github.com/davetgerrard/dataHandlingSkills_R/


# This script loads some  some calibration data, and plots mean values
#  with error bars showing the standard error of each mean. 


# LOAD CALLIBRATION DATA ----------------------

cal_data <- read.delim("c:/dataHandlingSkills_R/data/calibration_long.tsv")

# there are multiple measurements per pHi value and we want the mean measurement value for each.

means <- by(data=cal_data$ratio, INDICES=cal_data$pHi, FUN=mean)
means   # this looks different to other R data types we have seen so far. 

#  It is a vector of mean values, with the four values of pHi being used as names.
# However it can be converted to a matrix or data.frame for further use

#means.m <- as.matrix(means)   # remove the initial # if you want to try this
means.df <- data.frame(pHi= as.numeric(names(means)), meanRatio = means)

# it's important to convert the mean pHi values back into numbers using as.numeric()

# repeat this procedure but now calculate the standard deviations of each set of ratios
# there is a function sd() that can be used to get the standard deviation

sdValues <- by(data=cal_data$ratio, INDICES=cal_data$pHi, FUN=sd)
countValues <- by(data=cal_data$ratio, INDICES=cal_data$pHi, FUN=length)

# to calculate standard errors of the means:  SE = SD / sqrt(N) 
# where N is the number of observations contributing to each SD (here 4 for all values)

seValues <- sdValues / sqrt(4)

# alternatively each sd value can be divided by a specific count for that set of values
# this approach works also in cases where each sd is derived from a different number of values.

sdValues / sqrt(countValues)

# now add these values to the data.frame with the means

means.df$se <- seValues

# PLOT the mean values and use the standard error values for error bars.

plot(x=means.df$pHi, y=means.df$meanRatio, col="blue", pch=19, cex=1, xlab="Intracellular pH", ylab=" Fluorescence ratio",
     xlim=c(6.6, 7.6), ylim=c(2, 5), las=1)

arrows(x0=means.df$pHi, y0=means.df$meanRatio - means.df$se, 
       x1=means.df$pHi, y1=means.df$meanRatio + means.df$se, 
       angle=90, code=3, length=0.05, lwd=2)

# we will want to fit a straight line to these points and extract the coefficients
# for the gradient (M) and the intercept (C).

fluor.lm <- lm(meanRatio ~ pHi, data = means.df)
coef(fluor.lm)   # these will be the same as those calculated in Excel. 
abline(coef=coef(fluor.lm), lty=2, lwd=2, col="blue")
