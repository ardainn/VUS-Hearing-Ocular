library(data.table)
library(dplyr)
library(ggplot2)
library(likert)
library(reshape2)
library(tidyr)

#### PROCESSING ####

# function to process multi-response columns
process_multi_response <- function(data, 
                                   prefix, 
                                   code_map, 
                                   domain_var = "disease_domain") {
  # find relevant columns
  cols <- grep(paste0("^", prefix), names(data), value = TRUE)
  
  # reshape to long format
  long_df <- melt(
    data[, c(domain_var, cols), with = FALSE],
    id.vars = domain_var,
    variable.name = "code",
    value.name = "selected"
  )
  
  # keep only selected
  long_df <- long_df %>% filter(selected == 1)
  
  # map numeric codes to names
  long_df$label <- sapply(long_df$code, function(x)
    code_map[[sub(paste0(prefix, "___"), "", x)]])
  
  # count per domain
  counts <- long_df %>%
    count(!!sym(domain_var), label)
  
  return(counts)
}

# function to construct likert dataframe
make_likert_df <- function(df, 
                           cols, 
                           labs) {
  # assign column names
  colnames(cleaned_data) <- trimws(sapply(seq_along(cleaned_data), function(i)
    attr(cleaned_data[[i]], "label") %||% colnames(cleaned_data)[i]))
  
  likert_df <- as.data.frame(df[, ..cols])
  likert_df[] <- lapply(likert_df, function(x)
    factor(x, levels = 1:length(labs), labels = labs))
  colnames(likert_df) <- paste0(LETTERS[seq_along(cols)], ". ", colnames(likert_df))
  likert_df
}


generate_count_df <- function(cols, labs, file_name, id_col = "disease_domain") {
  
  # convert numeric indices to names
  if (is.numeric(cols)) {
    cols <- names(cleaned_data)[cols]
  }
  
  # sentence case
  labs <- stringr::str_to_sentence(labs)
  
  # convert data
  count_df <- cleaned_data %>%
    select(all_of(c(id_col, cols))) %>%
    mutate(across(all_of(cols), ~ as.character(haven::as_factor(.)))) %>%
    pivot_longer(
      cols = all_of(cols),
      names_to = "variable",
      values_to = "value"
    ) %>%
    mutate(variable = factor(variable, levels = cols)) %>%   # <- IMPORTANT
    count(.data[[id_col]], variable, value) %>%
    arrange(variable) %>%                                     # <- preserves order
    pivot_wider(
      names_from = value,
      values_from = n,
      values_fill = 0
    )
  
  count_df$variable <- paste0(
    LETTERS[match(count_df$variable, unique(count_df$variable))],
    ". ",
    count_df$variable
  )
  
  # move NA column to end
  na_col <- which(names(count_df) == "NA")
  count_df <- count_df[, c(setdiff(seq_along(count_df), na_col), na_col)]
  
  # rename
  colnames(count_df)[1:(ncol(count_df)-1)] <- c("Disease domain", "Question", labs)

  
  fwrite(count_df, file_name)
  
}

#### PLOTTING ####

# function to plot stacked bar plots
plot_stacked <- function(counts,
                         domain_var = "disease_domain",
                         title = NULL,
                         x_limit = NULL) {
  levels_order <- c(setdiff(unique(counts$label), "Other"), "Other") 
  
  
  p <- ggplot(counts, aes(
    x = n,
    y = factor(label, levels = rev(levels_order)),
    fill = !!sym(domain_var)
  )) + geom_bar(stat = "identity", width = 0.9) + geom_text(
    aes(label = n),
    position = position_stack(vjust = 0.5),
    size = 5,
    color = "grey10"
  ) + labs(title = title, x = "Count", fill = "Domain") + theme_minimal() + theme(
    text = element_text(size = 24, family = "HelveticaNeue-Bold"),
    plot.title = element_text(hjust = 0.5),
    axis.title.y = element_blank(),
    legend.position = "right",
    legend.key.size = unit(8, "pt")
  ) + scale_fill_manual(values = c(
    "H" = "#9BBE74",
    "H+V" = "#78B3CE",
    "V" = "#F3AE91"
  )) 
  
  if (!is.null(x_limit)) {
    p <- p + scale_x_continuous(
      expand = c(0, 0),
      limits = c(0, x_limit),
      breaks = seq(0, x_limit, 5),
      minor_breaks = seq(0, x_limit, 1)
    )
  } 
  
  return(p)
}

