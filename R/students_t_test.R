# This is an R script demonstrating some simple data manipulation and statistical functions in R.
#  Lines beginning with '#' are comments (like this line)
#  Other lines are commands that you can run in R
# Start at the top and run each line of command in turn
# Pay attention to the output generated by each command.
# If you are new to using R please read my advice here:
#  https://github.com/davetgerrard/dataHandlingSkills_R/


# load some data
heights <- scan("data/heights.txt")

# One sample t-test ------------------
?t.test

t.test(heights, mu= 1.60)


# Unpaired t-test ------------------

heights_sex <- read.delim("data/heights_sex.tsv")

# we could extract the male and female heights into two vector and test these against each other
heights_male <- heights_sex[heights_sex$sex == "M", "height"]
heights_female <- heights_sex[heights_sex$sex == "F", "height"]
t.test(heights_female, heights_male,  paired = FALSE)

# Above is how you would do it if you loaded data from two different sources.
# However, our original table is already in a sensible format and
# we can do the test without changing the table.
t.test(height ~ sex, data=heights_sex,  paired = FALSE)  
# this should have given the same result as above.
# you may recognise the formula style (height ~ sex) from boxplot.
boxplot(height ~ sex, data=heights_sex, notch=T)


# Paired t-test -------------------

beforeVec <- c(65, 71, 78, 60, 45, 55, 96, 51, 64  )
afterVec <-  c(74, 78, 80, 63, 53, 59, 97, 55, 72)

# You don't have to, but it is normal in R to store repeated measures on the same subject (of the same or different variable) as columns in a data-frame.
repMeasures <- data.frame(before = c(65, 71, 78, 60, 45, 55, 96, 51, 64  ),
                          after = c(74, 78, 80, 63, 53, 59, 97, 55, 72))
repMeasures
# this is really useful for ensuring that paired values stay together if we subset or filter the data (e.g. remove subjects).
t.test(beforeVec, afterVec, paired=TRUE)
t.test(repMeasures$before,repMeasures$after, paired=T)
# these two versions should give the same result.

# store the result of the test as we can use it later
result.tt <- t.test(beforeVec, afterVec, paired=TRUE)


# perhaps this example should be recoded to also use long-format for the input table.

# let's finish with a plot.
stripchart(list(repMeasures$before,repMeasures$after), vertical=T, 
           xlim=c(0.5,2.5), ylim=c(0,110), group.names=c("female", "male"))
# join the points with lines
segments(x0=1,   y0=repMeasures$before,
         x1=2,   y1=repMeasures$after)

# a bit of R wizardry to assign an asterisk label depending on the p-value of the test. 
sigLevels <- data.frame(pVal = c(0.001, 0.01, 0.05, 1), label=c("***", "**", "*", "n.s."))
sigLevels
sigLabel <- sigLevels$label[ min(which(0.005 < sigLevels$pVal))]
text(x=1.5, y=110, sigLabel, cex=2)  # put the label on the plot


# could also show with a barplot of the means and error bars (standard error or 95% CI). 


# check if a one-sample t-test on the differences between the pairs 
# is equivalent to the paired t-test.

repMeasures$diff <- repMeasures$after - repMeasures$before

t.test(repMeasures$diff, mu=0)  # this should be identical except perhaps 
