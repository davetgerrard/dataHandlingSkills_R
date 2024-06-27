

# Some r examples of data analysis required in Data Handling Semester 1

absorb_data <- read.delim("DataAnalysis/DHS_alternatives/data/S1.8.Trendlines.Absorbance.tsv")

plot(absorb_data)


# correlation 
# could be positive or negative
cor(absorb_data$Concentration, absorb_data$Absorbance)
# to compare correlations we make the value +ve by squaring it
cor(absorb_data$Concentration, absorb_data$Absorbance) ^ 2
#
cor.test(absorb_data$Concentration, absorb_data$Absorbance)


abs.lm <- lm(Absorbance ~ Concentration, data = absorb_data)

plot(absorb_data)
abline(coef(abs.lm))

# N.B. the plot function does something very different wiht the model output.
plot(abs.lm)

# does the line need to be forced to go through the origin?
# is this legitimate to add data with no error?
# I think you should always fit an intercept because there could be experimental error captured by the variation.
#   Predictions also should be more accurate
# However, what if it leads to nonsence predictions or statements?

# more reading:
# https://dynamicecology.wordpress.com/2017/04/13/dont-force-your-regression-through-zero-just-because-you-know-the-true-intercept-has-to-be-zero/

