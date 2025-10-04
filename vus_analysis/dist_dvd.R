library(data.table)
library(writexl)

setDTthreads(12)

# set working directory
Sys.setlocale(category = "LC_ALL", locale = "Turkish")
setwd("C:/Users/heyac/OneDrive/vus_survey/analysis")

dvd <- fread("C:/Users/heyac/Downloads/DVD.r9.2021-01-04.download.tsv/DVD.r9.2020-12-28.download.tsv")

dvd[, (names(dvd)) := lapply(.SD, function(x) {
  if (is.character(x)) {
    x <- gsub("%20", " ", x)
    x <- gsub("%2C", ",", x)
  }
  x
})]

colnames(dvd)[1:5] <- colnames(dvd)[2:6]
colnames(dvd)[6] <- "X"
dvd$X <- NULL

dvd[FINAL_PATHOGENICITY == "Benign*", FINAL_PATHOGENICITY := "Benign"]

genes <- levels(as.factor(dvd$GENE))
dist_cls <- as.data.frame(table(dvd$FINAL_PATHOGENICITY))
dist_cls$Perc <- dist_cls$Freq / sum(dist_cls$Freq)

colnames(dist_cls) <- c("class","N","%")

write_xlsx(dist_cls, "dist_dvd.xlsx")
