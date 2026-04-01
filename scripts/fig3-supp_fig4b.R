# get survey data and helper functions
if (!exists("cleaned_data")) {source("01_config.R")}
source("02_helpers.R")

# define plot colors
colors <- c("black","#15607a", "#7394a5", "#c7cdd1", "#cb724d", "#a63715")
lab_colors <- c("white","white","black","black","black","white")

# define and map labels
labs <- c(
  "unaware of the resource",
  "not confident at all",
  "slightly confident",
  "somewhat confident",
  "confident",
  "very confident"
)
likert_map <- setNames(0:(length(labs) - 1), labs) # starts from 0

#### FUNC EV RESOURCES ####

# define cols
cols_fr <- 62:70

# update column names
colnames(cleaned_data)[c(63:65,69)] <- c("Sources with literature references to functional data",
                                            "Functional data within IMPC or MGI",
                                            "Functional data within ZFIN",
                                            "Functional predictors") 

# define likert df
likert_df_fr <- make_likert_df(cleaned_data, cols_fr, labs)

# plot
plot_likert(
  likert_df_fr,
  colors = colors,
  lab_colors = lab_colors,
  file_name = "figures/fig3.png",
  include_center = T,
  center_col = 4,
  height = 16
)

# run statistical tests
results_fr <- run_kruskal(likert_df_fr, likert_map)

# export results
generate_count_df(cols_fr, labs, "data/processed/fig3.csv")

# run statistical tests for geo differences
results_fr_geo <- run_kruskal_geo(likert_df_fr, likert_map)

# export results for geo differences
fwrite(results_fr_geo$continent_summary, "data/processed/fig3_geo.csv")

# plot results for df differences
plot_boxplot_geo(likert_df_fr, likert_map, 9, "figures/supp_fig4b.png")
