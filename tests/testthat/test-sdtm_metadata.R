test_that("sdtm_metadata is a data.frame", {
  expect_true(is.data.frame(sdtm_metadata))
})

test_that("sdtm_metadata has 43 rows", {
  expect_equal(nrow(sdtm_metadata), 43L)
})

test_that("sdtm_metadata has required columns", {
  expected <- c("dataset", "variable", "label", "type", "length", "format")
  expect_true(all(expected %in% names(sdtm_metadata)))
})

test_that("sdtm_metadata contains expected domains", {
  domains <- unique(sdtm_metadata$dataset)
  expect_true("DM" %in% domains)
  expect_true("AE" %in% domains)
  expect_true("LB" %in% domains)
})

test_that("sdtm_metadata dataset names are uppercase", {
  expect_equal(sdtm_metadata$dataset, toupper(sdtm_metadata$dataset))
})
