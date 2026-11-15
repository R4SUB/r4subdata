test_that("trace_mapping_cns is a data.frame", {
  expect_true(is.data.frame(trace_mapping_cns))
})

test_that("trace_mapping_cns has 30 rows", {
  expect_equal(nrow(trace_mapping_cns), 30L)
})

test_that("trace_mapping_cns mirrors the trace_mapping schema", {
  expect_equal(names(trace_mapping_cns), names(trace_mapping))
})

test_that("trace_mapping_cns confidence values are valid", {
  conf <- trace_mapping_cns$confidence[!is.na(trace_mapping_cns$confidence)]
  expect_true(all(conf >= 0 & conf <= 1))
})

test_that("trace_mapping_cns adam_datasets appear in cns_metadata", {
  adam_ds <- unique(cns_metadata$dataset)
  mapping_ds <- unique(trace_mapping_cns$adam_dataset)
  expect_true(all(mapping_ds %in% adam_ds))
})

test_that("trace_mapping_cns mapped ADaM variables exist in cns_metadata", {
  adam_keys <- paste0(cns_metadata$dataset, ".", cns_metadata$variable)
  map_keys <- paste0(trace_mapping_cns$adam_dataset, ".",
                     trace_mapping_cns$adam_var)
  expect_true(all(map_keys %in% adam_keys))
})

test_that("trace_mapping_cns mapped SDTM variables exist in sdtm_metadata_cns", {
  sdtm_keys <- paste0(sdtm_metadata_cns$dataset, ".",
                      sdtm_metadata_cns$variable)
  mapped <- !is.na(trace_mapping_cns$sdtm_domain)
  sdtm_ref <- paste0(trace_mapping_cns$sdtm_domain[mapped], ".",
                     trace_mapping_cns$sdtm_var[mapped])
  expect_true(all(sdtm_ref %in% sdtm_keys))
})
