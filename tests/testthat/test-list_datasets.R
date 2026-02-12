test_that("list_datasets returns a tibble", {
  result <- list_datasets()
  expect_s3_class(result, "tbl_df")
})

test_that("list_datasets has 6 rows", {
  result <- list_datasets()
  expect_equal(nrow(result), 6L)
})

test_that("list_datasets has expected columns", {
  result <- list_datasets()
  expect_true(all(c("name", "description", "n_rows", "n_cols") %in%
                    names(result)))
})

test_that("list_datasets names match actual datasets", {
  result <- list_datasets()
  expected <- c("evidence_pharma", "adam_metadata", "sdtm_metadata",
                "trace_mapping", "risk_register_pharma", "regulatory_indicators")
  expect_equal(result$name, expected)
})
