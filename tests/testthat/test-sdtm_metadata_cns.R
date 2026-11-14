test_that("sdtm_metadata_cns is a data.frame", {
  expect_true(is.data.frame(sdtm_metadata_cns))
})

test_that("sdtm_metadata_cns has 38 rows", {
  expect_equal(nrow(sdtm_metadata_cns), 38L)
})

test_that("sdtm_metadata_cns mirrors the sdtm_metadata schema", {
  expect_equal(names(sdtm_metadata_cns), names(sdtm_metadata))
})

test_that("sdtm_metadata_cns contains expected CNS domains", {
  domains <- unique(sdtm_metadata_cns$dataset)
  expect_true("DM" %in% domains)
  expect_true("QS" %in% domains)
  expect_true("SC" %in% domains)
})

test_that("sdtm_metadata_cns dataset names are uppercase", {
  expect_equal(sdtm_metadata_cns$dataset,
               toupper(sdtm_metadata_cns$dataset))
})
