library(dplyr)
library(ggplot2)
library(patchwork)
library(tidyr)

# get survey data and helper functions
source("../01_config.R")
source("../02_helpers.R")

#### SCOPE OF VARIANT INT. ####

# get columns and factor mappings
var_vus_vol <- cleaned_data[, c(2, 33:38)]

factor_mappings <- list(
  variant_volume = mapping_variant_volume,
  reinterpretation_vus_1 = mapping_reinterpretation_vus_1,
  proportion_vus         = mapping_proportion_vus,
  functional_data_avail  = mapping_proportion_vus,
  reinterpretation_vus_2 = mapping_proportion_vus,
  conflicting_evidence   = mapping_conflicting_evidence
)

for (col in names(factor_mappings)) {
  set(
    var_vus_vol,
    j = col,
    value = factor(as.character(var_vus_vol[[col]]), levels = factor_mappings[[col]])
  )
}


# plot list with parameters
plot_info <- list(
  list(col = "variant_volume",title = "Variant Volume by Disease Domain", legend = TRUE),
  list(col = "proportion_vus", title = "VUS Proportion Due to Insufficient Data by Disease Domain"),
  list(col = "functional_data_avail", title = "Proportion of VUS Classified Using Functional Data"),
  list(col = "reinterpretation_vus_1", title = "VUS Reinterpreted by Disease Domain"),
  list(col = "reinterpretation_vus_2", title = "Proportion of VUS Reclassified Due to New Data")
)

# generate and save plots
plots <- lapply(plot_info, function(p) {
  g <- plot_hist(var_vus_vol, p$col, show_legend = isTRUE(p$legend))
  return(g)
})

# merge plots
merged_plot <- (plots[[1]]) / (plots[[2]] |
                plots[[3]]) / (plots[[4]] |
                plots[[5]])
ggsave(
  "hist_scope.png",
  plot = merged_plot,
  width = 16,
  height = 23,
  units = "cm",
  dpi = 300
)



