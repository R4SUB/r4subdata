test_that("risk_register_cns is a data.frame", {
  expect_true(is.data.frame(risk_register_cns))
})

test_that("risk_register_cns has 15 rows", {
  expect_equal(nrow(risk_register_cns), 15L)
})

test_that("risk_register_cns mirrors risk_register_pharma schema", {
  expect_equal(names(risk_register_cns), names(risk_register_pharma))
  expect_equal(
    vapply(risk_register_cns, function(x) class(x)[1], character(1)),
    vapply(risk_register_pharma, function(x) class(x)[1], character(1))
  )
})

test_that("risk_register_cns FMEA scores are 1-5", {
  expect_true(all(risk_register_cns$probability >= 1L &
                  risk_register_cns$probability <= 5L))
  expect_true(all(risk_register_cns$impact >= 1L &
                  risk_register_cns$impact <= 5L))
  expect_true(all(risk_register_cns$detectability >= 1L &
                  risk_register_cns$detectability <= 5L))
})

test_that("risk_register_cns risk_ids are unique and well formed", {
  expect_equal(length(unique(risk_register_cns$risk_id)),
               nrow(risk_register_cns))
  expect_true(all(grepl("^CNS-RISK-[0-9]{3}$", risk_register_cns$risk_id)))
})

test_that("risk_register_cns categories and statuses are valid", {
  expect_true(all(risk_register_cns$category %in%
    c("data_quality", "traceability", "documentation",
      "programming", "compliance")))
  expect_true(all(risk_register_cns$status %in%
    c("open", "mitigated", "closed", "accepted")))
})
