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

# ---------------------------------------------------------------------------
# strict-mode column-order diffs
# ---------------------------------------------------------------------------

test_that("column_order issue carries the exact expected/actual order strings", {
  d <- adam_metadata[, rev(names(adam_metadata))]
  res <- validate_dataset(d, "adam_metadata", strict = TRUE)
  ord <- res[res$issue == "column_order", ]
  expect_equal(nrow(ord), 1L)
  expect_true(is.na(ord$column))
  expect_equal(ord$expected,
               paste(names(adam_metadata), collapse = ", "))
  expect_equal(ord$actual,
               paste(rev(names(adam_metadata)), collapse = ", "))
  expect_equal(ord$message, "Columns are not in the schema-defined order.")
  # Reordering is the only problem, so it is the sole reported issue.
  expect_equal(nrow(res), 1L)
  expect_false(attr(res, "valid"))
})

test_that("a single adjacent column swap is flagged in strict mode", {
  nm <- names(adam_metadata)
  swapped <- nm
  swapped[1:2] <- nm[2:1]
  d <- adam_metadata[, swapped]
  res <- validate_dataset(d, "adam_metadata", strict = TRUE)
  expect_equal(res$issue, "column_order")
  expect_false(attr(res, "valid"))
})

test_that("strict mode does not emit column_order when the column sets differ", {
  # setequal() guards the ordering check: a missing column makes the sets
  # unequal, so only the structural issue is reported, never column_order.
  d <- adam_metadata[, setdiff(names(adam_metadata), "format")]
  d <- d[, rev(names(d))]
  res <- validate_dataset(d, "adam_metadata", strict = TRUE)
  expect_false("column_order" %in% res$issue)
  expect_equal(unique(res$issue), "missing_column")
})

test_that("in-order data is clean in strict mode, including every shipped dataset", {
  for (nm in list_datasets()$name) {
    res <- validate_dataset(get(nm), nm, strict = TRUE)
    expect_equal(nrow(res), 0L, info = paste0(nm, " strict order"))
    expect_true(attr(res, "valid"))
  }
})

# ---------------------------------------------------------------------------
# integer-vs-numeric subtype boundary, both directions and exact rows
# ---------------------------------------------------------------------------

test_that("an integer column fully satisfies an expected numeric schema", {
  d <- trace_mapping
  d$confidence <- ifelse(is.na(d$confidence), 0L, 1L)  # integer
  expect_true(is.integer(d$confidence))
  res <- validate_dataset(d, "trace_mapping")
  expect_equal(nrow(res), 0L)
  expect_true(attr(res, "valid"))
})

test_that("a double column fails an expected integer schema with an exact row", {
  d <- risk_register_pharma
  d$probability <- as.numeric(d$probability) + 0.5  # double
  res <- validate_dataset(d, "risk_register_pharma")
  mis <- res[res$issue == "type_mismatch" & res$column == "probability", ]
  expect_equal(nrow(mis), 1L)
  expect_equal(mis$expected, "integer")
  expect_equal(mis$actual, "numeric")
  expect_equal(mis$message,
               "Column 'probability' should be integer but is numeric.")
})

test_that("integer-to-integer and numeric-to-numeric columns are accepted", {
  # integer satisfies integer
  expect_true(is.integer(risk_register_pharma$probability))
  expect_true(attr(validate_dataset(risk_register_pharma,
                                    "risk_register_pharma"), "valid"))
  # numeric (double) satisfies numeric
  expect_true(is.double(trace_mapping$confidence))
  expect_true(attr(validate_dataset(trace_mapping, "trace_mapping"), "valid"))
})

# ---------------------------------------------------------------------------
# user-supplied dictionary path
# ---------------------------------------------------------------------------

test_that("a dataset's own dictionary object can stand in for its name", {
  for (nm in list_datasets()$name) {
    dict <- dataset_dictionary(nm)
    res <- validate_dataset(get(nm), dict)
    expect_equal(nrow(res), 0L, info = paste0(nm, " vs own dictionary"))
    expect_true(attr(res, "valid"))
  }
})

