x <- rnorm(10)

test_that("general checks", {
  expect_length(length(x), length(jinvlogit(10)))
  expect_error(jlogit(x))
})
