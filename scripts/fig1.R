library(dplyr)
library(eulerr)
library(ggplot2)
library(patchwork)
library(rnaturalearth)
library(scales)

# get survey data
source("../01_config.R")

#### PROFESSIONAL POSITIONS ####

# count positions per domain
count_by_domain_position <- cleaned_data %>%
  count(disease_domain, professional_position)

# convert to wide format
position_counts <- dcast(
  count_by_domain_position,
  professional_position ~ disease_domain,
  value.var = "n",
  fill = 0
)

# define levels and reorder
position_levels <- c(setdiff(
  unique(count_by_domain_position$professional_position),
  "Other"
), "Other")

# get and save totals
position_counts[, Total := H + H + V + V]
write_xlsx(position_counts, "dist_roles.xlsx")

# plot
p1 <- ggplot(count_by_domain_position,
            aes(
              x = n,
              y = factor(professional_position, levels = rev(position_levels)),
              fill = disease_domain
            )) +
  geom_bar(stat = "identity", width = 0.9) +
  geom_text(
    aes(label = n),
    position = position_stack(vjust = 0.5),
    size = 5,
    color = "grey10"
  ) +
  labs(
    title = "Professional Positions by Disease Domain",
    x = "Count",
    #y = "Professional Position",
    fill = "Domain"
  ) +
  theme_minimal() +
  theme(
    text = element_text(size = 24, family = "HelveticaNeue-Bold"),
    plot.title = element_text(hjust = 0.5),
    axis.title.y = element_blank(),
    legend.position = "right",
    legend.key.size = unit(8, "pt"),
  ) +
  scale_fill_manual(values = c(
    "H" = "#9BBE74",
    "H+V" = "#78B3CE",
    "V" = "#F3AE91"
  )) +
  scale_x_continuous(
    expand = c(0, 0),
    limits = c(0, 25),
    breaks = seq(0, 25, by = 5),
    minor_breaks = seq(0, 25, by = 1)
  )

ggsave(
  "dist_roles.png",
  plot = p1,
  width = 13.02,
  height = 3.72,
  units = "cm",
  dpi = 300
)

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

# function to process data for the disease domain
# function to plot euler
plot_euler <- function(data, file_name, domain_filter = c("H", "H+V","V"), prefix, cols, code_map) {
  
  # define colors
  colors <- c("#c9e6f1","#82c7ed","#ffd5bf","#ffc480","#ffeea5","#f4a8db","#FFBBAD","#ff9480")
  
  # filter rows by domain
  binary_data <- data[disease_domain %in% domain_filter, cols, with = FALSE]
  binary_data <- binary_data[, lapply(.SD, as.numeric)]
  
  # remove rows with all zeros (no selections)
  binary_data <- binary_data[rowSums(binary_data) > 0, ]
  
  # get combination labels
  get_set_labels <- function(row, names) {
    paste(names[which(row == 1)], collapse = "&")
  }
  set_labels <- apply(binary_data, 1, get_set_labels, names = colnames(binary_data))
  
  # construct frequency table
  combo_table <- table(set_labels)
  venn_data <- data.frame(
    labels = names(combo_table),
    Freq = as.integer(combo_table),
    stringsAsFactors = FALSE
  )
  
  # map numeric codes to names
  venn_data$labels <- sapply(venn_data$labels, function(x) {
    if (x == "") return(NA)  # convert empty to NA
    parts <- unlist(strsplit(x, "&"))
    parts_mapped <- sapply(parts, function(y) {
      code <- sub(prefix, "", y)
      code_map[[code]]
    })
    paste(parts_mapped, collapse = "&")
  })
  
  # remove NA labels
  venn_data <- venn_data[!is.na(venn_data$labels), ]
  
  # create euler vector
  freq_vector <- setNames(venn_data$Freq, venn_data$labels)
  
  # fit euler diagram
  fit <- euler(freq_vector, loss_aggregator = "max")
  
  # get num of circlers
  n_circles <- sum(sapply(binary_data, function(col) any(col != 0)))
  
  # plot
  p <- plot(fit,
            fills = list(fill = colors[1:n_circles]),
            labels = list(font = 2, cex = 1.5, fontfamily = "HelveticaNeue-Bold"),
            quantities = list(fontfamily = "HelveticaNeue-Roman", cex = 1.25),
            edges = list(fill = colors[1:n_circles], alpha = 0.15))
  
  # suppress zeroes
  for(i in seq_along(p$children$canvas.grob$children$diagram.grob.1$children$tags$children)){
    o <- p$children$canvas.grob$children$diagram.grob.1$children$tags$children[[paste0("tag.number.", i)]]
    if(!is.null(o)){
      if ( o$children[[paste0("tag.quantity.",i)]]$label == 0){ 
        o$children[[paste0("tag.quantity.",i)]]$label <- " "
        p$children$canvas.grob$children$diagram.grob.1$children$tags$children[[paste0("tag.number.", i)]] <- o
      }
    }
  }
  
  # save
  #png(file_name, width = 7.84, height = 6.83, units = "cm", res = 300)
  return(p)
  #dev.off()
}

