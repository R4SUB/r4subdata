test_that("dataset_dictionary returns a tibble for valid dataset", {
  result <- dataset_dictionary("evidence_pharma")
  expect_s3_class(result, "tbl_df")
})

test_that("dataset_dictionary errors for invalid dataset", {
  expect_error(dataset_dictionary("nonexistent"), "Unknown dataset")
})

test_that("dataset_dictionary has expected columns", {
  result <- dataset_dictionary("adam_metadata")
  expect_true(all(c("column", "type", "description") %in% names(result)))
})

test_that("dataset_dictionary columns match actual dataset columns", {
  result <- dataset_dictionary("evidence_pharma")
  expect_equal(result$column, names(evidence_pharma))
})

test_that("dataset_dictionary works for all datasets", {
  all_names <- c("evidence_pharma", "adam_metadata", "sdtm_metadata",
                 "trace_mapping", "risk_register_pharma", "regulatory_indicators")
  for (nm in all_names) {
    result <- dataset_dictionary(nm)
    expect_s3_class(result, "tbl_df")
  }
})
