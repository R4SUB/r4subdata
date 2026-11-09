#' List Available r4subdata Datasets
#'
#' Returns a summary of all datasets included in the r4subdata package.
#'
#' @return A tibble with columns: `name`, `group`, `description`, `n_rows`,
#'   `n_cols`. The `group` column tags each dataset as `"pharma"`
#'   (CDISCPILOT01 / general reference) or `"oncology"` (ONCO-2025-001).
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
      "regulatory_indicators",
      "oncology_metadata",
      "oncology_evidence",
      "risk_register_oncology",
      "sdtm_metadata_oncology",
      "trace_mapping_oncology"
    ),
    group = c(
      "pharma",
      "pharma",
      "pharma",
      "pharma",
      "pharma",
      "pharma",
      "oncology",
      "oncology",
      "oncology",
      "oncology",
      "oncology"
    ),
    description = c(
      "Pharma study evidence table (CDISCPILOT01) with 250 rows across 4 domains",
      "ADaM metadata for ADSL, ADAE, ADLB (36 variables)",
      "SDTM metadata for DM, AE, LB (43 variables)",
      "ADaM-to-SDTM traceability mapping (25 mappings)",
      "FMEA risk register with 18 risks and mitigations",
      "Regulatory indicator definitions across 4 domains (30 indicators)",
      "Oncology trial ADaM metadata for ADSL, ADRS, ADTTE (32 variables)",
      "Oncology trial evidence table (ONCO-2025-001) with 29 rows across 4 domains",
      "Oncology trial FMEA risk register (ONCO-2025-001) with 15 risks and mitigations",
      "Oncology trial SDTM metadata for DM, RS, TU (38 variables)",
      "Oncology trial ADaM-to-SDTM traceability mapping (30 mappings)"
    ),
    n_rows = c(
      nrow(r4subdata::evidence_pharma),
      nrow(r4subdata::adam_metadata),
      nrow(r4subdata::sdtm_metadata),
      nrow(r4subdata::trace_mapping),
      nrow(r4subdata::risk_register_pharma),
      nrow(r4subdata::regulatory_indicators),
      nrow(r4subdata::oncology_metadata),
      nrow(r4subdata::oncology_evidence),
      nrow(r4subdata::risk_register_oncology),
      nrow(r4subdata::sdtm_metadata_oncology),
      nrow(r4subdata::trace_mapping_oncology)
    ),
    n_cols = c(
      ncol(r4subdata::evidence_pharma),
      ncol(r4subdata::adam_metadata),
      ncol(r4subdata::sdtm_metadata),
      ncol(r4subdata::trace_mapping),
      ncol(r4subdata::risk_register_pharma),
      ncol(r4subdata::regulatory_indicators),
      ncol(r4subdata::oncology_metadata),
      ncol(r4subdata::oncology_evidence),
      ncol(r4subdata::risk_register_oncology),
      ncol(r4subdata::sdtm_metadata_oncology),
      ncol(r4subdata::trace_mapping_oncology)
    )
  )
}
