# This is an R script demonstrating some simple data manipulation functions in R.
#  Lines beginning with '#' are comments (like this line)
#  Other lines are commands that you can run in R
# Start at the top and run each line of command in turn
# Pay attention to the output generated by each command.
# If you are new to using R please read my advice here:
#  https://github.com/davetgerrard/dataHandlingSkills_R/


# This script loads some data on fluorescence and some calibration data


# LOADING THE FLUORESCENCE DATA ------------------------------- 
# load some data from a local file.  comment.char = "#"
BCECF_data <- read.delim("c:/dataHandlingSkills_R/data/BCECF.txt")

# if you try and inspect this data, it will run off the page. 
BCECF_data

# instead, use head() to just check the top
head(BCECF_data)

# ahh, it has converted the first row of data into column headers. We do not want that.
# reload the data, but specify that the data does not contain a header row.
BCECF_data <- read.delim("c:/dataHandlingSkills_R/data/BCECF.txt", header=F)
head(BCECF_data)

# let's give the table some meaningful headers
colnames(BCECF_data) <- c("T_sec", "F440", "F490")  
colnames(BCECF_data)    # note that the same function can be used to assign names and to retrieve the current values.
head(BCECF_data)  # now has the new names
summary(BCECF_data)    # it is good practice to look at the ranges of values 

# calculate the ratio of fluorescence values for each sample and store these in a new column
BCECF_data$ratio <- BCECF_data$F490 / BCECF_data$F440
head(BCECF_data)


# LOAD CALLIBRATION DATA ----------------------

cal_data <- read.delim("c:/dataHandlingSkills_R/data/calibration_long.tsv")

# there are multiple measurements per pHi value and we want the mean measurement value for each.
means <- by(data=8, INDICES=cal_data$pHi, FUN=mean)
means   # this looks different to other R data types we have seen so far. 
#  It is a vector of mean values, with the four values of pHi being used as names.
# However it can be converted to a matrix or data.frame for further use
#means.m <- as.matrix(means)
means.df <- data.frame(pHi= as.numeric(names(means)), meanRatio = means)
# it's important to convert the mean pHi values back into numbers using as.numeric()

plot(means.df, col="blue", pch=19, cex=2, xlab="Intracellular pH", ylab=" Fluorescence ratio",
     xlim=c(6.6, 7.6), ylim=c(2, 5), las=1)

# we will want to fit a straight line to these points and extract the coefficients
# for the gradient (M) and the intercept (C).
fluor.lm <- lm(meanRatio ~ pHi, data = means.df)
coef(fluor.lm)
cal.M <- coef(fluor.lm)[2]   # store the gradient
cal.C <- coef(fluor.lm)[1]    # store the intercept

# Use the calibration data to convert fluorescence ratios into intracellular pH -------------

# Ratio  =  (M x pHi) + C

#  pHi = (Ratio - C)  /  M

# remind ouselves of the ratio data we loaded earlier
head(BCECF_data)
# now calculte and store the pHi values using the calibration values above

BCECF_data$pHi <- (BCECF_data$ratio - cal.C)  / cal.M


plot(x=BCECF_data$T_sec/60, y=BCECF_data$pHi, type="l", ylab="Intracellular pH",
     xlab="Time (min)", las=1, xlim=c(0, 14), ylim=c(7.1, 7.9))
abline(v=c(5,8), lty=2)

segments(x0=5.0, y0=7.7, x1=8.0, y1=7.7)
# It may be easier to add text exactly where you want it later in a desktop publishing package.
# However, it is good to know that it can be done programmatically.
text(6, 7.8, expression('NH'[4]*'Cl'))


#ave(x=cal_data$ratio, as.factor(cal_data$pHi))
#sweep(cal_data$ratio, MARGIN=as.factor(cal_data$pHi), FUN=mean, )
#sapply(cal_data$ratioy, FUN=mean)