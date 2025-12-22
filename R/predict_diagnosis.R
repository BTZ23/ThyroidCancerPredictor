
#' Predict Thyroid Cancer Diagnosis
#'
#' This function predicts whether a thyroid nodule is benign or malignant
#' using a pre-trained Random Forest model.
#'
#' @param new_data A data.frame with required features. Must include:
#'   Age, Gender, TSH_Level, T4_Level, Nodule_Size, Family_History,
#'   Radiation_Exposure, Iodine_Deficiency, Smoking, Obesity, Diabetes
#' @return Factor vector with predictions ("Benign" or "Malignant")
#' @export
#' @examples
#' # Load package
#' library(ThyroidCancerPredictor)
#' 
#' # Example patient
#' patient <- data.frame(
#'   Age = 45,
#'   Gender = factor("Male", levels = c("Female", "Male")),
#'   TSH_Level = 2.5,
#'   T4_Level = 7.8,
#'   Nodule_Size = 1.2,
#'   Family_History = factor(1, levels = c(0, 1)),
#'   Radiation_Exposure = factor(0, levels = c(0, 1)),
#'   Iodine_Deficiency = factor(0, levels = c(0, 1)),
#'   Smoking = factor(1, levels = c(0, 1)),
#'   Obesity = factor(0, levels = c(0, 1)),
#'   Diabetes = factor(0, levels = c(0, 1))
#' )
#' 
#' # Predict
#' predict_diagnosis(patient)
predict_diagnosis <- function(new_data) {
  # Check required columns
  required <- c("Age", "Gender", "TSH_Level", "T4_Level", "Nodule_Size",
                "Family_History", "Radiation_Exposure", "Iodine_Deficiency",
                "Smoking", "Obesity", "Diabetes")
  
  missing <- setdiff(required, names(new_data))
  if (length(missing) > 0) {
    stop("Missing columns: ", paste(missing, collapse = ", "))
  }
  
  # Load model and threshold
  model_path <- system.file("extdata", "thyroid_rf_model.rds", 
                           package = "ThyroidCancerPredictor")
  threshold_path <- system.file("extdata", "best_threshold.rds", 
                               package = "ThyroidCancerPredictor")
  
  if (!file.exists(model_path)) {
    stop("Model file not found. Please reinstall the package.")
  }
  
  model <- readRDS(model_path)
  threshold <- readRDS(threshold_path)
  
  # Feature engineering (same as training)
  new_data <- new_data %>%
    dplyr::mutate(
      TSH_T4_ratio = TSH_Level / (T4_Level + 1e-3),
      TSH_Nodule = TSH_Level * Nodule_Size,
      Age_Nodule = Age * Nodule_Size
    )
  
  # Predict probabilities
  prob_malignant <- predict(model, newdata = new_data, type = "prob")[, "Malignant"]
  
  # Apply threshold
  prediction <- ifelse(prob_malignant > threshold, "Malignant", "Benign")
  factor(prediction, levels = c("Benign", "Malignant"))
}

#' Get Model Performance Summary
#'
#' Returns performance metrics of the trained model.
#'
#' @return List with model performance metrics
#' @export
#'
get_model_performance <- function() {
  perf_path <- system.file("extdata", "performance_summary.rds", 
                          package = "ThyroidCancerPredictor")
  if (!file.exists(perf_path)) {
    stop("Performance file not found.")
  }
  readRDS(perf_path)
}

#' Get Feature Importance
#'
#' Returns feature importance scores from the Random Forest model.
#'
#' @return Data.frame with feature importance scores
#' @export
#'
get_feature_importance <- function() {
  imp_path <- system.file("extdata", "feature_importance.rds", 
                         package = "ThyroidCancerPredictor")
  if (!file.exists(imp_path)) {
    stop("Feature importance file not found.")
  }
  readRDS(imp_path)
}