# function to plot pie charts
plot_piechart <- function(data, 
                          col, 
                          output_file, 
                          colors) {
  pie_confev <- ggplot(data, aes(x = "", y = N, fill = .data[[col]])) +
    geom_col(width = 1, color = "white") +
    coord_polar(theta = "y") +
    geom_text(
      aes(label = paste0(N, " (", round(N / sum(
        N
      ) * 100), "%)")),
      position = position_stack(vjust = 0.5),
      family = "HelveticaNeue-Roman",
      size = 6
    ) +
    scale_fill_manual(values = colors) +
    theme_minimal(base_size = 24, base_family = "HelveticaNeue-Bold") +
    labs(title = "", fill = "Response") +
    theme(
      axis.title = element_blank(),
      axis.text = element_blank(),
      panel.grid = element_blank(),
      plot.title = element_text(hjust = 0.5),
      legend.key.size = unit(0.4, "lines"),
      legend.position = "bottom",
      legend.spacing.y = unit(0.02, "cm"),
      legend.margin = margin(
        t = 0,
        r = 0,
        b = 0,
        l = 0
      )
    )
  
  return(pie_confev)
}

# plot function for histograms
plot_hist <- function(data, 
                      x_col, 
                      show_legend = FALSE) {
  data_filtered <- data %>% filter(!is.na(.data[[x_col]]))
  
  # compute percentages within each disease_domain
  data_percent <- data_filtered %>%
    group_by(disease_domain, !!sym(x_col)) %>%
    summarise(n = n(), .groups = "drop") %>%
    group_by(disease_domain) %>%
    mutate(perc = n / sum(n) * 100)
  
  # plot
  ggplot(data_percent, aes(
    x = !!sym(x_col),
    y = perc,
    fill = disease_domain
  )) +
    geom_col(position = "dodge") +
    geom_text(
      aes(label = paste0(round(perc, 0), "%")),
      position = position_dodge(width = 0.9),
      vjust = -0.5,
      size = 5,
      family = "HelveticaNeue-Bold"
    ) +
    theme_minimal(base_size = 28, base_family = "HelveticaNeue-Bold") +
    labs(fill = "Domain") +
    theme(
      plot.title = element_text(hjust = 0.5),
      axis.text.x = element_text(angle = 45, hjust = 1),
      axis.title = element_blank(),
      legend.position = if (show_legend)
        "top"
      else
        "none",
      legend.key.size = unit(0.4, "lines"),
      axis.ticks = element_line(size = 0.3),
      panel.grid.major = element_line(size = 0.3),
      panel.grid.minor = element_line(size = 0.15),
      legend.key = element_rect(size = 0.3),
      axis.line = element_line(size = 0.3),
      legend.spacing.x = unit(0.05, "cm"),
      legend.spacing.y = unit(0.05, "cm"),
      legend.margin = margin(0, 0, 0, 0, "cm"),
      legend.box.margin = margin(0, 0, 0, 0)
    ) +
    scale_fill_manual(values = c(
      "H"   = "#9BBE74",
      "H+V" = "#78B3CE",
      "V"   = "#F3AE91"
    )) +
    scale_x_discrete(drop = FALSE) +
    scale_y_continuous(
      expand = c(0, 0),
      limits = c(0, 100),
      breaks = seq(0, 100, by = 20)
    )
}

