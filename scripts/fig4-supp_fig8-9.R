# get survey data and helper functions
if (!exists("cleaned_data")) {source("01_config.R")}
source("02_helpers.R")

# define plot colors
colors <- c("#ff9f1c", "#ffbf69", "#e0e0e0", "#8BE4DE", "#2ec4b6")

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
  file_name = "figures/fig4.png",
  include_center = F,
  legend_title_centered = T,
  legend_break = T,
  height = 23 / 2
)

# run statistical tests
results_ci <- run_kruskal(likert_df_ci, likert_map)

# export results
generate_count_df(cols_ci, labs, "data/processed/fig4.csv")

# run statistical tests for geo differences
results_ci_geo <- run_kruskal_geo(likert_df_ci, likert_map)

# export results for geo differences
fwrite(results_ci_geo$continent_summary, "data/processed/fig4_geo.csv")


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
  colors = colors[2:5],
  file_name = "figures/supp_fig8.png",
  legend_break = T,
  height = 23 * 0.3
)

# run statistical tests
results_dg <- run_kruskal(likert_df_dg, likert_map)

# export results
generate_count_df(cols_dg, labs, "data/processed/supp_fig8.csv")

# run statistical tests for geo differences
results_dg_geo <- run_kruskal_geo(likert_df_dg, likert_map)

# export results for geo differences
fwrite(results_dg_geo$continent_summary, "data/processed/supp_fig8_geo.csv")

#### FUNC DT VARIANT ####

cols_dv <- 116:123

colnames(cleaned_data)[116:123] <- c(
  "I always review literature describing gene-level functional data when classifying variants",
  "Assay design details must be in ClinVar to use functional data for classification",
  "Disease mechanism must be specified in ClinVar to use functional data properly",
  "I would use ClinGen more if it showed confidence and accuracy metrics for functional data",
  "I would use functional data more if ClinVar linked to primary data sources",
  "Multiple sources of functional data should be shown on ClinVar like multiple lab classifications",
  "Conflicting functional data sources should all be shown on ClinVar",
  "I would use ClinVar's standardized functional data classifications (e.g, PS3_Strong)"
)

# define likert df
likert_df_dv <- make_likert_df(cleaned_data, cols_dv, labs)

# plot
plot_likert(
  likert_df_dv,
  colors = colors,
  file_name = "figures/supp_fig9.png",
  legend_break = T,
  height = 23 * 0.7
)

# run statistical tests
results_dv <- run_kruskal(likert_df_dv, likert_map)

# export results
generate_count_df(cols_dv, labs, "data/processed/supp_fig9.csv")

# run statistical tests for geo differences
results_dv_geo <- run_kruskal_geo(likert_df_dv, likert_map)

# export results for geo differences
fwrite(results_dv_geo$continent_summary, "data/processed/supp_fig9_geo.csv")