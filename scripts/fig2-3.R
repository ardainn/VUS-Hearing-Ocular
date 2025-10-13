# get survey data and helper functions
source("../01_config.R")
source("../02_helpers.R")

# define plot colors
colors <- c("#EAF7A1", "#7fcdbb", "#1d91c0")

# define labels
labs <- c("not performing", "performing", "expecting to perform")

#### PROF ACTIVITIES ####

# define cols
cols_pa <- 25:31

colnames(cleaned_data)[30:31] <- c("Partipication in multidisciplinary meetings",
                                   "Participation in ClinGen HL/VL groups")

# define likert df
likert_df_pa <- make_likert_df(cleaned_data, cols_pa, labs)

# plot
plot_likert(likert_df_pa, colors = colors, file_name = "likert_prof_activ.png")

# run fisher test
results_pa <- run_fisher(cleaned_data, likert_df_pa)


##### FUNC EV TASKS ####

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
plot_likert(likert_df_fe, colors = colors, file_name = "likert_funcev_task.png")

# run fisher test
results_fe <- run_fisher(cleaned_data, likert_df_fe)