# functions to plot likert
plot_likert <- function(likert_df,
                        colors,
                        file_name,
                        lab_colors = NULL,
                        include_center = TRUE,
                        legend_break = FALSE,
                        center_col = NULL,
                        legend_title_centered = FALSE,
                        split_legend = FALSE,
                        add_missing_center_perc = FALSE,
                        width = 16,
                        height = (24 * 7 / 13 - 1)) {
  
  # if label_colors not passed, default all
  if (is.null(lab_colors)) {
    lab_colors <- rep("black", length(colors))
  }
  
  # Prepare long format
  long_df <- likert_df %>%
    mutate(Group = factor(cleaned_data[[2]], levels = c("H", "H+V", "V"))) %>%
    pivot_longer(
      cols = -Group,
      names_to = "Item",
      values_to = "Response"
    ) %>%
    filter(!is.na(Response)) %>%
    group_by(Item, Group, Response) %>%
    summarise(Count = n(), .groups = "drop") %>%
    group_by(Item, Group) %>%
    mutate(Percentage = Count / sum(Count) * 100) %>%
    mutate(Group = factor(Group, levels = rev(c("H", "H+V", "V"))))
  
  
  # Make horizontal stacked bars, grouped vertically
  p <- ggplot(long_df, aes(x = Group, y = Percentage, fill = Response)) +
    geom_bar(stat = "identity", position = position_stack(reverse = TRUE)) +
    geom_text(aes(label = sprintf("%d%%", round(Percentage)), color = Response),
              position = position_stack(vjust = 0.5, reverse = T),
              size = 6,
              family = "HelveticaNeue-Roman",
              show.legend = F
    ) +
    scale_fill_manual(values = colors) +
    scale_color_manual(values = lab_colors) +
    facet_wrap(~Item, ncol = 1, strip.position = "top") +
    coord_flip() +
    theme_minimal() +
    theme(
      text = element_text(size = 28, family = "HelveticaNeue-Bold"),
      legend.position = "bottom",
      legend.box = "horizontal",
      legend.key.height = unit(0.25, "cm"),
      legend.key.width = unit(0.25, "cm"),
      strip.text = element_text(size = 24)
    )
  
  # Legend adjustments
  if (legend_title_centered) {
    p <- p +
      theme(legend.title = element_text(margin = margin(b = 10))) +
      guides(fill = guide_legend(title.position = "top", title.hjust = 0.5))
  }
  
  if (split_legend) {
    p <- p + guides(fill = guide_legend(title.position = "top", title.hjust = 0.5, nrow = 2))
  }
  
  ggsave(
    file_name,
    plot = p,
    width = width,
    height = height,
    units = "cm",
    dpi = 300
  )
}


plot_boxplot_geo <- function(likert_df, 
                             likert_map, 
                             item, 
                             file_name, 
                             width = 17, 
                             height = 10,
                             return_plot = F) {
  
  # continent mapping
  continent_map <- list(
    "Africa" = c("Mali", "Tunisia"),
    "Asia" = c("China", "India", "Iran", "Israel", "Japan",
               "Pakistan", "Qatar", "Singapore", "South Korea",
               "United Arab Emirates"),
    "Europe (excl. Germany)" = c("Belgium", "Czechia", "Denmark", "France",
                 "Greece", "Italy", "Netherlands", "Portugal",
                 "Slovakia", "Spain", "Switzerland", "United Kingdom"),
    "Germany" = c("Germany"),
    "United States" = c("United States of America"),
    "Oceania" = c("Australia"),
    "South America" = c("Argentina", "Brazil")
  )
  
  # assign continents
  cleaned_data$continent <- sapply(cleaned_data$country, function(ctry){
    cont <- names(continent_map)[sapply(continent_map, function(x) ctry %in% x)]
    if(length(cont) == 0) NA else cont
  })
  
  # keep continents with >=10 participants
  continent_counts <- table(cleaned_data$continent)
  groups <- names(continent_counts[continent_counts >= 10])
  filt_data <- cleaned_data[cleaned_data$continent %in% groups, ]
  likert_df_filt <- likert_df[cleaned_data$continent %in% groups, ]
  
  # convert Likert to numeric
  likert_numeric_df <- as.data.frame(
    lapply(likert_df_filt, function(col) likert_map[as.character(col)])
  )
  
  df <- data.frame(
    continent = filt_data$continent,
    value = likert_numeric_df[[item]]
  ) %>% filter(!is.na(value))
  
  # create pairwise comparisons
  comparisons <- combn(unique(df$continent), 2, simplify = FALSE)
  
  q <- colnames(likert_df)[[item]]
    
  plot_title <- if(grepl("\\. ", q)) sub(".*\\.\\s+", "", q) else q
  
  # plot
  p <- ggplot(df, aes(x = continent, y = value, fill = continent)) +
    geom_boxplot(outlier.shape = NA, alpha = 0.7) +
    geom_jitter(width = 0.15, height = 0.15, alpha = 0.4) +
    scale_y_continuous(labels = names(likert_map), breaks = as.numeric(likert_map)) +
    scale_fill_manual(values = c(
      "Asia" = "#FF9770",
      "Europe (excl. Germany)" = "#70D6FF",
      "Germany" = "#00CC92",
      "United States" = "#FF70A6"
    )) +
    stat_compare_means(method = "kruskal.test", label.y = Inf, vjust = 1.5, label.x = length(unique(df$continent))-0.5, size = 8, 
                       family = "HelveticaNeue-Roman") +
    stat_compare_means(
      comparisons = comparisons,
      method = "wilcox.test",
      label = "p.signif",
      size = 8, 
      family = "HelveticaNeue-Bold"
    ) +
    theme_minimal() +
    labs(
      title = plot_title,
      x = "Continent") +
    theme(
      text = element_text(size = 28, family = "HelveticaNeue-Bold"),
      axis.title = element_text(size = 28),
      axis.title.x = element_blank(), #element_text(size = 24, margin = margin(t = 15)),  
      axis.title.y = element_blank(),  
      axis.text = element_text(size = 28),
      legend.position = "none",
      strip.text = element_text(size = 28),
      plot.title = element_blank() #element_text(hjust = 0.5)  # center title
    )
  
  if (return_plot) {
    
    return(p)
    
  } else {
  
    ggsave(
      file_name,
      plot = p,
      width = width,
      height = height,
      units = "cm",
      dpi = 300
    )
    
  }
  
}


