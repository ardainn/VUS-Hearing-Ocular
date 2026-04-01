# get survey data and helper functions
if (!exists("cleaned_data")) {source("01_config.R")}
source("02_helpers.R")

# define plot colors
colors <- c("#15607a", "#7394a5", "#c7cdd1", "#cb724d", "#a63715")
lab_colors <- c("white","black","black","black","white")

# define and map labels
labs <- c(
  "not a challenge",
  "minor challenge",
  "occasionally a challenge",
  "moderate challenge",
  "significant challenge"
)
likert_map <- setNames(seq_along(labs), labs)

#### FUNC EV GUIDELINES ####

# define cols
cols_fh <- 82:94

# update labels
colnames(cleaned_data)[82:87] <- c(
  "Insufficient training on general functional evidence use",
  "Insufficient training on functional evidence for loss-of-function variants",
  "Insufficient training on functional evidence for gain-of-function variants",
  "Insufficient training on functional evidence for dominant negative variants",
  "Insufficient training on functional evidence when considering haploinsufficiency",
  "Insufficient training on functional evidence for reduced penetrance/variable expressivity"
)

# define likert df
likert_df_fh <- make_likert_df(cleaned_data, cols_fh, labs)

# plot
plot_likert(
  likert_df_fh,
  colors = colors,
  lab_colors = lab_colors,
  file_name = "figures/supp_fig6.png",
  include_center = T,
  legend_title_centered = T,
  height = 23
)

# run statistical tests
results_fh <- run_kruskal(likert_df_fh, likert_map)

# export results
generate_count_df(cols_fh, labs, "data/processed/supp_fig6.csv")

# run statistical tests for geo differences
results_fh_geo <- run_kruskal_geo(likert_df_fh, likert_map)

# export results for geo differences
fwrite(results_fh_geo$continent_summary, "data/processed/supp_fig6_geo.csv")
