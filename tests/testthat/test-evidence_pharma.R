test_that("evidence_pharma is a data.frame", {
  expect_true(is.data.frame(evidence_pharma))
})

test_that("evidence_pharma has 250 rows", {
  expect_equal(nrow(evidence_pharma), 250L)
})

test_that("evidence_pharma has 17 columns", {
  expect_equal(ncol(evidence_pharma), 17L)
})

test_that("evidence_pharma has all expected columns", {
  expected <- c(
    "run_id", "study_id", "asset_type", "asset_id", "source_name",
    "source_version", "indicator_id", "indicator_name", "indicator_domain",
    "severity", "result", "metric_value", "metric_unit", "message",
    "location", "evidence_payload", "created_at"
  )
  expect_true(all(expected %in% names(evidence_pharma)))
})

test_that("evidence_pharma indicator_domain values are valid", {
  valid <- c("quality", "trace", "risk", "usability")
  expect_true(all(evidence_pharma$indicator_domain %in% valid))
})

test_that("evidence_pharma severity values are valid", {
  valid <- c("info", "low", "medium", "high", "critical")
  expect_true(all(evidence_pharma$severity %in% valid))
})

test_that("evidence_pharma result values are valid", {
  valid <- c("pass", "fail", "warn", "na")
  expect_true(all(evidence_pharma$result %in% valid))
})

test_that("evidence_pharma asset_type values are valid", {
  valid <- c("dataset", "define", "program", "validation", "spec", "other")
  expect_true(all(evidence_pharma$asset_type %in% valid))
})

test_that("evidence_pharma covers all 4 domains", {
  domains <- unique(evidence_pharma$indicator_domain)
  expect_true("quality" %in% domains)
  expect_true("trace" %in% domains)
  expect_true("risk" %in% domains)
  expect_true("usability" %in% domains)
})

test_that("evidence_pharma validates against r4subcore schema", {
  skip_if_not_installed("r4subcore")
  expect_true(r4subcore::validate_evidence(evidence_pharma))
})
