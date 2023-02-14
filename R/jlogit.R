#' jlogit
#'
#' @param p vector of probabilities to convert to unconstrained space
#' @param upper numeric scalar (defaults to 1). Useful when using a adjusted logit transformation
#'
#' @return vector of unconstrained values
#' @export
#'
#' @examples
#' x <- runif(10)
#' jlogit(x)
jlogit <- function(p, upper = 1){
  if(any(p < 0 | p > 1)){
    stop("x should be constrained")
  }
  log(p/(upper-p))
}

#' jinvlogit
#'
#' @param eta vector of unconstrained variables to convert between 0 and upper
#' @param upper numeric scalar (defaults to 1). Useful when using a adjusted logit transformation
#'
#' @return vector of values constrained between 0 and `upper`
#' @export
#'
#' @examples
#' # Using standard implementation
#' x <- rnorm(10)
#' jinvlogit(x)
#'
#' # Using values between 0 and 0.5
#' jinvlogit(x, upper = 0.5)
jinvlogit <- function(eta, upper = 1){
  (upper * exp(eta))/(1+exp(eta))
}
