# load packages
library(data.table)
library(dplyr)
library(stringr)
library(writexl)

setDTthreads(12)

# set working directory
setwd("C:/Users/heyac/Downloads/clinvar_20250721.vcf/")

#### 1. IMPORT DATA ####

# import ClinVar VCF 
clinvar <- fread("clinvar_20250721.vcf", header = TRUE, na.strings = ".")
setDT(clinvar)

# import gene lists
hearing_loss_genes <- fread("hl_genes.txt", header = FALSE)[[1]]  # Vector of hearing loss genes
vision_loss_genes  <- fread("vl_genes.txt", header = FALSE)[[1]]  # Vector of vision loss genes

#### 2. EXTRACT FIELDS ####

# extract review status
clinvar[, review_status := sub(".*;CLNREVSTAT=([^;]+);CLNSIG=.*", "\\1", INFO)]
clinvar[nchar(review_status) >= 100, review_status := sub(".*;CLNREVSTAT=([^;]+);CLNVC=.*", "\\1", INFO)]

# extract clinical significance
clinvar[, clin_significance := sub(".*;CLNSIG=([^;]+);CLNSIGCONF=.*", "\\1", INFO)]
clinvar[nchar(clin_significance) >= 100, clin_significance := sub(".*;CLNSIG=([^;]+);CLNVC=.*", "\\1", INFO)]
clinvar[nchar(clin_significance) >= 100, clin_significance := sub(".*;CLNSIG=([^;]+);CLNSIGSCV=.*", "\\1", INFO)]
clinvar[nchar(clin_significance) >= 100, clin_significance := sub(".*;CLNSIGINCL=\\d+:(\\w+)", "\\1", INFO)]
clinvar[nchar(clin_significance) >= 100, clin_significance := "."]

# extract conflicting clinical significance
clinvar[, sig_conflict := sub(".*;CLNSIGCONF=([^;]+);CLNVC=.*", "\\1", INFO)]
clinvar[grepl("ALLELE", sig_conflict, fixed = TRUE), sig_conflict := "."]

#### 3. FILTER VARIANTS BY SIGNIFICANCE ####

# identify variants without B/LB classifications
no_benign <- clinvar[
  !grepl("benign", clin_significance, ignore.case = TRUE) &
    !grepl("benign", sig_conflict, ignore.case = TRUE)
]

# assign P/LP
pathogenic_variants <- copy(no_benign)
pathogenic_variants[grepl("Likely", sig_conflict), clin_significance := "Likely_pathogenic"]
pathogenic_variants[grepl("Pathogenic", sig_conflict), clin_significance := "Pathogenic"]
true_pathogenic <- pathogenic_variants[grepl("Pathogenic|Likely_pathogenic", clin_significance)]

# identify variants without P/LP classification
no_pathogenic <- clinvar[!grepl("patho", sig_conflict, ignore.case = TRUE)]

# assign B/LB
benign_variants <- copy(no_pathogenic)
benign_variants[grepl("Likely", sig_conflict), clin_significance := "Likely_benign"]
benign_variants[grepl("Benign", sig_conflict), clin_significance := "Benign"]
true_benign <- benign_variants[grepl("Benign|Likely_benign", clin_significance)]

# abbreviate classifications
true_pathogenic[grepl("Likely_pathogenic", clin_significance), class := "LP"]
true_pathogenic[grepl("Pathogenic", clin_significance), class := "P"]
true_benign[grepl("Likely_benign", clin_significance), class := "LB"]
true_benign[grepl("Benign", clin_significance), class := "B"]

# assign unique IDs
clinvar[, variant_id := paste(`#CHROM`, POS, ID, REF, ALT, sep = "_")]
true_benign[, variant_id := paste(`#CHROM`, POS, ID, REF, ALT, sep = "_")]
true_pathogenic[, variant_id := paste(`#CHROM`, POS, ID, REF, ALT, sep = "_")]

#### 4. IDENTIFY VARIANTS OF UNCERTAIN SIGNIFICANCE ####

# filter variants not in P/B sets
vus_variants <- clinvar[!(variant_id %in% true_benign$variant_id) & !(variant_id %in% true_pathogenic$variant_id)]

# assign class labels for VUS and conflicting interpretations
vus_variants[grepl("Uncertain_significance", clin_significance), class := "VUS"]
vus_variants[grepl("Conflicting", clin_significance), class := "CONF"]

# Optional: check variants that are neither VUS nor CONF
other_vus <- vus_variants[!class %in% c("VUS", "CONF")]

#### 5. COMBINE VARIANTS & HANDLE DUPLICATES ####

# combine variants
combined_variants <- rbind(true_benign, true_pathogenic, vus_variants, fill = TRUE)

# find duplicated variants
duplicated_variant_ids <- combined_variants$variant_id[
  duplicated(combined_variants$variant_id) | duplicated(combined_variants$variant_id, fromLast = TRUE)
]

# mark duplicates
combined_variants[variant_id %in% duplicated_variant_ids, class := "VUS"]

# Keep only one entry per variant_id (first occurrence)
unique_variants <- combined_variants[, .SD[1], by = variant_id]

#### 9. ASSIGN HL/VL TAGS ####

# extract gene name
unique_variants[, gene := str_extract(INFO, "(?<=GENEINFO=)[^:;]+")]

# mark variants for hearing loss and vision loss gene sets
unique_variants[, hearing_loss := gene %in% hearing_loss_genes]
unique_variants[, vision_loss := gene %in% vision_loss_genes]

# assign tags based on gene set
unique_variants[, domain := fifelse(
  hearing_loss & vision_loss, "H+V",
  fifelse(hearing_loss, "H",
          fifelse(vision_loss, "V", NA_character_))
)]

# filter to variants in HL/VL genes
filtered_variants <- unique_variants[!is.na(domain)]

#### 10. SUMMARIZE DISTRIBUTION ####

# check missing classes
#missing_class_variants <- filtered_variants[is.na(class)]

# Create distribution table by domain and class
distribution_hvl <- filtered_variants[, .N, by = .(domain, class)]

# View distribution
#write_xlsx(distribution_table, "distribution_table.xlsx")

