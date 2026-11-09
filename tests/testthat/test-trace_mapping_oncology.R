test_that("trace_mapping_oncology is a data.frame", {
  expect_true(is.data.frame(trace_mapping_oncology))
})

test_that("trace_mapping_oncology has 30 rows", {
  expect_equal(nrow(trace_mapping_oncology), 30L)
})

test_that("trace_mapping_oncology mirrors the trace_mapping schema", {
  expect_equal(names(trace_mapping_oncology), names(trace_mapping))
})

test_that("trace_mapping_oncology confidence values are valid", {
  conf <- trace_mapping_oncology$confidence[!is.na(trace_mapping_oncology$confidence)]
  expect_true(all(conf >= 0 & conf <= 1))
})

test_that("trace_mapping_oncology adam_datasets appear in oncology_metadata", {
  adam_ds <- unique(oncology_metadata$dataset)
  mapping_ds <- unique(trace_mapping_oncology$adam_dataset)
  expect_true(all(mapping_ds %in% adam_ds))
})

test_that("trace_mapping_oncology mapped ADaM variables exist in oncology_metadata", {
  adam_keys <- paste0(oncology_metadata$dataset, ".", oncology_metadata$variable)
  map_keys <- paste0(trace_mapping_oncology$adam_dataset, ".",
                     trace_mapping_oncology$adam_var)
  expect_true(all(map_keys %in% adam_keys))
})

test_that("trace_mapping_oncology mapped SDTM variables exist in sdtm_metadata_oncology", {
  sdtm_keys <- paste0(sdtm_metadata_oncology$dataset, ".",
                      sdtm_metadata_oncology$variable)
  mapped <- !is.na(trace_mapping_oncology$sdtm_domain)
  sdtm_ref <- paste0(trace_mapping_oncology$sdtm_domain[mapped], ".",
                     trace_mapping_oncology$sdtm_var[mapped])
  expect_true(all(sdtm_ref %in% sdtm_keys))
})
