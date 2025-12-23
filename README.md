# ThyroidCancerPredictor

An R package for predicting thyroid cancer diagnosis (Benign vs Malignant) using machine learning.

## Installation

```r
# Install from GitHub
if (!require(devtools)) install.packages("devtools")
devtools::install_github("BTZ23/ThyroidCancerPredictor")
Usage
r
library(ThyroidCancerPredictor)

# Prepare patient data
patient <- data.frame(
  Age = 45,
  Gender = factor("Male", levels = c("Female", "Male")),
  TSH_Level = 2.5,
  T3_Level = 1.8,
  T4_Level = 7.8,
  Nodule_Size = 1.2,
  Family_History = factor(1, levels = c(0, 1)),
  Radiation_Exposure = factor(0, levels = c(0, 1)),
  Iodine_Deficiency = factor(0, levels = c(0, 1)),
  Smoking = factor(1, levels = c(0, 1)),
  Obesity = factor(0, levels = c(0, 1)),
  Diabetes = factor(0, levels = c(0, 1))
)

# Predict diagnosis
result <- predict_diagnosis(patient)
print(result)
Model Performance
AUC: 0.6147

Accuracy: 0.5096

Sensitivity: 0.7253

Specificity: 0.4442

Project Information
This is part of BIO215 Capstone Project:

Role 1: Machine Learning Modeler

Role 2: Shiny Website Developer

Role 3: R Package Developer (this package)

Links
GitHub: https://github.com/BTZ23/ThyroidCancerPredictor

Shiny App: [To be added]

Dataset: https://www.kaggle.com/datasets/mzohaibzeeshan/thyroid-cancer-risk-dataset

License
MIT

