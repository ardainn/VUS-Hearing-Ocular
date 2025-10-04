# get survey data and helper functions
source("_config.R")
source("_helper.R")

# define plot colors
colors <-  c("#b4e7c3", "#d4f4dd", "#ffe39f", "#ffb978", "#ff6b6b")

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
  file_name = "likert_funcev_chal.png",
  include_center = T,
  legend_title_centered = T,
  height = 23
)

# run chisq test
results_fh <- run_chisq(likert_df_fh, likert_map)
