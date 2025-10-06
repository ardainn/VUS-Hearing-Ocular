# get survey data and helper functions
source("../01_config.R")
source("../02_helpers.R")

# define plot colors
colors <- c("#ffccd5", "#ffb3c1", "#ff8fa3", "#ff758f", "#ff4d6d")

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
  file_name = "likert_funcev_impr.png",
  include_center = T,
  legend_title_centered = T,
  split_legend = T,
  height = 23
)

# run chisq test
results_fi <- run_chisq(likert_df_fi, likert_map)

