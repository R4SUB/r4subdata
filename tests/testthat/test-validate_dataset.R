# Tests for validate_dataset().

test_that("every shipped dataset validates cleanly against its own schema", {
  for (nm in list_datasets()$name) {
    res <- validate_dataset(get(nm), nm)
    expect_equal(nrow(res), 0L, info = paste0(nm, " should be valid"))
    expect_true(attr(res, "valid"), info = paste0(nm, " valid attribute"))
  }
})

test_that("the report has the documented shape", {
  res <- validate_dataset(adam_metadata, "adam_metadata")
  expect_s3_class(res, "tbl_df")
  expect_equal(names(res), c("issue", "column", "expected", "actual", "message"))
})

test_that("missing columns are reported", {
  d <- adam_metadata[, setdiff(names(adam_metadata), "format")]
  res <- validate_dataset(d, "adam_metadata")
  expect_false(attr(res, "valid"))
  expect_true("missing_column" %in% res$issue)
  expect_true("format" %in% res$column[res$issue == "missing_column"])
})

test_that("unexpected columns are reported", {
  d <- adam_metadata
  d$extra <- "x"
  res <- validate_dataset(d, "adam_metadata")
  expect_true("unexpected_column" %in% res$issue)
  expect_true("extra" %in% res$column[res$issue == "unexpected_column"])
})

test_that("type mismatches are reported", {
  d <- adam_metadata
  d$length <- as.character(d$length)
  res <- validate_dataset(d, "adam_metadata")
  mis <- res[res$issue == "type_mismatch", ]
  expect_true("length" %in% mis$column)
  expect_equal(mis$expected[mis$column == "length"], "integer")
  expect_equal(mis$actual[mis$column == "length"], "character")
})

test_that("integer satisfies an expected numeric type", {
  d <- trace_mapping
  d$confidence <- as.integer(ifelse(is.na(d$confidence), 0L, 1L))
  res <- validate_dataset(d, "trace_mapping")
  expect_false("confidence" %in% res$column[res$issue == "type_mismatch"])
})

test_that("a double column does not satisfy an expected integer type", {
  d <- risk_register_pharma
  d$probability <- as.numeric(d$probability) + 0.5
  res <- validate_dataset(d, "risk_register_pharma")
  expect_true("probability" %in% res$column[res$issue == "type_mismatch"])
})

test_that("strict mode flags column reordering, non-strict does not", {
  d <- adam_metadata[, rev(names(adam_metadata))]
  expect_equal(nrow(validate_dataset(d, "adam_metadata", strict = FALSE)), 0L)
  res <- validate_dataset(d, "adam_metadata", strict = TRUE)
  expect_true("column_order" %in% res$issue)
})

test_that("a custom dictionary data frame can be used as the schema", {
  schema <- tibble::tibble(
    column = c("a", "b"),
    type = c("character", "numeric")
  )
  good <- data.frame(a = "x", b = 1, stringsAsFactors = FALSE)
  expect_true(attr(validate_dataset(good, schema), "valid"))

  bad <- data.frame(a = 1L, b = "y", stringsAsFactors = FALSE)
  res <- validate_dataset(bad, schema)
  expect_setequal(res$issue, c("type_mismatch", "type_mismatch"))
})

test_that("invalid inputs error clearly", {
  expect_error(validate_dataset(1:10, "adam_metadata"), "data frame")
  expect_error(validate_dataset(adam_metadata, "not_a_dataset"), "Unknown dataset")
  expect_error(validate_dataset(adam_metadata, c("a", "b")), "single dataset name")
  expect_error(
    validate_dataset(adam_metadata, tibble::tibble(x = 1)),
    "`column` and `type`"
  )
  expect_error(validate_dataset(adam_metadata, "adam_metadata", strict = NA),
               "single logical")
})
