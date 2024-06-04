# Repository for Reproducible Research Group Project

The goal of this repository is to recreate the findings from [Delaying and motivating decisions in the (Bully) dictator game](https://www.sciencedirect.com/science/article/pii/S2214804323001325?fbclid=IwAR0jo_iPAZtn05fiXHovSlxtIeclyaRfO0xiwMJH6_gkmi5fh9JYDKGheJA) from Journal of Behavioral and Experimental Economics.

### Loading Libraries and Data
The report starts by loading essential libraries required for data manipulation, visualization, and statistical analysis. These libraries include dplyr, ggplot2, readr, tidyr, readxl, knitr, zoo, lmtes, AER, gridExtra, kableExtra, pscl, and others necessary for comprehensive analysis. The dataset is then downloaded from a specified link and read into the R environment, preparing it for subsequent analysis.

## Paper

### Objective of the paper

To compare the effects of a time delay condition and a motivated delay condition (with respect to a baseline condition) on allocation decisions in the Dictator Game, for both the bully and non-bully variants.

The study aimed to understand how these variations affected participants' decisions. The findings revealed that when the initial endowment was equal, the dictator received less, aligning with previous laboratory evidence in an online context. Additionally, it was observed that requesting subjects to provide a written motivation resulted in them taking less for themselves compared to simply being asked to wait before making their decision.
### Replication

This report aims to replicate the findings of the research paper "Delaying and motivating decisions in the (bully) dictator game" by Bilancini, Ennio, et al. The original study explores the decision-making processes in economic games, specifically focusing on the impact of delaying and motivating decisions. This replication study ensures the reliability and validity of the original findings, contributing to the broader scientific discourse on behavioral economics.

### Methods of Analysis

The researchers conducted an experimental investigation to examine how cognitive manipulations influence decisions within the Dictator Game. Their primary objective was to foster a greater reliance on deliberation. In the online experiment, six distinct experimental conditions were established by combining two conditions for the Dictator Game (non-bully: where the dictator initially possesses all the money; bully: where the initial endowment is equally split) with three conditions for cognitive manipulations (time delay: decisions are delayed; motivated delay: decisions are delayed and a written motivation is required; control: no manipulation). 

#### Manipulations:

- Time Delay: Participants wait a specified time before making their decision.
- Motivated Delay: Participants write a motivation for their decision and wait before submitting.
- Control: Immediate decision without delay or requirement for justification.
  
#### Measures
- Main Outcome: Amount of money allocated to the other participant in the Dictator Game.
- Secondary Outcomes: Empirical expectations, normative beliefs, and normative expectations related to altruistic behavior, measured through a pre-experiment survey and post-decision questionnaire.
- **Cognitive Reflection Test** (CRT): To assess the influence of cognitive style on decision-making.
  

## Analysis and Results
The analysis section delves into the replication of the original study’s experiments, employing the **Mann-Whitney U test** to evaluate the differences in decision-making under various conditions. Detailed visualizations and statistical tables are presented to illustrate the findings clearly. The results are compared with the original study to confirm the consistency and reliability of the conclusions drawn. Specific focus is maintained on:

- Descriptive statistics to summarize the data.
- **Kruskal-Wallis** and **Mann-Whitney** tests to compare allocations across different conditions.
- **Tobit regression analyzes** to control for individual differences and cognitive styles.


## Conclusion
The report concludes with a discussion on the implications of the replicated findings, highlighting any discrepancies and their potential causes. It emphasizes the importance of replication in scientific research and suggests areas for further investigation to enhance the understanding of decision-making processes in economic games.


## How to Use This Report

**Install Required Libraries and load data**: Begin by ensuring that all necessary libraries are installed. You can find a list of required libraries at the beginning of the RMD file. If the dataset is not already available, it will be automatically downloaded from the provided link. This step ensures that you have access to the data needed for the analysis.

**Run the Analysis**: Execute the report.RMD file to replicate the analysis. The code is structured in a way that facilitates a step-by-step understanding of the replication process. By following the code sequentially, you can replicate the analysis conducted in the original study.

**Review Results**: Examine the output generated. This includes statistical tests and visualizations. Take time to understand how the results compare to those of the original study. This step is crucial for assessing the accuracy of the replication.

**Interpret Findings**: Once you have reviewed the results, use the provided discussions and conclusions to interpret the findings. Additionally, you can compare the findings with Authors' findings listed all the same.