# plot dist of organizations
p2 <- plot_euler(
      cleaned_data,
      file_name = "dist_org.png",
      prefix = "organization___",
      cols = 3:12,
      code_map = org_map
)

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

# plot dist of curation organizations
p3 <- plot_euler(
      cleaned_data,
      file_name = "dist_cur_org.png",
      prefix = "curation_orgs___",
      cols = 17:22,
      code_map = cur_org_map
)

#### YEARS OF EXPERIENCE ####

# define ordered levels
years_levels <- c("0-5", "6-10", "11-15", "16-20", "More than 20")

# count positions per domain, calculate percentages, and set factor levels
df_percent <- cleaned_data %>%
  count(disease_domain, years_professional_experience) %>%
  group_by(disease_domain) %>%
  mutate(
    percentage = n / sum(n),
    years_professional_experience = factor(years_professional_experience, levels = rev(years_levels))
  ) %>%
  ungroup()

# assign color gradient
experience_colors <- setNames(scales::seq_gradient_pal("#dadaeb", "#A347FF", "Lab")(seq(0, 1, length.out = length(years_levels))),
                              years_levels)

# plot
p4 <- ggplot(
  df_percent,
  aes(y = disease_domain, x = percentage, fill = years_professional_experience)
) +
  geom_bar(stat = "identity",
           position = "stack",
           width = 0.7) +
  geom_text(
    aes(label = percent(percentage, accuracy = 1)),
    position = position_stack(vjust = 0.5),
    size = 6,
    color = "black",
    family = "HelveticaNeue-Roman"
  ) +
  scale_fill_manual(values = experience_colors) +
  scale_x_continuous(labels = percent_format(), expand = c(0, 0)) +
  labs(
    title = "Distribution of Years of Experience by Disease Domain",
    x = "Percentage",
    #y = "Domain",
    fill = "Years"
  ) +
  theme_minimal() +
  theme(
    text = element_text(size = 28, family = "HelveticaNeue-Bold"),
    axis.title.x = element_text(margin = margin(t = 10)),
    #axis.title.y = element_text(margin = margin(r = 5)),
    legend.title = element_blank(),
    axis.title.y = element_blank(),
    plot.title = element_text(hjust = 0.5),
    legend.position = "right",
    legend.key.size = unit(0.25, "cm")
  )

# save
ggsave(
  "dist_exp.png",
  plot = p4,
  width = 13.02,
  height = 3.72,
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
p5 <- ggplot(world_data) +
  geom_sf(aes(fill = n)) +
  scale_fill_gradient(
    low = "#cae5ee",
    high = "#006479",
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
  plot = p5,
  width = 13.62,
  height = 6.45,
  units = "cm",
  dpi = 300
)

#### PATCHWORK ####

# merge plots
merged_plot <- (wrap_elements(p1, clip = FALSE)) /
  (wrap_elements(p2, clip = FALSE) | wrap_elements(p3, clip = FALSE)) /
  wrap_elements(p4, clip = FALSE) /
  wrap_elements(p5, clip = FALSE) +
  plot_layout(heights = c(2.5, 4, 2, 4))



ggsave(
  "dist_demog.png",
  plot = merged_plot,
  width = 16,
  height = 23,
  units = "cm",
  dpi = 300
)


