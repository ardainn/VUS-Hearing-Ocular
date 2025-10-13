library(data.table)
library(dplyr)
library(ggplot2)
library(likert)
library(reshape2)

#### PROCESSING ####

# function to process multi-response columns
process_multi_response <- function(data, prefix, code_map, domain_var = "disease_domain") {
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
make_likert_df <- function(df, cols, labs) {
  # assign column names
  colnames(cleaned_data) <- trimws(sapply(seq_along(cleaned_data), function(i)
    attr(cleaned_data[[i]], "label") %||% colnames(cleaned_data)[i]))
  
  likert_df <- as.data.frame(df[, ..cols])
  likert_df[] <- lapply(likert_df, function(x)
    factor(x, levels = 1:length(labs), labels = labs))
  colnames(likert_df) <- paste0(LETTERS[seq_along(cols)], ". ", colnames(likert_df))
  likert_df
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
plot_piechart <- function(data, col, output_file, colors) {
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
plot_hist <- function(data, x_col, show_legend = FALSE) {
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
    theme_classic(base_size = 28, base_family = "HelveticaNeue-Bold") +
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

# function to plot likert
plot_likert <- function(likert_df,
                        colors,
                        file_name,
                        include_center = T,
                        legend_break = F,
                        center_col = NULL,
                        legend_title_centered = F,
                        split_legend = F,
                        add_missing_center_perc = F,
                        width = 16,
                        height = 24 * 7 / 13 - 1) {
  likert_obj <- likert(items = likert_df, grouping = as.factor(cleaned_data[[2]]))
  
  
  # plot likert
  if (!is.null(center_col)) {
    p <- plot(
      likert_obj,
      colors = colors,
      centered = T,
      center = center_col,
      include.center = include_center,
      wrap = 150,
      group.order = c("H", "H+V", "V")
    )
  } else {
    p <- plot(
      likert_obj,
      colors = colors,
      centered = T,
      include.center = include_center,
      wrap = 150,
      group.order = c("H", "H+V", "V")
    )
  }
  
  # modify text layers
  for (i in seq_along(p$layers)) {
    if ("GeomText" %in% class(p$layers[[i]]$geom)) {
      p$layers[[i]]$aes_params$size <- 6
      p$layers[[i]]$aes_params$family <- "HelveticaNeue-Roman"
    }
  }
  
  p <- p + theme_minimal() + theme(
    text = element_text(size = 28, family = "HelveticaNeue-Bold"),
    legend.position = "bottom",
    legend.box = "horizontal",
    legend.key.height = unit(0.25, "cm"),
    legend.key.width = unit(0.25, "cm"),
    #legend.title = element_text(margin = margin(b = 10))
  )
  
  # explicitly remove center from colors and labels
  if (legend_break) {
    # calculate center if not defined
    if (is.null(center_col)) {
      center_col = ceiling(length(levels(likert_df[[1]])) / 2)
      print(center_col)
    }
    
    p <- p + scale_fill_manual(
      values = colors[-center_col],
      breaks = levels(likert_df[[1]])[-center_col],
      name = "Response"
    )
  }
  
  # center legend title if too long
  if (legend_title_centered) {
    p <- p +
      theme(legend.title = element_text(margin = margin(b = 10))) +
      guides(fill = guide_legend(title.position = "top", title.hjust = 0.5))
  }
  
  # split legend into two rows if still too
  if (split_legend) {
    p <- p + guides(fill = guide_legend(
      title.position = "top",
      title.hjust = 0.5,
      nrow = 2
    ))
    
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

#### ANALYSIS ####

# function to run fisher's exact tests
run_fisher <- function(df, likert_df) {
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
