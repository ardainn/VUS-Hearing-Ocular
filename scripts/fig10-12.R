# get survey data and helper functions
source("../01_config.R")
source("../02_helpers.R")

# define plot colors
colors <- c("#ff9f1c", "#ffbf69", "#ffffff", "#8BE4DE", "#2ec4b6")

# define and map labels
labs <- c(
  "strongly disagree",
  "disagree",
  "neither agree nor disagree",
  "agree",
  "strongly agree"
)
likert_map <- setNames(seq_along(labs), labs)

#### CLIN UT IMPROVEMENTS ####

cols_ci <- 108:112

colnames(cleaned_data)[108:112] <- c(
  "Literature supports clinical use of variant-level functional data",
  "Literature supports clinical use of variant-level MAVE data",
  "More studies needed to prove clinical use of variant-level functional data",
  "More studies needed to prove clinical use of variant-level MAVE data",
  "ClinVar should clarify clinically relevant transcripts"
)

# define likert df
likert_df_ci <- make_likert_df(cleaned_data, cols_ci, labs)

# plot
plot_likert(
  likert_df_ci,
  colors = colors,
  file_name = "likert_clinut_impr.png",
  include_center = F,
  legend_title_centered = T,
  legend_break = T,
  height = 23 / 2
)

# run chisq test
results_ci <- run_chisq(likert_df_ci, likert_map)

#### FUNC DT GENE ####

cols_dg <- 113:115

colnames(cleaned_data)[113:115] <- c(
  "I always review literature describing gene-level functional data when classifying variants",
  "Gene-level data helps interpret pLOF variants when variant-specific data is lacking",
  "Gene-level experiments offer insights on pLOF variants, even if variants differ from known cases"
)


# define likert df
likert_df_dg <- make_likert_df(cleaned_data, cols_dg, labs)

# plot
plot_likert(
  likert_df_dg,
  colors = colors,
  file_name = "likert_funcdt_gene.png",
  include_center = F,
  legend_title_centered = T,
  legend_break = T,
  height = 23 * 0.3
)

# run chisq test
results_dg <- run_chisq(likert_df_dg, likert_map)

#### FUNC DT VARIANT ####

cols_dv <- 116:123

colnames(cleaned_data)[116:123] <- c(
  "I always review literature describing gene-level functional data when classifying variants",
  "Functional assay design details must be in ClinVar to use variant-level functional data for classification",
  "Disease mechanism must be specified in ClinVar to use variant-level functional data properly",
  "I would use ClinGen more if it showed confidence and accuracy metrics for variant-level functional data",
  "I would use variant-level functional data more if ClinVar linked to primary data sources",
  "Multiple sources of variant-level functional data should be shown on ClinVar like multiple lab classifications",
  "Conflicting variant-level functional data sources should all be shown on ClinVar like multiple lab classifications",
  "I would use ClinVar's standardized variant-level functional data classifications, like PS3_Strong, for interpretation"
)

# define likert df
likert_df_dv <- make_likert_df(cleaned_data, cols_dv, labs)

# plot
plot_likert(
  likert_df_dv,
  colors = colors,
  file_name = "likert_funcdt_vart.png",
  include_center = F,
  legend_title_centered = T,
  legend_break = T,
  height = 23 * 0.7
)

# run chisq test
results_dv <- run_chisq(likert_df_dv, likert_map)

