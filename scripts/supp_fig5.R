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

#### FUNC EV GUIDELINES ####

# define cols
cols_fg <- 71:80

# update labels
colnames(cleaned_data)[cols_fg] <- c(
  "ACMG/AMP Guidelines",
  "ClinGen SVI WG Functional Evidence Guidelines (PS3/BS3)",
  "ClinGen SVI WG Splicing Evidence Guidelines",
  "ClinGen VCEP-specific Guidelines for Functional Evidence Use",
  "ClinGen SVI WG Functional Assay Assessment Worksheet",
  "ClinGen Specifications of ACMG/AMP Guidelines for Genetic Hearing Loss",
  "ClinGen HL Expert Panel Specifications v2.0",
  "ClinGen HL Expert Panel Specifications v1.0",
  "ClinGen LCA/EORD Expert Panel Specifications v1.0",
  "ClinGen Glaucoma Expert Panel Specifications v1.1"
)

# copy cleaned_data
cleaned_data_fg <- cleaned_data

# for V group, set questions 6-8 to NA
cols_V <- 76:78 
cleaned_data_fg[cleaned_data_fg$disease_domain == "V", cols_V] <- NA

# for H group, set questions 9-10 to NA
cols_H <- 79:80 
cleaned_data_fg[cleaned_data_fg$disease_domain == "H", cols_H] <- NA

# make Likert dataframe
likert_df_fg <- make_likert_df(cleaned_data_fg, cols_fg, labs)

# plot
plot_likert(
  likert_df_fg,
  colors = colors,
  lab_colors = lab_colors,
  file_name = "figures/supp_fig5.png",
  include_center = T,
  add_missing_center_perc = T,
  center_col = 4,
  height = 17.7
)

# run statistical tests
results_fg <- run_kruskal(likert_df_fg, likert_map)

# export results
generate_count_df(cols_fg, labs, "data/processed/supp_fig5.csv")

# run statistical tests for geo differences
results_fg_geo <- run_kruskal_geo(likert_df_fg, likert_map)

# export results for geo differences
fwrite(results_fg_geo$continent_summary, "data/processed/supp_fig5_geo.csv")
