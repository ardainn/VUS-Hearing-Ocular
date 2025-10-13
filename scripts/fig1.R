library(patchwork)
library(rnaturalearth)

# get survey data and helpers
source("../01_config.R")
source("../02_helpers.R")

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
    low = "#A786AC",
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

