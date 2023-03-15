#' getUnique
#'
#' @param .data input data as used in a pipe
#'
#' @return Dataframe where the rows are the columns of `.data`. For each
#' variable the function returns the number of unique values, `nu_unique`, and what these
#' values are, `unique_values`. NOTE: Columns that are constant are not shown.
#' @export
#'
#' @examples
#' data(mtcars)
#' mtcars %>% getUnique()
getUnique <- function(.data){
  name <- n <- value <- NULL
  .data %>%
    purrr::map(~stringr::str_c(ifelse(is.na(unique(.x)), "NA", unique(.x)), collapse = ",")) %>%
    dplyr::bind_rows() %>%
    tidyr::pivot_longer(cols = dplyr::everything()) %>%
    dplyr::mutate(n = stringr::str_count(value, ",") + 1) %>%
    dplyr::relocate(name, n) %>%
    dplyr::filter(n > 1) %>%
    dplyr::arrange(dplyr::desc(n)) %>%
    dplyr::rename(column = name,
                  nu_unique = n,
                  unique_values = value)
}
