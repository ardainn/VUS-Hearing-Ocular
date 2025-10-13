# get survey data and helper functions
source("../01_config.R")
source("../02_helpers.R")

# define plot colors
colors <- c("#FFDAB9", "#FBC4AB", "#F8AD9D", "#F4978E", "#F08080")

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
colnames(cleaned_data)[c(48,49,51,53)] <- c("Biochemical assays",
                                            "Transcript assays",
                                            "In vitro gene-edited cell models to assess a specific disease mechanism",
                                            "Animal models in general")

# define likert df
likert_df_fc <- make_likert_df(cleaned_data, cols_fc, labs)

# plot
plot_likert(
  likert_df_fc,
  colors = colors,
  file_name = "likert_funcev_conf.png",
  include_center = T,
  #legend_break = T,
  height = 23
)

# run chisq test
results_fc <- run_chisq(likert_df_fc, likert_map)

