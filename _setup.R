# define required packages
packages <- c("data.table", "dplyr", "eulerr", "ggplot2", "likert", "patchwork", "rnaturalearth", "scales", "tidyr", "showtext", "writexl")

# install any missing packages
installed <- packages %in% rownames(installed.packages())
if(any(!installed)) install.packages(packages[!installed])
