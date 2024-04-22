# For data manipulation
library(dplyr)
library(readxl)
library(ggplot2)
library(tidyr)

# Load the dataset

# Full Dataset
df <- download_and_load_data()

# Map the treatments to 'C', 'TD', and 'MD'
df$treatment_group <- ifelse(grepl("^control", df$treatment), "C",
                              ifelse(grepl("^delay", df$treatment), "TD", "MD"))

df$game_type <- ifelse(df$bully == 0, "Standard Dictator Game", "Bully Dictator Game")

###### From Paper ##############
# Count occurrences of each combination of game_type and treatment_group
count_df <- df %>% 
  group_by(game_type, treatment_group) %>% 
  summarise(count = n()) %>%
  mutate(game_type = factor(game_type, levels = c("Standard Dictator Game", "Bully Dictator Game"))) %>%
  pivot_wider(names_from = treatment_group, values_from = count, values_fill = 0) %>%
  arrange((C))

# Print the counts
print(count_df)

# Standard Dictator Game Data
DG <- subset(df, treatment %in% c("controlNObully", "delayNObully", "motivationNObully"))

# Bully Dictator Game Data
BDG <- subset(df, !(treatment %in% c("controlNObully", "delayNObully", "motivationNObully")))

# Data Preparation & Analysis
################ Sample balance (TABLE 2) ######################

variables <- c("crt_right", "crt_int", "female", "age", "household_income",
               "children", "FT_job", "christian", "student", "democrat")

# Define the type of test for each variable
test_types <- c("Kruskal-Wallis", "Kruskal-Wallis", "Chi-squared", "Kruskal-Wallis", "Kruskal-Wallis",
                "Chi-squared", "Chi-squared", "Chi-squared", "Chi-squared", "Chi-squared")

#By MOC
p_values_moc <- c(
  kruskal.test(df$crt_right ~ df$moc)$p.value,
  kruskal.test(df$crt_int ~ df$moc)$p.value,
  chisq.test(table(df$moc, df$female))$p.value,
  kruskal.test(df$age ~ df$moc)$p.value,
  kruskal.test(df$household_income ~ df$moc)$p.value,
  chisq.test(table(df$moc, df$children))$p.value,
  chisq.test(table(df$moc, df$FT_job))$p.value,
  chisq.test(table(df$moc, df$christian))$p.value,
  chisq.test(table(df$moc, df$student))$p.value,
  chisq.test(table(df$moc, df$democrat))$p.value
)

#BY Treatment
p_values_treatment <- c(
  kruskal.test(df$crt_right ~ df$treatment)$p.value,
  kruskal.test(df$crt_int ~ df$treatment)$p.value,
  chisq.test(table(df$treatment, df$female))$p.value,
  kruskal.test(df$age ~ df$treatment)$p.value,
  kruskal.test(df$household_income ~ df$treatment)$p.value,
  chisq.test(table(df$treatment, df$children))$p.value,
  chisq.test(table(df$treatment, df$FT_job))$p.value,
  chisq.test(table(df$treatment, df$christian))$p.value,
  chisq.test(table(df$treatment, df$student))$p.value,
  chisq.test(table(df$treatment, df$democrat))$p.value
)

# Combine into a dataframe
results_table <- data.frame(
  Variables = variables,
  Test_Type = test_types,
  Treatment_P_Value = round(p_values_treatment, 3),
  Moc_P_Value = round(p_values_moc, 3)
)

# Print the results table with the Test Type column
print(results_table)



################  mean of attention (FIGURE 2) ########################
# on attention variable:
# Perform Kruskal–Wallis test for attention variable
attention_kruskal <- kruskal.test(attention ~ moc, data = df)
print(attention_kruskal)

# Perform Mann-Whitney U test for attention variable between different treatment groups
attention_C <- df[df$treatment_group == "C", "attention"]$attention
attention_TD <- df[df$treatment_group == "TD", "attention"]$attention
attention_MD <- df[df$treatment_group == "MD", "attention"]$attention

# Perform Mann-Whitney U test between TD and MD
attention_result_TD_MD <- wilcox.test(attention_TD, attention_MD)

# Perform Mann-Whitney U test between C and MD
attention_result_C_MD <- wilcox.test(attention_C, attention_MD)

# Perform Mann-Whitney U test between C and TD
attention_result_C_TD <- wilcox.test(attention_TD, attention_C)

# Print the results
print("TD vs MD:")
print(attention_result_TD_MD)
print("C vs MD:")
print(attention_result_C_MD)
print("C vs TD:")
print(attention_result_C_TD)

