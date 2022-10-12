
# myFirstRPackage

<!-- badges: start -->
<!-- badges: end -->

The goal of myFirstRPackage is to help me run some analysis. 

## Installation

You can install the released version of myFirstRPackage from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("myFirstRPackage")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(myFirstRPackage)
# Create a weight matrix
W <- matrix(c(0,1,0,1,0,1,0,1,0), byrow = T, ncol = 3)

# return the scale parameter
getBYM2scale(W)
```

