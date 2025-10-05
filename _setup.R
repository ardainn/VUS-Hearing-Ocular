# define required packages
packages <- c("data.table", "showtext", "writexl")

# install any missing packages
installed <- packages %in% rownames(installed.packages())
if(any(!installed)) install.packages(packages[!installed])
