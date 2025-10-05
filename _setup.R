# Define required packages
packages <- c("tidyverse", "data.table", "ggplot2")

# İnstall any missing packages
installed <- packages %in% rownames(installed.packages())
if(any(!installed)) install.packages(packages[!installed])
