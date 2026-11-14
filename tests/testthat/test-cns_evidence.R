test_that("cns_evidence is a data.frame", {
  expect_true(is.data.frame(cns_evidence))
})

test_that("cns_evidence has 29 rows", {
  expect_equal(nrow(cns_evidence), 29L)
})

test_that("cns_evidence mirrors the oncology_evidence schema", {
  expect_equal(names(cns_evidence), names(oncology_evidence))
  expect_equal(
    vapply(cns_evidence, function(x) class(x)[1], character(1)),
    vapply(oncology_evidence, function(x) class(x)[1], character(1))
  )
})

test_that("cns_evidence is a single study (CNS-2025-001)", {
  expect_equal(unique(cns_evidence$study_id), "CNS-2025-001")
})

test_that("cns_evidence covers all four R4SUB domains", {
  expect_setequal(
    unique(cns_evidence$indicator_domain),
    c("quality", "trace", "risk", "usability")
  )
})

test_that("cns_evidence result and severity values are valid", {
  expect_true(all(cns_evidence$result %in% c("pass", "fail", "warn", "na")))
  expect_true(all(cns_evidence$severity %in%
    c("info", "low", "medium", "high", "critical")))
})
