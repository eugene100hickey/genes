#' Output the list of schizophrenia associated snps from Pardinas (PMID:29483656)
#'
#' @return a tibble of schizophreina snps with a column labelled 'snps' and a column names 'genes
#' @export
#'
#' @examples pardinas_snp()
pardinas_snp <- function() {
  url <- "https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5918692/bin/NIHMS958804-supplement-Supplementary_Table.xlsx"
  httr::GET(url, httr::write_disk(temp_file <- tempfile(fileext = ".xlsx"))) # downloads the .xlsx file
  df <- readxl::read_excel(temp_file, sheet = "Supp Table 4", skip = 7) # reads into a dataframe. First six rows of the excel file are just header
  unlink(temp_file)     # deletes the temporary file
  pins::pin(x = df, name = "pardinas_snps")


  ##################################################################
  # makes sz_snps, a dataframe with a column of the CLOZUK snps
  #######################################################################

  all_sz_genes <- df %>% dplyr::select(`Index SNP (dbSNP b141)`, `Gene(s) tagged`)
  names(all_sz_genes) <- c("snps", "genes")
  all_sz_genes
}
