# get survey data and helper functions
if (!exists("cleaned_data")) {source("01_config.R")}
source("02_helpers.R")

library(ggpubr)

# define plot colors
colors <- c("#EAF7A1", "#7fcdbb", "#1d91c0")
lab_colors <- c("black","black","white")

# define labels
labs <- c("not performing", "performing", "expecting to perform")
likert_map <- setNames(seq_along(labs), labs)

#### PROF ACTIVITIES ####

# define cols
cols_pa <- 25:31

colnames(cleaned_data)[30:31] <- c("Partipication in multidisciplinary meetings",
                                   "Participation in ClinGen HL/VL groups")

# define likert df
likert_df_pa <- make_likert_df(cleaned_data, cols_pa, labs)

# plot
plot_likert(likert_df_pa, colors = colors, lab_colors = lab_colors, file_name = "figures/fig1.png")

# run statistical tests
results_pa <- run_kruskal(likert_df_pa, likert_map)

# export results
generate_count_df(cols_pa, labs, "data/processed/fig1.csv")

# run statistical tests for geo differences
results_pa_geo <- run_kruskal_geo(likert_df_pa, likert_map)

# plot the results for geo differences
fwrite(results_pa_geo$continent_summary, "data/processed/fig1_geo.csv")


##### FUNC EV TASK####

# define cols
cols_fe <- 40:46

colnames(cleaned_data)[45:46] <-
  c(
    "Request functional evidence from labs specialized in hearing/vision research",
    "Request functional evidence from labs on basic mechanisms or protein properties"
  )

# define likert df
likert_df_fe <- make_likert_df(cleaned_data, cols_fe, labs)


# plot
plot_likert(likert_df_fe, colors = colors, lab_colors = lab_colors, file_name = "figures/supp_fig3.png")

# run statistical tests
results_fe <- run_kruskal(likert_df_fe, likert_map)

# export results
generate_count_df(cols_fe, labs, "data/processed/supp_fig3.csv")

# run statistical tests
results_fe_geo <- run_kruskal_geo(likert_df_fe, likert_map)

# export results for geo differences
fwrite(results_fe_geo$continent_summary, "data/processed/supp_fig3_geo.csv")

# plot the results for geo differences
plot_boxplot_geo(likert_df_fe, likert_map, 5, "figures/supp_fig4a.png")
