# get survey data and helper functions
if (!exists("cleaned_data")) {source("01_config.R")}
source("02_helpers.R")

# define plot colors
colors <- c("#15607a", "#7394a5", "#c7cdd1", "#cb724d", "#a63715")
lab_colors <- c("white","black","black","black","white")

# define and map labels
labs <- c(
  "not confident at all",
  "slightly confident",
  "somewhat confident",
  "confident",
  "very confident"
)
likert_map <- setNames(seq_along(labs), labs)

#### FUNC EV CONFIDENCE ####

# define cols
cols_fc <- 48:60

# update column names
colnames(cleaned_data)[c(48,49,51,53,59,60)] <- c("Biochemical assays",
                                            "Transcript assays",
                                            "In vitro gene-edited cell models to assess a specific disease mechanism",
                                            "Animal models in general",
                                            "Fruit fly disease models for genes with human orthologs",
                                            "Fruit fly disease models for genes lacking human orthologs")

# define likert df
likert_df_fc <- make_likert_df(cleaned_data, cols_fc, labs)

# plot
plot_likert(
  likert_df_fc,
  colors = colors,
  lab_colors = lab_colors,
  file_name = "figures/fig2.png",
  include_center = T,
  #legend_break = T,
  height = 23
)

# run statistical tests
results_fc <- run_kruskal(likert_df_fc, likert_map)

# export results
generate_count_df(cols_fc, labs, "data/processed/fig2.csv")

# run statistical tests for geo differences
results_fc_geo <- run_kruskal_geo(likert_df_fc, likert_map)

# export results for geo differences
fwrite(results_fc_geo$continent_summary, "data/processed/fig2_geo.csv")
