# Load necessary packages
chooseCRANmirror()
install.packages("coin_1.4-3-1.tgz", repos = NULL, type = "source")
install.packages("survival_3.5-8.tgz", repos = NULL, type = "source")
install.packages("libcoin_1.0-10.tgz", repos = NULL, type = "source")
install.packages("readxl")
install.packages("censReg")
install.packages("maxLik")
install.packages("miscTools")
library(miscTools)
library(libcoin)
library(survival)
library(dplyr)
library(coin)
library(readxl)
library(dplyr)
library(censReg)
library(maxLik)


# Load the dataset
data <- read_excel("data_DMDDG.xls")

# view the data
head(data)

# Main Analysis:
# Critical Thinking : K- W test is professionally for medians , here they used it for means. if there are any better tests
# DG - Standard Dictator Game (50%/50% endowment assignment)
# BDG- Bully Dictator Game (100%/0)
# TD- Time Delay (40 seconds)
# MD- Motivation Delay(40 seconds + motivation)
# C- Control

# RQ.1
# Are allocation choices in DG different under TD, MD and C? 
# If this is the case, in which treatment the dictator gets a larger share?
  
# RQ.2
# Are allocation choices in the BDG different under TD, MD and C? 
# If this is the case, in which treatment the dictator gets a larger share?
  
# RQ.3
# Do allocation choices under TD, MD and C differ between DG and BDG? 
# If this is the case, in which variant of the game the dictator gets a larger share?

# Task in Main Analysis: 
# test if allocation choices in the DG and in the BDG are different under the TD treatment, the MD treatment, and the C treatment, 
# in the case that a difference is detected, we check in which treatment the dictator gets a larger share.
# Focus on Q1 and Q2 
  
# Kruskal- Wallis Test 
# The Kruskal-Wallis test is a non-parametric statistical test used to determine if there are statistically significant differences between the medians of two or more independent groups.
# H0 : The medians of all groups are equal, or alternatively, the different samples are from identical populations.
# H1: At least one of the group medians differs from the others.


# Wilcoxon Rank Sum Test
# Primarily used to test the null hypothesis that the two samples come from the same distribution, specifically focusing on the median.
# H0: The distributions of both groups are equal, or more specifically, the medians of the two groups are equal.
# Ha: he distributions (and thus the medians) of the two groups are different.

# Check the unique value of treatment 
unique_treatment <- unique(data$treatment)
# To view the unique values
print(unique_treatment)

# unique value of moc
unique_moc <- unique(data$moc)
print(unique_moc)


# The treatment are composition of 3*2 
# 3 for cognition manipualation delay, motivaation and control
# 2 for endowments assignment from very beginning bully /non_bully

# Kruskal- Wallis Test by treatment
kwallis_treatment <- kruskal.test(kept ~ treatment, data = data)
print(kwallis_treatment)

# P-Value <0.05, so reject H0. 
#So,the means are different among  6 treatment groups

# Overall Mode of cognition analysis
kwallis_moc <- kruskal.test(kept ~ moc, data = data)
print(kwallis_moc)
#P-Value <0.05, so reject H0. Here the patterns are different in 3 coginition groups


# Pairwise Mann-Whitney Tests using pairwise comparisons with adjustment (Wilcoxon Rank Sum Test)
pairwise_moc <- pairwise.wilcox.test(data$kept, data$moc, p.adjust.method = "BH")
print(pairwise_moc)
# P-values:
# 0 vs. 1: The p-value is 0.682, indicating that there is no statistically significant difference in the kept distributions between the moc = 0 and moc = 1 groups.
# 0 vs. 2: The p-value is 0.021, suggesting a statistically significant difference in the kept distributions between the moc = 0 and moc = 2 groups at conventional significance levels .
# 1 vs. 2: The p-value is 0.028, indicating a statistically significant difference in the kept distributions between the moc = 1 and moc = 2 groups.


# Confidence Interval Bar Plot using ggplot2
data %>%
  ggplot(aes(x = factor(moc), y = kept, fill = factor(moc))) +
  geom_bar(stat = "summary", fun = "mean", position = position_dodge(0.8), width = 0.7) +
  geom_errorbar(stat = "summary", fun.data = mean_cl_normal, position = position_dodge(0.8), width = 0.25) +
  labs(x = "Mode of Cognition", y = "Mean Got")



# Specific Analysis for BG and BDG
# Kruskal-Wallis Test for DG
kwallis_dg <- kruskal.test(kept ~ moc, data = data[data$bully == 0,])
print(kwallis_dg)
# Mann-Whitney Tests using pairwise comparisons with adjustment
pairwise_dg <- pairwise.wilcox.test(data$kept[data$bully == 0], data$moc[data$bully == 0], p.adjust.method = "BH")
print(pairwise_dg)

# In Standard Dictator Games, the got mean under 3 different cognition patterns have no difference
# Same with the conclusion from the paper 
# In the Standard Dictator Game, the amount got by the dictators does not differ significantly under the different cognitive manipulations and the control treatment.



# Comparision by bully version and moc
# Mann-Whitney Tests for each MOC
if (sum(data$moc == 0) > 0) {
  mw_test_0 <- wilcox.test(kept ~ bully, data = data[data$moc == 0,])
  print(mw_test_0)
}

if (sum(data$moc == 1) > 0) {
  mw_test_1 <- wilcox.test(kept ~ bully, data = data[data$moc == 1,])
  print(mw_test_1)
}

# Bar Plot grouped by Bully and MOC
data %>%
  ggplot(aes(x = factor(bully), y = kept, fill = factor(moc))) +
  geom_bar(stat = "summary", fun = "mean", position = position_dodge(0.8), width = 0.7) +
  geom_errorbar(stat = "summary", fun.data = mean_cl_normal, position = position_dodge(0.8), width = 0.25) +
  facet_wrap(~moc) +
  labs(x = "Game Type", y = "Mean Got")

# same with the conclusion of paper
# The amount got by the dictator in the Bully Dictator game is consistently lower than that in the standard Dictator game,
# but only under Motivated Delay the difference is statistically significant.