#### ANALYSIS ####

# function to run fisher's exact tests
run_fisher <- function(df, 
                       likert_df) {
  filt_df <- cbind(df$disease_domain, likert_df)
  colnames(filt_df)[1] <- "disease_domain"
  
  results <- data.frame(
    Activity = character(),
    Comparison = character(),
    P_value = numeric(),
    Odds_Ratio = numeric(),
    stringsAsFactors = FALSE
  )
  
  groups <- unique(filt_df$disease_domain)
  
  for (i in 2:ncol(filt_df)) {
    colname <- colnames(filt_df)[i]
    status_full <- ifelse(tolower(filt_df[[colname]]) == "performing",
                          "Performing",
                          "Not Performing")
    
    for (pair in combn(groups, 2, simplify = FALSE)) {
      rows <- filt_df$disease_domain %in% pair
      pair_df <- filt_df[rows, ]
      status <- status_full[rows]   # filter status to same rows
      
      tbl <- table(pair_df$disease_domain, status)
      
      test_result <- tryCatch(
        fisher.test(tbl),
        error = function(e)
          return(NULL),
        warning = function(w)
          return(NULL)
      )
      
      if (!is.null(test_result)) {
        results <- rbind(
          results,
          data.frame(
            Activity = colname,
            Comparison = paste(pair, collapse = " vs "),
            P_value = test_result$p.value,
            Odds_Ratio = ifelse(
              is.null(test_result$estimate),
              NA,
              unname(test_result$estimate)
            ),
            stringsAsFactors = FALSE
          )
        )
      }
    }
  }
  
  return(results)
}

# function to run chi-sq tests
run_chisq <- function(likert_df,
                      likert_map,
                      groups = c("H", "H+V", "V")) {
  # convert likert to numeric
  likert_numeric_df <- as.data.frame(lapply(likert_df, function(col)
    likert_map[as.character(col)]))
  
  # combine with disease domain from cleaned_data
  filt_df <- cbind(disease_domain = cleaned_data$disease_domain, likert_numeric_df)
  
  # init results list
  results <- list()
  
  # loop over columns
  for (i in 2:ncol(filt_df)) {
    colname <- colnames(filt_df)[i]
    
    # Overall chi-square test
    tbl <- table(filt_df$disease_domain, filt_df[[colname]])
    test_result <- tryCatch(
      chisq.test(tbl),
      error = function(e)
        NA,
      warning = function(w)
        suppressWarnings(chisq.test(tbl))
    )
    
    # pairwise comparisons
    pairwise_p <- list()
    for (g1 in 1:(length(groups) - 1)) {
      for (g2 in (g1 + 1):length(groups)) {
        sub_tbl <- table(filt_df$disease_domain %in% c(groups[g1], groups[g2]),
                         filt_df[[colname]])
        test <- tryCatch(
          chisq.test(sub_tbl),
          error = function(e)
            NA,
          warning = function(w)
            suppressWarnings(chisq.test(sub_tbl))
        )
        pairwise_p[[paste(groups[g1], groups[g2], sep = "_vs_")]] <- if (is.list(test))
          test$p.value
        else
          NA
      }
    }
    
    # median overall
    median_score <- median(filt_df[[colname]], na.rm = TRUE)
    
    # median per domain
    domain_medians <- sapply(groups, function(g) {
      median(filt_df[[colname]][filt_df$disease_domain == g], na.rm = TRUE)
    })
    names(domain_medians) <- paste0("Median_", groups)
    
    results[[colname]] <- list(
      table = tbl,
      overall_test = test_result,
      pairwise_p = pairwise_p,
      median_overall = median_score,
      median_domain = domain_medians
    )
  }
  
  # collect everything into a data.frame for reporting
  res_table <- do.call(rbind, lapply(names(results), function(name) {
    c(
      Item = name,
      Median_Overall = results[[name]]$median_overall,
      results[[name]]$median_domain,
      Overall_p = ifelse(is.list(results[[name]]$overall_test), results[[name]]$overall_test$p.value, NA),
      results[[name]]$pairwise_p
    )
  }))
  
  res_table <- as.data.frame(res_table, stringsAsFactors = FALSE)
  
  # convert numeric columns
  num_cols <- setdiff(colnames(res_table), "Item")
  res_table[num_cols] <- lapply(res_table[num_cols], as.numeric)
  
  return(list(results_list = results, summary_table = res_table))
}

