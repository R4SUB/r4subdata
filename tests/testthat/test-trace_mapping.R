test_that("trace_mapping is a data.frame", {
  expect_true(is.data.frame(trace_mapping))
})

test_that("trace_mapping has 25 rows", {
  expect_equal(nrow(trace_mapping), 25L)
})

test_that("trace_mapping has required columns", {
  expected <- c("adam_dataset", "adam_var", "sdtm_domain", "sdtm_var",
                "derivation_text", "confidence")
  expect_true(all(expected %in% names(trace_mapping)))
})

test_that("trace_mapping confidence values are valid", {
  conf <- trace_mapping$confidence[!is.na(trace_mapping$confidence)]
  expect_true(all(conf >= 0 & conf <= 1))
})

test_that("trace_mapping adam_datasets appear in adam_metadata", {
  adam_ds <- unique(adam_metadata$dataset)
  mapping_ds <- unique(trace_mapping$adam_dataset)
  expect_true(all(mapping_ds %in% adam_ds))
})
