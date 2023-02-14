#' getUnique
#'
#' @param .data input data as used in a pipe
#'
#' @return Dataframe where the rows are the variables of `.data`. For each
#' variable the function returns the number of unique values, `n`, and what these
#' values are, `value`.
#' @export
#'
#' @examples
#' data(mtcars)
#' mtcars %>% getUnique()
getUnique <- function(.data){
  name <- n <- value <- NULL
  .data %>%
    purrr::map(~stringr::str_c(ifelse(is.na(unique(.x)), "NA", unique(.x)), collapse = ","))
}