test_that("a plain data.frame dictionary with extra columns is accepted", {
  # resolve_schema() only requires `column` and `type`; extra columns such as
  # `description` are ignored, and a base data.frame works as well as a tibble.
  dict <- data.frame(
    column = c("a", "b"),
    type = c("character", "integer"),
    description = c("first", "second"),
    stringsAsFactors = FALSE
  )
  good <- data.frame(a = "x", b = 1L, stringsAsFactors = FALSE)
  expect_true(attr(validate_dataset(good, dict), "valid"))

  bad <- data.frame(a = "x", b = 2.5, stringsAsFactors = FALSE)
  res <- validate_dataset(bad, dict)
  expect_equal(res$issue, "type_mismatch")
  expect_equal(res$column, "b")
  expect_equal(res$expected, "integer")
  expect_equal(res$actual, "numeric")
})

# ---------------------------------------------------------------------------
# multiple simultaneous issues, with exact rows
# ---------------------------------------------------------------------------

test_that("missing, unexpected, and type-mismatch issues are reported together", {
  d <- adam_metadata
  d$length <- as.character(d$length)  # type mismatch (integer -> character)
  d$extra <- 1L                        # unexpected column
  d$format <- NULL                     # missing column
  res <- validate_dataset(d, "adam_metadata")

  expect_setequal(res$issue,
                  c("missing_column", "unexpected_column", "type_mismatch"))
  expect_equal(nrow(res), 3L)
  expect_false(attr(res, "valid"))

  miss <- res[res$issue == "missing_column", ]
  expect_equal(miss$column, "format")
  expect_equal(miss$expected, "character")
  expect_true(is.na(miss$actual))

  unexp <- res[res$issue == "unexpected_column", ]
  expect_equal(unexp$column, "extra")
  expect_true(is.na(unexp$expected))
  expect_equal(unexp$actual, "integer")

  mm <- res[res$issue == "type_mismatch", ]
  expect_equal(mm$column, "length")
  expect_equal(mm$expected, "integer")
  expect_equal(mm$actual, "character")
})

# ---------------------------------------------------------------------------
# NA / edge inputs
# ---------------------------------------------------------------------------

test_that("a zero-row data frame with the right columns is valid", {
  res <- validate_dataset(adam_metadata[0, ], "adam_metadata")
  expect_equal(nrow(res), 0L)
  expect_true(attr(res, "valid"))
})

test_that("NA values in otherwise correct columns do not trigger mismatches", {
  d <- trace_mapping
  d$sdtm_var[1] <- NA_character_   # character stays character
  d$confidence[1] <- NA_real_      # numeric stays numeric
  res <- validate_dataset(d, "trace_mapping")
  expect_equal(nrow(res), 0L)
  expect_true(attr(res, "valid"))
})

test_that("a zero-column data frame reports every schema column as missing", {
  res <- validate_dataset(data.frame(), "adam_metadata")
  expect_equal(unique(res$issue), "missing_column")
  expect_setequal(res$column, names(adam_metadata))
  expect_equal(nrow(res), length(names(adam_metadata)))
  expect_false(attr(res, "valid"))
})

test_that("a zero-row dictionary treats all data columns as unexpected", {
  empty_dict <- tibble::tibble(column = character(0), type = character(0))
  res <- validate_dataset(adam_metadata, empty_dict)
  expect_equal(unique(res$issue), "unexpected_column")
  expect_setequal(res$column, names(adam_metadata))
  expect_false(attr(res, "valid"))
})

# ---------------------------------------------------------------------------
# the `valid` attribute
# ---------------------------------------------------------------------------

test_that("the valid attribute is a scalar logical that tracks nrow == 0", {
  clean <- validate_dataset(adam_metadata, "adam_metadata")
  expect_type(attr(clean, "valid"), "logical")
  expect_length(attr(clean, "valid"), 1L)
  expect_identical(attr(clean, "valid"), nrow(clean) == 0L)

  d <- adam_metadata
  d$oops <- 1
  dirty <- validate_dataset(d, "adam_metadata")
  expect_identical(attr(dirty, "valid"), nrow(dirty) == 0L)
  expect_false(attr(dirty, "valid"))
})
