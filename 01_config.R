library(data.table)
library(showtext)
library(writexl)

# set threads
setDTthreads(12)

# set working directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# add custom fonts
font_add("HelveticaNeue-Bold", "fonts/HelveticaNeueBold.otf")
font_add("HelveticaNeue-Roman", "fonts/HelveticaNeueRoman.otf")
showtext_auto()

# read survey results
data <- fread('data/raw/AssessmentOfCurrentA_DATA_2025-08-18_0707.csv')
source("data/raw/AssessmentOfCurrentA_R_2025-08-18_0707.r")

# remove incomplete records
cleaned_data <- data[data[[3]] != '[not completed]']

# standardize country names
country_corrections <- c(
  "china" = "China",
  "italy" = "Italy",
  "spain" = "Spain",
  "UK" = "United Kingdom",
  "United States" = "United States of America",
  "USA" = "United States of America",
  "usa" = "United States of America",
  "UAE" = "United Arab Emirates",
  "Czech Republic" = "Czechia"
)

cleaned_data[, country := ifelse(country %in% names(country_corrections), country_corrections[country], country)]
cleaned_data[country == "", country := "not specified"]

# standardize gender entries
gender_corrections <- c(
  "F" = "Female",
  "female" = "Female",
  "M" = "Male",
  "male" = "Male",
  "man" = "Male"
)

cleaned_data[, gender := ifelse(gender %in% names(gender_corrections), gender_corrections[gender], gender)]
cleaned_data[gender == "", gender := "not specified"]


# standardize disease domains
cleaned_data[, disease_domain := fcase(
  disease_domain == 1, "H",
  disease_domain == 2, "V",
  disease_domain == 3, "H+V",
  default = NA_character_
)]

# standardize professional roles
cleaned_data[, professional_position := mapping_professional_position[professional_position]]

# standardize professional experience
cleaned_data[, years_professional_experience := mapping_years_professional_experience[years_professional_experience]]

# standardize variant volume
cleaned_data[, variant_volume := mapping_variant_volume[variant_volume]]
cleaned_data[, reinterpretation_vus_1 := mapping_variant_volume[reinterpretation_vus_1]]
cleaned_data[, proportion_vus := mapping_proportion_vus[proportion_vus]]
cleaned_data[, functional_data_avail := mapping_proportion_vus[functional_data_avail]]
cleaned_data[, reinterpretation_vus_2 := mapping_proportion_vus[reinterpretation_vus_2]]
cleaned_data[, conflicting_evidence := ifelse(
  is.na(conflicting_evidence), 
  NA, 
  mapping_conflicting_evidence[as.character(conflicting_evidence)]
)]


# remove unnecessary columns
cleaned_data[, c(2, 3) := NULL]
cleaned_data <- cleaned_data[,1:125]

# keep only submission with complete answers
cleaned_data <- cleaned_data[
  rowSums(is.na(cleaned_data)) < (ncol(cleaned_data) / 2)
]

#fwrite(cleaned_data, "data/processed/survey_data.csv")






