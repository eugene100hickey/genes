#' Output the list of schizophrenia associated snps from Ripke (PMID:13595)
#'
#' @return a tibble of schizophrenia snps with a column labelled 'snps' and a column names 'genes
#' @export
#'
#' @examples ripke_snp()
ripke_snp <- function() {
  url <- "https://static-content.springer.com/esm/art%3A10.1038%2Fnature13595/MediaObjects/41586_2014_BFnature13595_MOESM77_ESM.xlsx"
  httr::GET(url, httr::write_disk(temp_file <- tempfile(fileext = ".xlsx"))) # downloads the .xlsx file
  df_brain <- xlsx::read.xlsx(temp_file,
                              sheetName = "brain eQTL",
                              startRow = 1,
                              colIndex = 1:12) # reads into a dataframe from brain sheet. Column headers are in the first row
  df_brain$eQTL.gene <- as.character(df_brain$eQTL.gene)
  df_brain$P.eQTL. <- as.character(df_brain$P.eQTL.)
  df_blood <- xlsx::read.xlsx(temp_file,
                              sheetName = "blood eQTL",
                              startRow = 1,
                              colIndex = 1:12) # reads into a dataframe from blood sheet. Column headers are in the first row
  df <- dplyr::bind_rows(df_brain, df_blood)
  unlink(temp_file)     # deletes the temporary file
  pins::pin(x = df, name = "ripke_snps")


  ##################################################################
  # returns df, a dataframe with a columns of the PGC snps
  #######################################################################
  df

}

