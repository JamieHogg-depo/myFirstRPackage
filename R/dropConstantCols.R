#' dropConstantCols
#'
#' @param .data input data as used in a pipe
#' @param verbose logical (defaults to FALSE). Setting to TRUE prints the dropped variables to the console.
#'
#' @return Version of `.data` where any columns that have no unique values are dropped.
#' @export
#'
#' @examples
#' data(mtcars)
#' mtcars$constant <- "Same all along"
#' mtcars %>% dropConstantCols()
dropConstantCols <- function(.data, verbose = F){
  name <- n <- value <- NULL
  idss <- .data %>%
    purrr::map(~stringr::str_c(unique(.x), collapse = ",")) %>%
    dplyr::bind_rows() %>%
    tidyr::pivot_longer(cols = dplyr::everything()) %>%
    dplyr::mutate(n = stringr::str_count(value, ",") + 1) %>%
    dplyr::relocate(name, n) %>%
    dplyr::filter(n == 1)
  to_remove <- which(colnames(.data) %in% idss$name)

  # print message
  if(verbose){
    message("Dropped ", paste(idss$name, collapse = ", "))
  }

  # return data
  .data %>%
    dplyr::select(-dplyr::all_of(to_remove))
}
