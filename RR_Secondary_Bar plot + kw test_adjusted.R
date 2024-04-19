
# load the necessary libraries-------
library(dplyr)
library(readxl)
library(ggplot2)

# Load the dataset----------
data <- read_excel("data_DMDDG.xls")

# view the data
head(data)

# Secondary Analysis-----------------------
# empirical expectations (EE), personal normative beliefs (NB) and normative expectations (NE)
# Introduction: we check if, once we control for EE, NB, and NE, the experimental conditions still affect the dictators’ decision. Furthermore, we also control for CRT, sex and income. 
# In the following analysis we use Tobit regressions since the main dependent variable, Got, is bounded on both sides and has a non-negligible number of extreme values.

# 1. Non-parametric Analysis of Norms and Bar Plots with Confidence Intervals
# plot for ee by moc
ggplot(data, aes(x = factor(moc), y = ee, fill = factor(moc))) +
  geom_bar(stat = "summary", fun = "mean", position = position_dodge(width = 0.8)) +
  geom_errorbar(stat = "summary", fun.data = mean_se, position = position_dodge(width = 0.8), width = 0.25) +
  labs(x = "Mode of Cognition", y = "EE") +
  theme_minimal() +
  ggtitle("Bar plot of EE by MOC")

# Plot for nb by moc
ggplot(data, aes(x = factor(moc), y = nb, fill = factor(moc))) +
  geom_bar(stat = "summary", fun = "mean", position = position_dodge(width = 0.8)) +
  geom_errorbar(stat = "summary", fun.data = mean_se, position = position_dodge(width = 0.8), width = 0.25) +
  labs(x = "Mode of Cognition", y = "NB") +
  theme_minimal() +
  ggtitle("Bar plot of NB by MOC")

#Plot for ne by moc
ggplot(data, aes(x = factor(moc), y = ne, fill = factor(moc))) +
  geom_bar(stat = "summary", fun = "mean", position = position_dodge(width = 0.8)) +
  geom_errorbar(stat = "summary", fun.data = mean_se, position = position_dodge(width = 0.8), width = 0.25) +
  labs(x = "Mode of Cognition", y = "NE") +
  theme_minimal() +
  ggtitle("Bar plot of NE by MOC")


#Plot for ee by bully
ggplot(data, aes(x = factor(bully), y = ee, fill = factor(bully))) +
  geom_bar(stat = "summary", fun = "mean", position = position_dodge(width = 0.8)) +
  geom_errorbar(stat = "summary", fun.data = mean_se, position = position_dodge(width = 0.8), width = 0.25) +
  labs(x = "Game Type", y = "EE") +
  theme_minimal() +
  ggtitle("Bar plot of EE by Game Type")

# Plot nb for bully
ggplot(data, aes(x = factor(bully), y = nb, fill = factor(bully))) +
  geom_bar(stat = "summary", fun = "mean", position = position_dodge(width = 0.8)) +
  geom_errorbar(stat = "summary", fun.data = mean_se, position = position_dodge(width = 0.8), width = 0.25) +
  labs(x = "Game Type", y = "NB") +
  theme_minimal() +
  ggtitle("Bar plot of NB by Game Type")

# plot ne for bully
ggplot(data, aes(x = factor(bully), y = ne, fill = factor(bully))) +
  geom_bar(stat = "summary", fun = "mean", position = position_dodge(width = 0.8)) +
  geom_errorbar(stat = "summary", fun.data = mean_se, position = position_dodge(width = 0.8), width = 0.25) +
  labs(x = "Game Type", y = "NE") +
  theme_minimal() +
  ggtitle("Bar plot of NE by Game Type")

# Kruskal-Wallis tests by moc and by bully
results <- list()
for (norm in c("ee", "nb", "ne")) {
  # Running Kruskal-Wallis test by moc
  results[[paste("kwallis", norm, "moc")]] <- kruskal.test(reformulate("moc", response = norm), data = data)
  # Running Kruskal-Wallis test by bully
  results[[paste("kwallis", norm, "bully")]] <- kruskal.test(reformulate("bully", response = norm), data = data)
}

# Display results
for (result_name in names(results)) {
  print(result_name)
  print(results[[result_name]])
}

# (a) not diffe under the different cognitive manipulations and the control, 
# (b) do not differ between the standard and the Bully Dictator Game The difference in the means of Empirical Expectations (EE), Normative Beliefs (NB) and Normative Expectations (NE) 
# are not statistically significant neither with respect to cognitive manipulations nor to variants of the dictator game.


