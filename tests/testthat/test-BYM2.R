W <- matrix(c(0,1,0,1,0,1,0,1,0), byrow = T, ncol = 3)

test_that("check BYM2", {
  expect_length(getBYM2scale(W), 1)
})
