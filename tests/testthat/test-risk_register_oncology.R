test_that("risk_register_oncology is a data.frame", {
  expect_true(is.data.frame(risk_register_oncology))
})

test_that("risk_register_oncology has 15 rows", {
  expect_equal(nrow(risk_register_oncology), 15L)
})

test_that("risk_register_oncology mirrors risk_register_pharma schema", {
  expect_equal(names(risk_register_oncology), names(risk_register_pharma))
  expect_equal(
    vapply(risk_register_oncology, function(x) class(x)[1], character(1)),
    vapply(risk_register_pharma, function(x) class(x)[1], character(1))
  )
})

test_that("risk_register_oncology FMEA scores are 1-5", {
  expect_true(all(risk_register_oncology$probability >= 1L &
                  risk_register_oncology$probability <= 5L))
  expect_true(all(risk_register_oncology$impact >= 1L &
                  risk_register_oncology$impact <= 5L))
  expect_true(all(risk_register_oncology$detectability >= 1L &
                  risk_register_oncology$detectability <= 5L))
})

test_that("risk_register_oncology risk_ids are unique", {
  expect_equal(length(unique(risk_register_oncology$risk_id)),
               nrow(risk_register_oncology))
})

test_that("risk_register_oncology categories and statuses are valid", {
  expect_true(all(risk_register_oncology$category %in%
    c("data_quality", "traceability", "documentation",
      "programming", "compliance")))
  expect_true(all(risk_register_oncology$status %in%
    c("open", "mitigated", "closed", "accepted")))
})
