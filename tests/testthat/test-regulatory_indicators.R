test_that("regulatory_indicators is a data.frame", {
  expect_true(is.data.frame(regulatory_indicators))
})

test_that("regulatory_indicators has 30 rows", {
  expect_equal(nrow(regulatory_indicators), 30L)
})

test_that("regulatory_indicators has required columns", {
  expected <- c("indicator_id", "indicator_name", "domain", "description",
                "severity_default", "source", "tags")
  expect_true(all(expected %in% names(regulatory_indicators)))
})

test_that("regulatory_indicators domains are valid", {
  valid <- c("quality", "trace", "risk", "usability")
  expect_true(all(regulatory_indicators$domain %in% valid))
})

test_that("regulatory_indicators covers all 4 domains", {
  domains <- unique(regulatory_indicators$domain)
  expect_true(all(c("quality", "trace", "risk", "usability") %in% domains))
})

test_that("regulatory_indicators indicator_ids are unique", {
  expect_equal(length(unique(regulatory_indicators$indicator_id)),
               nrow(regulatory_indicators))
})
