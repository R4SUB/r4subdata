test_that("adam_metadata is a data.frame", {
  expect_true(is.data.frame(adam_metadata))
})

test_that("adam_metadata has 36 rows", {
  expect_equal(nrow(adam_metadata), 36L)
})

test_that("adam_metadata has required columns", {
  expected <- c("dataset", "variable", "label", "type", "length", "format")
  expect_true(all(expected %in% names(adam_metadata)))
})

test_that("adam_metadata contains expected datasets", {
  datasets <- unique(adam_metadata$dataset)
  expect_true("ADSL" %in% datasets)
  expect_true("ADAE" %in% datasets)
  expect_true("ADLB" %in% datasets)
})

test_that("adam_metadata dataset names are uppercase", {
  expect_equal(adam_metadata$dataset, toupper(adam_metadata$dataset))
})
