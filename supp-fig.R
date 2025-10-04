library(patchwork)

# get survey data and helper functions
source("_config.R")
source("_helper.R")

#### DISEASE DOMAIN ####
count_domain <- cleaned_data[!is.na(disease_domain), .N, by = disease_domain]
p1 <- plot_piechart(count_domain, "disease_domain", "pie_domain.png", c("H" = "#9BBE74","H+V" = "#78B3CE","V" = "#F3AE91"))

#### LEADERSHIP ####
count_lead <- cleaned_data[!is.na(leadership), .N, by = leadership]
count_lead[, leadership := ifelse(leadership == "1", "Yes", "No")]
p2 <- plot_piechart(count_lead, "leadership", "pie_lead.png", c("Yes" = "#B3A1FF", "No" = "#FFCF9F"))

#### GENDER ####
count_gender <- cleaned_data[!is.na(gender), .N, by = gender]
count_gender[gender == "not specified", gender := "Not specified"]
p3 <- plot_piechart(count_gender, "gender", "pie_gender.png", c("Male" = "#6DAEDB", "Female" = "#FFA9E7", "Not specified" = "#B6ACE1"))

#### CONF EV ####
count_confev <- cleaned_data[!is.na(conflicting_evidence), .N, by = conflicting_evidence]
p4 <- plot_piechart(count_confev, "conflicting_evidence", "pie_confev.png", c("Yes" = "#B3A1FF", "No" = "#FFCF9F"))


merged_plot1 <- wrap_elements(p1, clip = FALSE) + wrap_elements(p2, clip = FALSE) + plot_layout(ncol = 2)

merged_plot2 <- wrap_elements(p3, clip = FALSE) + wrap_elements(p4, clip = FALSE) + plot_layout(ncol = 2)


ggsave(
  "dist_supp1.png",
  plot = merged_plot1,
  width = 16,
  height = 8,
  units = "cm",
  dpi = 300
)

ggsave(
  "dist_supp2.png",
  plot = merged_plot2,
  width = 16,
  height = 8,
  units = "cm",
  dpi = 300
)