# function to run kruskal-wallis tests
run_kruskal <- function(likert_df,
                        likert_map,
                        groups = c("H", "H+V", "V")) {
  
  # convert likert to numeric
  likert_numeric_df <- as.data.frame(lapply(likert_df, function(col)
    likert_map[as.character(col)]))
  
  # combine with disease domain
  filt_df <- cbind(disease_domain = cleaned_data$disease_domain,
                   likert_numeric_df)
  
  results <- list()
  
  for (i in 2:ncol(filt_df)) {
    
    colname <- colnames(filt_df)[i]
    
    # overall Kruskal-Wallis test
    kw_test <- tryCatch(
      kruskal.test(filt_df[[colname]] ~ filt_df$disease_domain),
      error = function(e) NA
    )
    
    # pairwise Wilcoxon tests
    pairwise_p <- list()
    
    for (g1 in 1:(length(groups)-1)) {
      for (g2 in (g1+1):length(groups)) {
        
        sub_data <- filt_df[filt_df$disease_domain %in% c(groups[g1], groups[g2]), ]
        
        test <- tryCatch(
          wilcox.test(sub_data[[colname]] ~ sub_data$disease_domain),
          error = function(e) NA
        )
        
        pairwise_p[[paste(groups[g1], groups[g2], sep="_vs_")]] <-
          if (is.list(test)) test$p.value else NA
      }
    }
    
    # median overall
    median_score <- median(filt_df[[colname]], na.rm = TRUE)
    
    # median per domain
    domain_medians <- sapply(groups, function(g) {
      median(filt_df[[colname]][filt_df$disease_domain == g], na.rm = TRUE)
    })
    
    names(domain_medians) <- paste0("Median_", groups)
    
    results[[colname]] <- list(
      overall_test = kw_test,
      pairwise_p = pairwise_p,
      median_overall = median_score,
      median_domain = domain_medians
    )
  }
  
  # summary table
  res_table <- do.call(rbind, lapply(names(results), function(name) {
    c(
      Item = name,
      Median_Overall = results[[name]]$median_overall,
      results[[name]]$median_domain,
      Overall_p = ifelse(is.list(results[[name]]$overall_test),
                         results[[name]]$overall_test$p.value, NA),
      results[[name]]$pairwise_p
    )
  }))
  
  res_table <- as.data.frame(res_table, stringsAsFactors = FALSE)
  
  num_cols <- setdiff(colnames(res_table), "Item")
  res_table[num_cols] <- lapply(res_table[num_cols], as.numeric)
  
  return(list(results_list = results,
              summary_table = res_table))
}

