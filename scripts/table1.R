library(data.table)

make_wide_summary <- function(data = cleaned_data, row_var, col_var = "disease_domain") {
  
  # count rows per row_var x col_var
  df <- data[!is.na(get(col_var)),
             .N,
             by = c(row_var, col_var)]
  
  # pivot to wide format
  wide_df <- dcast(data = df, formula = as.formula(paste(row_var, "~", col_var)),
                   value.var = "N", fill = 0)
  setDT(wide_df)
  
  wide_df[, Total := H + `H+V` + V]
  
  # identify numeric columns (domains)
  domain_cols <- setdiff(names(wide_df), row_var)
  for (col in domain_cols) wide_df[[col]] <- as.numeric(wide_df[[col]])
  
  # compute column totals
  col_totals <- sapply(domain_cols, function(x) sum(wide_df[[x]], na.rm = TRUE))
  
  # format counts with column-wise percentages
  pretty_df <- copy(wide_df)
  for (col in domain_cols) {
    pretty_df[[col]] <- paste0(round(wide_df[[col]] / col_totals[col] * 100),
      "%"
    )
  }
   
  return(pretty_df)
}

tab1 <- make_wide_summary(row_var = "gender")
tab2 <- make_wide_summary(row_var = "leadership")
tab3 <- make_wide_summary(row_var = "professional_position")
tab4 <- make_wide_summary(row_var = "years_professional_experience")



