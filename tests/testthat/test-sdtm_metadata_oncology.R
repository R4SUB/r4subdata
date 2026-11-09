test_that("sdtm_metadata_oncology is a data.frame", {
  expect_true(is.data.frame(sdtm_metadata_oncology))
})

test_that("sdtm_metadata_oncology has 38 rows", {
  expect_equal(nrow(sdtm_metadata_oncology), 38L)
})

test_that("sdtm_metadata_oncology mirrors the sdtm_metadata schema", {
  expect_equal(names(sdtm_metadata_oncology), names(sdtm_metadata))
})

test_that("sdtm_metadata_oncology contains expected oncology domains", {
  domains <- unique(sdtm_metadata_oncology$dataset)
  expect_true("DM" %in% domains)
  expect_true("RS" %in% domains)
  expect_true("TU" %in% domains)
})

test_that("sdtm_metadata_oncology dataset names are uppercase", {
  expect_equal(sdtm_metadata_oncology$dataset,
               toupper(sdtm_metadata_oncology$dataset))
})