# function to run kruskal-wallis tests for geographical analysis
run_kruskal_geo <- function(likert_df, 
                            likert_map) {
  
  # define continents
  continent_map <- list(
    "Africa" = c("Mali", "Tunisia"),
    "Asia" = c("China", "India", "Iran", "Israel", "Japan",
               "Pakistan", "Qatar", "Singapore", "South Korea",
               "United Arab Emirates"),
    "Europe (excl. Germany)" = c("Belgium", "Czechia", "Denmark", "France",
                 "Greece", "Italy", "Netherlands", "Portugal",
                 "Slovakia", "Spain", "Switzerland", "United Kingdom"),
    "Germany" = c("Germany"),
    "United States" = c("United States of America"),
    "Oceania" = c("Australia"),
    "South America" = c("Argentina", "Brazil")
  )
  
  # assign continents
  cleaned_data$continent <- sapply(cleaned_data$country, function(ctry) {
    cont <- names(continent_map)[sapply(continent_map, function(x) ctry %in% x)]
    if (length(cont) == 0) NA else cont
  })
  
  # keep only continents with >=10 participants
  continent_counts <- table(cleaned_data$continent)
  groups <- names(continent_counts[continent_counts >= 10])
  
  # valid continents indices to keep
  rows_keep <- cleaned_data$continent %in% groups
  
  # filter BOTH datasets with the same rows
  filt_data <- cleaned_data[rows_keep, ]
  likert_df_filt <- likert_df[rows_keep, ]
  
  # convert Likert to numerics
  likert_numeric_df <- as.data.frame(lapply(likert_df_filt, function(col)
    likert_map[as.character(col)]))
  
  # combine with geographic info
  filt_df <- cbind(
    continent = filt_data$continent,
    country = filt_data$country,
    likert_numeric_df
  )
  
  results_continent <- list()
  results_country <- list()
  
  #### CONTINENT ANALYSIS ####
  for (i in 3:ncol(filt_df)) {
    colname <- colnames(filt_df)[i]
    
    # Kruskal-Wallis test across all continents
    test_result <- tryCatch(
      kruskal.test(filt_df[[colname]] ~ filt_df$continent),
      error = function(e) NA
    )
    
    # pairwise continent tests using Wilcoxon rank-sum
    pairwise_p <- list()
    for (g1 in 1:(length(groups) - 1)) {
      for (g2 in (g1 + 1):length(groups)) {
        
        subset_df <- filt_df[filt_df$continent %in% c(groups[g1], groups[g2]), ]
        
        test <- tryCatch(
          wilcox.test(subset_df[[colname]] ~ subset_df$continent),
          error = function(e) NA
        )
        
        pairwise_p[[paste(groups[g1], groups[g2], sep = "_vs_")]] <-
          if (is.list(test)) test$p.value else NA
      }
    }
    
    median_score <- median(filt_df[[colname]], na.rm = TRUE)
    
    continent_medians <- sapply(groups, function(g) {
      median(filt_df[[colname]][filt_df$continent == g], na.rm = TRUE)
    })
    names(continent_medians) <- paste0("Median_", groups)
    
    results_continent[[colname]] <- list(
      overall_test = test_result,
      pairwise_p = pairwise_p,
      median_overall = median_score,
      median_continent = continent_medians
    )
  }
  
  #### COUNTRY ANALYSIS ####
  country_counts <- table(filt_df$country)
  valid_countries <- names(country_counts[country_counts > 10])
  
  country_df <- filt_df[filt_df$country %in% valid_countries, ]
  
  for (i in 3:ncol(country_df)) {
    colname <- colnames(country_df)[i]
    
    # Kruskal-Wallis test across countries
    test_result <- tryCatch(
      kruskal.test(country_df[[colname]] ~ country_df$country),
      error = function(e) NA
    )
    
    median_score <- median(country_df[[colname]], na.rm = TRUE)
    
    country_medians <- sapply(valid_countries, function(cn) {
      median(country_df[[colname]][country_df$country == cn], na.rm = TRUE)
    })
    names(country_medians) <- paste0("Median_", valid_countries)
    
    results_country[[colname]] <- list(
      overall_test = test_result,
      median_overall = median_score,
      median_country = country_medians
    )
  }
  
  #### SUMMARY TABLES ####
  summary_continent <- do.call(rbind, lapply(names(results_continent), function(name) {
    
    pairwise_vals <- unlist(results_continent[[name]]$pairwise_p)
    
    c(
      Item = name,
      Median_Overall = results_continent[[name]]$median_overall,
      results_continent[[name]]$median_continent,
      pairwise_vals,
      Overall_p = ifelse(is.list(results_continent[[name]]$overall_test),
                         results_continent[[name]]$overall_test$p.value, NA)
    )
  }))
  
  summary_country <- do.call(rbind, lapply(names(results_country), function(name) {
    c(
      Item = name,
      Median_Overall = results_country[[name]]$median_overall,
      results_country[[name]]$median_country,
      Overall_p = ifelse(is.list(results_country[[name]]$overall_test),
                         results_country[[name]]$overall_test$p.value, NA)
    )
  }))
  
  summary_continent <- as.data.frame(summary_continent, stringsAsFactors = FALSE)
  summary_country <- as.data.frame(summary_country, stringsAsFactors = FALSE)
  
  num_cols1 <- setdiff(colnames(summary_continent), "Item")
  summary_continent[num_cols1] <- lapply(summary_continent[num_cols1], as.numeric)
  
  num_cols2 <- setdiff(colnames(summary_country), "Item")
  summary_country[num_cols2] <- lapply(summary_country[num_cols2], as.numeric)
  
  return(list(
    continent_results = results_continent,
    continent_summary = summary_continent,
    country_results = results_country,
    country_summary = summary_country
  ))
}

