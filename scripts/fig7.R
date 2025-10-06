# get survey data and helper functions
source("_config.R")
source("_helper.R")

# define plot colors
colors <- c("#DCCABC",
            "#CEB5A1",
            "#C0A087",
            "#B28C6C",
            "#A07754",
            "#866346")

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

# define likert df
likert_df_fg <- make_likert_df(cleaned_data, cols_fg, labs)

# plot
plot_likert(
  likert_df_fg,
  colors = colors,
  file_name = "likert_funcev_gdln.png",
  include_center = T,
  add_missing_center_perc = T,
  center_col = 4,
  height = 23
)

# run chisq test
results_fg <- run_chisq(likert_df_fg, likert_map)
