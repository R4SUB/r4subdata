#' Dataset Column Dictionary
#'
#' Returns column names, types, and descriptions for a given r4subdata dataset.
#'
#' @param dataset Character. Name of the dataset (e.g., `"evidence_pharma"`).
#'
#' @return A tibble with columns: `column`, `type`, `description`.
#'
#' @examples
#' dataset_dictionary("evidence_pharma")
#' dataset_dictionary("adam_metadata")
#'
#' @export
dataset_dictionary <- function(dataset) {
  valid <- c(
    "evidence_pharma", "adam_metadata", "sdtm_metadata",
    "trace_mapping", "risk_register_pharma", "regulatory_indicators"
  )
  if (!dataset %in% valid) {
    stop(
      "Unknown dataset '", dataset, "'. Valid: ",
      paste(valid, collapse = ", "), ".",
      call. = FALSE
    )
  }

  dicts <- list(
    evidence_pharma = tibble::tibble(
      column = c(
        "run_id", "study_id", "asset_type", "asset_id", "source_name",
        "source_version", "indicator_id", "indicator_name", "indicator_domain",
        "severity", "result", "metric_value", "metric_unit", "message",
        "location", "evidence_payload", "created_at"
      ),
      type = c(
        "character", "character", "character", "character", "character",
        "character", "character", "character", "character",
        "character", "character", "numeric", "character", "character",
        "character", "character", "POSIXct"
      ),
      description = c(
        "Unique run identifier",
        "Study identifier (CDISCPILOT01)",
        "Asset type: dataset, define, program, validation, spec, other",
        "Asset identifier (e.g., ADSL, define.xml)",
        "Source of the evidence (e.g., pinnacle21, r4subtrace)",
        "Version of the source tool",
        "Indicator identifier (e.g., Q-MISS-VAR)",
        "Human-readable indicator name",
        "Indicator domain: quality, trace, risk, usability",
        "Severity level: info, low, medium, high, critical",
        "Check result: pass, fail, warn, na",
        "Numeric metric value (if applicable)",
        "Unit for metric_value",
        "Descriptive message for the evidence row",
        "Location reference (e.g., ADSL:AGE)",
        "JSON payload with additional details",
        "Timestamp when evidence was created"
      )
    ),
    adam_metadata = tibble::tibble(
      column = c("dataset", "variable", "label", "type", "length", "format"),
      type = c("character", "character", "character", "character", "integer", "character"),
      description = c(
        "ADaM dataset name (ADSL, ADAE, ADLB)",
        "Variable name",
        "Variable label",
        "Variable type (Char or Num)",
        "Variable length",
        "SAS format"
      )
    ),
    sdtm_metadata = tibble::tibble(
      column = c("dataset", "variable", "label", "type", "length", "format"),
      type = c("character", "character", "character", "character", "integer", "character"),
      description = c(
        "SDTM domain name (DM, AE, LB)",
        "Variable name",
        "Variable label",
        "Variable type (Char or Num)",
        "Variable length",
        "SAS format"
      )
    ),
    trace_mapping = tibble::tibble(
      column = c(
        "adam_dataset", "adam_var", "sdtm_domain", "sdtm_var",
        "derivation_text", "confidence"
      ),
      type = c("character", "character", "character", "character",
               "character", "numeric"),
      description = c(
        "Source ADaM dataset",
        "Source ADaM variable",
        "Target SDTM domain",
        "Target SDTM variable",
        "Derivation description text",
        "Mapping confidence score (0-1, NA if unmapped)"
      )
    ),
    risk_register_pharma = tibble::tibble(
      column = c(
        "risk_id", "description", "category", "probability", "impact",
        "detectability", "owner", "mitigation", "status"
      ),
      type = c(
        "character", "character", "character", "integer", "integer",
        "integer", "character", "character", "character"
      ),
      description = c(
        "Unique risk identifier",
        "Risk description",
        "Risk category (data_quality, traceability, documentation, programming, compliance)",
        "Probability of occurrence (1-5 FMEA scale)",
        "Impact severity (1-5 FMEA scale)",
        "Detectability rating (1=easy to detect, 5=hard to detect)",
        "Risk owner name",
        "Mitigation action description",
        "Risk status: open, mitigated, closed, accepted"
      )
    ),
    regulatory_indicators = tibble::tibble(
      column = c(
        "indicator_id", "indicator_name", "domain", "description",
        "severity_default", "source", "tags"
      ),
      type = c(
        "character", "character", "character", "character",
        "character", "character", "character"
      ),
      description = c(
        "Unique indicator identifier",
        "Human-readable indicator name",
        "Indicator domain: quality, trace, risk, usability",
        "Detailed description of what the indicator checks",
        "Default severity level for this indicator",
        "Typical source tool for this indicator",
        "Comma-separated tags for categorization"
      )
    )
  )

  dicts[[dataset]]
}
