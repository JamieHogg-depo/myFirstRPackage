#' addGroupID
#'
#' @param .data used in pipe setting
#' @param name non-character for the variable that will be added
#' @param ... grouping variables
#' @param concor logical (defaults to FALSE). If using the function to create a separate
#' concordance dataset set to TRUE, otherwise the function adds the column to the existing data.
#' @param all_combs logical (defaults to TRUE). Only applicable when `concor = TRUE`. Setting to FALSE
#' only generates an ID for the combinations in the given data.
#'
#' @return
#' @importFrom rlang :=
#' @export
#'
#' @examples
#' data(mtcars)
#'
#' # add sequential identifier for
#' # `gear` called `id`
#' mtcars %>%
#' addGroupID(id, gear)
addGroupID <- function(.data, name, ..., concor = F, all_combs = T){
  . <- NULL
  if(concor){
    if(all_combs){
      .data %>%
        dplyr::select(...) %>%
        dplyr::filter(!duplicated(.)) %>%
        tidyr::complete(...) %>%
        dplyr::group_by(...) %>%
        dplyr::summarise("{{name}}" := dplyr::cur_group_id(),
                         .groups = "drop") %>%
        dplyr::filter(stats::complete.cases(.))
    }else{
      .data %>%
        dplyr::group_by(...) %>%
        dplyr::summarise("{{name}}" := dplyr::cur_group_id(),
                         .groups = "drop")
    }
  }else{
    .data %>%
      dplyr::group_by(...) %>%
      dplyr::mutate("{{name}}" := dplyr::cur_group_id()) %>%
      dplyr::ungroup()
  }
}
