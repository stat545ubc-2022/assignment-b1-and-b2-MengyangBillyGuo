
test_that("Testing my function", {
  expect_equal(ncol(scale_by_median(mtcars,mtcars$cyl)),  12)
  expect_equal(nrow(scale_by_median(mtcars,mtcars$cyl)),  14)
  expect_false(any(is.na(scale_by_median(mtcars,mtcars$cyl))))
})
