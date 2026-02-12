#' List Available r4subdata Datasets
#'
#' Returns a summary of all datasets included in the r4subdata package.
#'
#' @return A tibble with columns: `name`, `description`, `n_rows`, `n_cols`.
#'
#' @examples
#' list_datasets()
#'
#' @export
list_datasets <- function() {
  tibble::tibble(
    name = c(
      "evidence_pharma",
      "adam_metadata",
      "sdtm_metadata",
      "trace_mapping",
      "risk_register_pharma",
      "regulatory_indicators"
    ),
    description = c(
      "Pharma study evidence table (CDISCPILOT01) with 250 rows across 4 domains",
      "ADaM metadata for ADSL, ADAE, ADLB (30 variables)",
      "SDTM metadata for DM, AE, LB (40 variables)",
      "ADaM-to-SDTM traceability mapping (25 mappings)",
      "FMEA risk register with 18 risks and mitigations",
      "Regulatory indicator definitions across 4 domains (30 indicators)"
    ),
    n_rows = c(
      nrow(r4subdata::evidence_pharma),
      nrow(r4subdata::adam_metadata),
      nrow(r4subdata::sdtm_metadata),
      nrow(r4subdata::trace_mapping),
      nrow(r4subdata::risk_register_pharma),
      nrow(r4subdata::regulatory_indicators)
    ),
    n_cols = c(
      ncol(r4subdata::evidence_pharma),
      ncol(r4subdata::adam_metadata),
      ncol(r4subdata::sdtm_metadata),
      ncol(r4subdata::trace_mapping),
      ncol(r4subdata::risk_register_pharma),
      ncol(r4subdata::regulatory_indicators)
    )
  )
}
