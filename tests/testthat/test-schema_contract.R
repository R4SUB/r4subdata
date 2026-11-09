# Schema-contract regression guard.
#
# For every documented dataset, assert that the actual shipped .rda object
# matches its documented schema: row count, column count, column names, and
# column types. The expected row/column counts are pinned here so that any
# drift between the data and its documentation (the class of bug that caused
# earlier count errors) fails loudly.

# Map an R column to the type vocabulary used by dataset_dictionary().
schema_type <- function(x) {
  if (inherits(x, "POSIXct")) return("POSIXct")
  if (is.integer(x)) return("integer")
  if (is.numeric(x)) return("numeric")
  if (is.character(x)) return("character")
  class(x)[1]
}

# Pinned row/column contract for every shipped dataset.
schema_contract <- list(
  evidence_pharma        = list(n_rows = 250L, n_cols = 17L),
  adam_metadata          = list(n_rows = 36L,  n_cols = 6L),
  sdtm_metadata          = list(n_rows = 43L,  n_cols = 6L),
  trace_mapping          = list(n_rows = 25L,  n_cols = 6L),
  risk_register_pharma   = list(n_rows = 18L,  n_cols = 9L),
  regulatory_indicators  = list(n_rows = 30L,  n_cols = 7L),
  oncology_metadata      = list(n_rows = 32L,  n_cols = 7L),
  oncology_evidence      = list(n_rows = 29L,  n_cols = 17L),
  risk_register_oncology = list(n_rows = 15L,  n_cols = 9L),
  sdtm_metadata_oncology = list(n_rows = 38L,  n_cols = 6L),
  trace_mapping_oncology = list(n_rows = 30L,  n_cols = 6L)
)

test_that("contract covers exactly the datasets in list_datasets()", {
  expect_setequal(names(schema_contract), list_datasets()$name)
})

test_that("shipped datasets match their documented row/column counts", {
  for (nm in names(schema_contract)) {
    d <- get(nm)
    expect_equal(nrow(d), schema_contract[[nm]]$n_rows,
                 info = paste0(nm, " row count"))
    expect_equal(ncol(d), schema_contract[[nm]]$n_cols,
                 info = paste0(nm, " column count"))
  }
})

test_that("list_datasets() counts match the shipped .rda objects", {
  ld <- list_datasets()
  for (i in seq_len(nrow(ld))) {
    d <- get(ld$name[i])
    expect_equal(ld$n_rows[i], nrow(d), info = paste0(ld$name[i], " n_rows"))
    expect_equal(ld$n_cols[i], ncol(d), info = paste0(ld$name[i], " n_cols"))
  }
})

test_that("shipped datasets match their dataset_dictionary() column contract", {
  for (nm in names(schema_contract)) {
    d <- get(nm)
    dd <- dataset_dictionary(nm)
    # Column names and order match the dictionary.
    expect_equal(names(d), dd$column, info = paste0(nm, " column names"))
    # Column types match the documented types.
    actual_types <- unname(vapply(d, schema_type, character(1)))
    expect_equal(actual_types, dd$type, info = paste0(nm, " column types"))
  }
})
