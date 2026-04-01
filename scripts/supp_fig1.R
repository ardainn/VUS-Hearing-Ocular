library(patchwork)
library(rnaturalearth)

#config
assign_colnames = F

# get survey data and helper functions
source("01_config.R")
source("02_helpers.R")

#### ORGANIZATIONS ####

# organization codes
org_map <- c(
  "1" = "Academic medical center",
  "2" = "Academic non-medical center",
  "3" = "Commercial laboratory",
  "4" = "Children's hospital",
  "5" = "Private practice",
  "6" = "Community hospital",
  "7" = "Government agency",
  "8" = "Pharmabiotech",
  "9" = "I'm retired",
  "10" = "Other"
)

# get count per organization
org_counts <- process_multi_response(cleaned_data, prefix = "organization", code_map = org_map)

# plot
p1 <- plot_stacked(org_counts, title = "Organizations by Disease Domain", x_limit = 60)

#### CURATION ORGANIZATIONS ####

# organization codes
cur_org_map <- c(
  "1" = "ClinGen",
  "2" = "Genomics England",
  "3" = "LOVD",
  "4" = "Orphanet",
  "5" = "GenCC",
  "6" = "Other"
)

# get count per curation organization
cur_org_counts <- process_multi_response(cleaned_data, prefix = "curation_orgs", code_map = cur_org_map)

# plot
p2 <- plot_stacked(cur_org_counts, title = "Curation Organizations by Disease Domain", x_limit = 60)


# merge organization plots to align them
merged_plot <- p1 / p2

ggsave(
  "dist_org.png",
  plot = merged_plot,
  width = 16,
  height = 12,
  units = "cm",
  dpi = 300
)

#### COUNTRIES ####

# count respondents per country
countries <- cleaned_data %>%
  count(country)

# create world object and merge
world_data <- ne_countries(scale = "medium", returnclass = "sf") %>%
  left_join(countries, by = c("name" = "country")) %>%
  filter(name != "Antarctica")

# plot map
p3 <- ggplot(world_data) +
  geom_sf(aes(fill = n)) +
  scale_fill_gradient(
    low = "#DCCEDE",
    high = "#694A6D",
    na.value = "grey90",
    breaks = c(0, 3, 6, 9, 12, 15, 18)
  ) +
  labs(
    title = "Origins of Respondents", 
    fill = "Density") +
  theme_minimal() +
  theme(
    text = element_text(size = 28, family = "HelveticaNeue-Bold"),
    plot.title = element_text(hjust = 0.5),
    legend.position = c(0.15, 0.3),
    legend.key.size = unit(0.25, "cm"))

# save
ggsave(
  "dist_countries.png",
  plot = p3,
  width = 13.62,
  height = 6.45,
  units = "cm",
  dpi = 300
)


#### CONFLICTING EVIDENCE ####

# sum data per domain
count_confev <- cleaned_data %>%
  filter(!is.na(conflicting_evidence)) %>%
  group_by(disease_domain, conflicting_evidence) %>%
  summarise(N = n(), .groups = "drop")


# get domains
domains <- unique(count_confev$disease_domain)

# list to store plots
pie_list <- list()

# plot
for (i in seq_along(domains)) {
  domain <- domains[i]
  domain_data <- count_confev %>% filter(disease_domain == domain)
  
  pie_list[[i]] <- plot_piechart(
    domain_data,
    "conflicting_evidence",
    colors = c("Yes" = "#B3A1FF", "No" = "#FFCF9F")
  )
}

# Optionally assign individual variables
p4a <- pie_list[[1]]
p4b <- pie_list[[2]]
p4c <- pie_list[[3]]

merged_plot2 <- p4a + p4b + p4c

ggsave(
  "figures/supp_fig1.png",
  plot = merged_plot2,
  width = 16,
  height = 8,
  units = "cm",
  dpi = 300
)
