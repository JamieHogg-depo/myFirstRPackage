#' vectorSumtoZero
#'
#' @param n size of vector
#' @param fixed_sum defaults to zero
#' @param mean defaults to 0
#' @param sd defaults to 1
#'
#' @return numeric vector of length `n` from a normal distribution where
#' the sum of the vector is equal to `fixed_sum`. This is achieved by adjusting the final
#' observation.
#' @export
#'
#' @examples
#' vectorSumtoZero(10)
vectorSumtoZero <- function(n, fixed_sum = 0, mean = 0, sd = 1){
  init <- numeric(n)
  init[1:n-1] <- stats::rnorm(n-1, mean, sd)
  init[n] <- fixed_sum - sum(init[1:n-1])
  return(init)
}
