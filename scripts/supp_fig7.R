# get survey data and helper functions
if (!exists("cleaned_data")) {source("01_config.R")}
source("02_helpers.R")

# define plot colors
colors <- c("#15607a", "#7394a5", "#c7cdd1", "#cb724d", "#a63715")
lab_colors <- c("white","black","black","black","white")

# define and map labels
labs <- c(
  "not useful",
  "would slightly improve use",
  "would somewhat improve use",
  "would moderately improve use",
  "would significantly improve use"
)
likert_map <- setNames(seq_along(labs), labs)

#### FUNC EV IMPROVEMENTS ####

# define cols
cols_fi <- 96:106

# update labels
colnames(cleaned_data)[c(96,106)] <- c("Workshops at professional meetings on the use of functional evidence",
                                "Ability to request generation of deep mutational scanning data for a specific gene")

# define likert df
likert_df_fi <- make_likert_df(cleaned_data, cols_fi, labs)

# plot
plot_likert(
  likert_df_fi,
  colors = colors,
  lab_colors = lab_colors,
  file_name = "figures/supp_fig7.png",
  include_center = T,
  legend_title_centered = T,
  split_legend = T,
  height = 23 * 11 / 13
)

# run statistical tests
results_fi <- run_kruskal(likert_df_fi, likert_map)

# export results
generate_count_df(cols_fi, labs, "data/processed/supp_fig7.csv")

# run statistical tests for geo differences
results_fi_geo <- run_kruskal_geo(likert_df_fi, likert_map)

# export results for geo differences
fwrite(results_fi_geo$continent_summary, "data/processed/supp_fig7_geo.csv")