#' Download and load data from paper
#'
#' @return \code{tibble} with raw data used in paper
#' @export
#' @importFrom readxl read_xls
#' @examples
#' download_and_load_data()
download_and_load_data <- function() {
    link_to_data <- "https://osf.io/download/uh4z7/?view_only=de730bd958ef4711819216d30361c8d8"
    file_to_save <- "data_DMDDG.xls"
    
    if (!file.exists(file_to_save)) download.file(url = link_to_data, destfile = file_to_save)
    
    read_xls(file_to_save)
}
