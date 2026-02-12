test_that("risk_register_pharma is a data.frame", {
  expect_true(is.data.frame(risk_register_pharma))
})

test_that("risk_register_pharma has 18 rows", {
  expect_equal(nrow(risk_register_pharma), 18L)
})

test_that("risk_register_pharma has required columns", {
  expected <- c("risk_id", "description", "category", "probability",
                "impact", "detectability", "owner", "mitigation", "status")
  expect_true(all(expected %in% names(risk_register_pharma)))
})

test_that("risk_register_pharma FMEA scores are 1-5", {
  expect_true(all(risk_register_pharma$probability >= 1L &
                  risk_register_pharma$probability <= 5L))
  expect_true(all(risk_register_pharma$impact >= 1L &
                  risk_register_pharma$impact <= 5L))
  expect_true(all(risk_register_pharma$detectability >= 1L &
                  risk_register_pharma$detectability <= 5L))
})

test_that("risk_register_pharma risk_ids are unique", {
  expect_equal(length(unique(risk_register_pharma$risk_id)),
               nrow(risk_register_pharma))
})
