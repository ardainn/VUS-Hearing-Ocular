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
# run chisq test
results_dv <- run_chisq(likert_df_dv, likert_map)


