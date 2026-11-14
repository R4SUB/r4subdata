test_that("cns_metadata is a data.frame", {
  expect_true(is.data.frame(cns_metadata))
})

test_that("cns_metadata has 32 rows", {
  expect_equal(nrow(cns_metadata), 32L)
})

test_that("cns_metadata mirrors the oncology_metadata schema", {
  expect_equal(names(cns_metadata), names(oncology_metadata))
})

test_that("cns_metadata contains expected ADaM datasets", {
  datasets <- unique(cns_metadata$dataset)
  expect_true("ADSL" %in% datasets)
  expect_true("ADQS" %in% datasets)
  expect_true("ADTTE" %in% datasets)
})

test_that("cns_metadata origin and type values are valid", {
  expect_true(all(cns_metadata$origin %in% c("CRF", "Derived", "Assigned")))
  expect_true(all(cns_metadata$type %in% c("Char", "Num")))
})

test_that("cns_metadata derived variables carry derivation text", {
  derived <- cns_metadata[cns_metadata$origin == "Derived", ]
  expect_true(all(!is.na(derived$derivation)))
})
