# get survey data and helper functions
source("../01_config.R")
source("../02_helpers.R")

# define plot colors
colors <- c("#C6E7E6",
            "#A9DAD9",
            "#8DCECC",
            "#70C2BF",
            "#54B6B2",
            "#439D9A")

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
  file_name = "likert_funcev_rsrc.png",
  include_center = T,
  center_col = 4,
  height = 23
)

# run chisq test
results_fr <- run_chisq(likert_df_fr, likert_map)