# Calculating means and standard errors for each moc/treatment_group
attention_means <- df %>%
  group_by(treatment_group) %>%
  summarise(Mean = mean(attention, na.rm = TRUE),
            SE = sd(attention, na.rm = TRUE) / sqrt(n()))

# Plotting
ggplot(attention_means, aes(x = treatment_group, y = Mean, fill = as.factor(treatment_group))) +
  geom_bar(stat = "identity", position = position_dodge()) +
  geom_errorbar(aes(ymin = Mean - SE, ymax = Mean + SE), width = 0.25) +
  theme_minimal() +
  labs(x = "Mode of Cognition", y = "Mean Attention", fill = "Moc Group") +
  scale_fill_brewer(palette = "Pastel1")



################### mean of time spent on the main task (FIGURE 3) ##################################
# on seconds_on_task variable
# Perform Kruskal–Wallis test for time spent variable
time_spent_kruskal <- kruskal.test(seconds_on_task ~ moc, data = df)
print(time_spent_kruskal)

# Perform Mann-Whitney U test for time spent variable between different treatment groups
time_spent_C <- df[df$treatment_group == "C", "seconds_on_task"]$seconds_on_task
time_spent_TD <- df[df$treatment_group == "TD", "seconds_on_task"]$seconds_on_task
time_spent_MD <- df[df$treatment_group == "MD", "seconds_on_task"]$seconds_on_task

# Perform Mann-Whitney U test between TD and MD
time_spent_result_TD_MD <- wilcox.test(time_spent_TD, time_spent_MD)

# Perform Mann-Whitney U test between C and MD
time_spent_result_C_MD <- wilcox.test(time_spent_C, time_spent_MD)

# Perform Mann-Whitney U test between C and TD
time_spent_result_C_TD <- wilcox.test(time_spent_TD, time_spent_C)

# Print the results
print("TD vs MD:")
print(time_spent_result_TD_MD)
print("C vs MD:")
print(time_spent_result_C_MD)
print("C vs TD:")
print(time_spent_result_C_TD)

# Calculating means and standard errors for each moc/treatment_group
time_spent_means <- df %>%
  group_by(treatment_group) %>%
  summarise(Mean = mean(seconds_on_task, na.rm = TRUE),
            SE = sd(seconds_on_task, na.rm = TRUE) / sqrt(n()))

# Plotting
ggplot(time_spent_means, aes(x = treatment_group, y = Mean, fill = as.factor(treatment_group))) +
  geom_bar(stat = "identity", position = position_dodge()) +
  geom_errorbar(aes(ymin = Mean - SE, ymax = Mean + SE), width = 0.25) +
  theme_minimal() +
  labs(x = "Mode of Cognition", y = "Mean Seconds on Task", fill = "Moc Group") +
  scale_fill_brewer(palette = "Pastel1")








####################### Second Part for Zihua #####################
## Some analysis from Main Analysis: 
# on Kept/GOT variable:
# Perform Kruskal–Wallis test for DG
kruskal_DG <- kruskal.test(kept ~ moc, data = DG)
print(kruskal_DG)

# Perform Kruskal–Wallis test for BDG
kruskal_BDG <- kruskal.test(kept ~ moc, data = BDG)
print(kruskal_BDG)

#Perform Mann-Whitney U test for BDG choice
group_C <- BDG[BDG$treatment_group == "C", "kept"]$kept
group_TD <- BDG[BDG$treatment_group == "TD", "kept"]$kept
group_MD <- BDG[BDG$treatment_group == "MD", "kept"]$kept

# Perform Mann-Whitney U test between TD and MD
result_TD_MD <- wilcox.test(group_TD, group_MD)

# Perform Mann-Whitney U test between C and MD
result_C_MD <- wilcox.test(group_C, group_MD)

# Perform Mann-Whitney U test between C and TD
result_C_TD <- wilcox.test(group_TD, group_C)

# Print the results
print("TD vs MD:")
print(result_TD_MD)
print("C vs MD:")
print(result_C_MD)
print("C vs TD:")
print(result_C_TD)


# Calculating means and standard errors for each moc group
attention_means <- df %>%
  group_by(moc) %>%
  summarise(Mean = mean(attention, na.rm = TRUE),
            SE = sd(attention, na.rm = TRUE) / sqrt(n()))

# Plotting
ggplot(attention_means, aes(x = moc, y = Mean, fill = as.factor(moc))) +
  geom_bar(stat = "identity", position = position_dodge()) +
  geom_errorbar(aes(ymin = Mean - SE, ymax = Mean + SE), width = 0.25) +
  theme_minimal() +
  labs(x = "Mode of Cognition", y = "Mean Attention", fill = "Moc Group") +
  scale_fill_brewer(palette = "Pastel1")

