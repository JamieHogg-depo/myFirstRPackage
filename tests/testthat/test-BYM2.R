W <- matrix(c(0,1,0,
              1,0,1,
              0,1,0), byrow = T, ncol = 3)
W2 <- matrix(c(0,1,0,
              0,0,1,
              0,1,0), byrow = T, ncol = 3)

W3 <- matrix(c(0,0.4,0,
               0.4,0,1,
               0,1,0), byrow = T, ncol = 3)

W4 <- matrix(c(0,1,0,
               1,1,1,
               0,1,0), byrow = T, ncol = 3)

W5 <- matrix(rnorm(6), byrow = T, ncol = 3)

W6 <- matrix(c(0,1,0,0,
               1,0,1,0,
               0,1,0,0,
               0,0,0,0), byrow = T, ncol = 4)

test_that("Output checks", {
  expect_length(getBYM2scale(W), 1)
  expect_type(getBYM2scale(W), "double")
  expect_error(getBYM2scale(W2), "Matrix is not symmetric...")
  expect_gt(getBYM2scale(W), 0)
  expect_error(getBYM2scale(W3))
  expect_error(getBYM2scale(W4), "Diagonals must be zero...")
  expect_error(getBYM2scale(W5), "Diagonals must be zero...")
  expect_error(getBYM2scale(W6), "Graph not fully connected...")
})

test_that("Value of output", {
  expect_equal(round(getBYM2scale(W),7), 0.4093368)
})
