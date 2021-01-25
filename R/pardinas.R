#' Output the list of schizophrenia associated genes from Pardinas (PMID:29483656)
#'
#' @return a tibble of schizophreina genes with one column labelled 'genes'
#' @export
#'
#' @examples pardinas()
pardinas <- function() {
  url <- "https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5918692/bin/NIHMS958804-supplement-Supplementary_Table.xlsx"
  httr::GET(url, httr::write_disk(temp_file <- tempfile(fileext = ".xlsx"))) # downloads the .xlsx file
  df <- readxl::read_excel(temp_file, sheet = 4, skip = 3) # reads into a dataframe. First six rows of the excel file are just header
  unlink(temp_file)     # deletes the temporary file
  pins::pin(x = df, name = "pardinas_genes")


  ##################################################################
  # makes sz_genes, a dataframe with a single column of the CLOZUK genes
  #######################################################################

  all_sz_genes <- df$`Gene(s) tagged` %>%
    stringr::str_split(",") %>%
    unlist() %>%
    as.data.frame() %>%
    dplyr::distinct() %>%
    stringr::str_trim()
  names(all_sz_genes) <- "genes"
  all_sz_genes %>% tibble::as_tibble()
}
