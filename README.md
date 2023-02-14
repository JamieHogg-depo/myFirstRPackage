
# myFirstRPackage

<!-- badges: start -->
[![R-CMD-check](https://github.com/JamieHogg-depo/myFirstRPackage/workflows/R-CMD-check/badge.svg)](https://github.com/JamieHogg-depo/myFirstRPackage/actions)
[![Codecov test coverage](https://codecov.io/gh/JamieHogg-depo/myFirstRPackage/branch/main/graph/badge.svg)](https://codecov.io/gh/JamieHogg-depo/myFirstRPackage?branch=main)
<!-- badges: end -->

The goal of myFirstRPackage is to help me run some analysis. 

## Installation

You can install the released version of myFirstRPackage from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("myFirstRPackage")
```

## BYM2

The BYM2 prior requires the calculation of a scaling factor. This implementation requires a binary symmetric weight matrix, `W`. 

``` r
library(myFirstRPackage)
# Create a weight matrix
W <- matrix(c(0,1,0,1,0,1,0,1,0), byrow = T, ncol = 3)

# return the scale parameter
getBYM2scale(W)
```

## Advanced logit transformations

The logit transformations are used to convert a proportion to the unconstrained real line. These functions allows one to specify a different upper limit. For example, for some models we may want to model the variances which must be strictly between 0 and 0.25. These functions allow us to model on the unconstrained space and then convert to the correct range.  

```r
# works like normal logit function
jlogit(runif(10))

# simulate values between 0 and 0.25 to convert
(x <- runif(5, 0, 0.25))
x_unc <- jlogit(x, upper = 0.5)
jinvlogit(x_unc, upper = 0.5)
jinvlogit(x_unc, upper = 0.1)
```

## Unique values for each column

While working on large health datasets I found myself constantly interested in the the number and list of unique values in each column of a dataset. The `getUnique` function reports exactly this! 

```r
mtcars %>% getUnique()
```

