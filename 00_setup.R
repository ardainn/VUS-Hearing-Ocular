# define required packages
packages <- c("data.table", "dplyr", "eulerr", "ggplot2", "likert", "patchwork", "rnaturalearth", "scales", "tidyr", "showtext", "writexl")

# install any missing packages
installed <- packages %in% rownames(installed.packages())
if(any(!installed)) install.packages(packages[!installed])

# set working directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# load raw data
data <- read.csv('data/raw/AssessmentOfCurrentA_DATA_2025-08-18_0707.csv')

# assign labels
source("data/raw/AssessmentOfCurrentA_R_2025-08-18_0707.r")

# load fonts
library(showtext)
font_add("HelveticaNeue-Bold", "fonts/HelveticaNeueBold.otf")
font_add("HelveticaNeue-Roman", "fonts/HelveticaNeueRoman.otf")