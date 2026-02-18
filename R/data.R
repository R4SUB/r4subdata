#' Pharma Study Evidence Table
#'
#' A realistic evidence table for study CDISCPILOT01 (Clinical Data
#' Interchange Standards Consortium Pilot Study 01) covering all four
#' R4SUB (R for Regulatory Submission) pillars (quality, trace, risk,
#' usability) with 250 rows and 18 indicators across multiple datasets
#' and sources.
#'
#' @format A tibble with 250 rows and 17 columns:
#' \describe{
#'   \item{run_id}{Character. Unique run identifier.}
#'   \item{study_id}{Character. Study identifier (CDISCPILOT01).}
#'   \item{asset_type}{Character. Asset type: dataset, define, program, validation, spec, other.}
#'   \item{asset_id}{Character. Asset identifier (e.g., ADSL, define.xml).}
#'   \item{source_name}{Character. Source of the evidence (e.g., pinnacle21).}
#'   \item{source_version}{Character. Version of the source tool.}
#'   \item{indicator_id}{Character. Indicator identifier (e.g., Q-MISS-VAR).}
#'   \item{indicator_name}{Character. Human-readable indicator name.}
#'   \item{indicator_domain}{Character. Domain: quality, trace, risk, usability.}
#'   \item{severity}{Character. Severity: info, low, medium, high, critical.}
#'   \item{result}{Character. Result: pass, fail, warn, na.}
#'   \item{metric_value}{Numeric. Metric value (if applicable).}
#'   \item{metric_unit}{Character. Unit for metric_value.}
#'   \item{message}{Character. Descriptive message.}
#'   \item{location}{Character. Location reference (e.g., ADSL:AGE).}
#'   \item{evidence_payload}{Character. JSON payload with additional details.}
#'   \item{created_at}{POSIXct. Timestamp when evidence was created.}
#' }
#'
#' @source Synthetic data based on the CDISC (Clinical Data Interchange
#'   Standards Consortium) Pilot Study 01 structure.
#' @examples
#' data(evidence_pharma)
#' head(evidence_pharma)
#' table(evidence_pharma$indicator_domain)
"evidence_pharma"

#' ADaM Variable-Level Metadata
#'
#' ADaM (Analysis Data Model) variable-level metadata for ADSL
#' (Subject-Level Analysis Dataset, 16 vars), ADAE (Adverse Events
#' Analysis Dataset, 10 vars), and ADLB (Laboratory Results Analysis
#' Dataset, 10 vars). Follows CDISC (Clinical Data Interchange Standards
#' Consortium) ADaM conventions.
#'
#' @format A tibble with 36 rows and 6 columns:
#' \describe{
#'   \item{dataset}{Character. ADaM dataset name (ADSL, ADAE, ADLB).}
#'   \item{variable}{Character. Variable name.}
#'   \item{label}{Character. Variable label.}
#'   \item{type}{Character. Variable type (Char or Num).}
#'   \item{length}{Integer. Variable length.}
#'   \item{format}{Character. SAS (Statistical Analysis System) format (or NA).}
#' }
#'
#' @source Synthetic metadata based on CDISC ADaM (Analysis Data Model)
#'   standards.
#' @examples
#' data(adam_metadata)
#' table(adam_metadata$dataset)
"adam_metadata"

#' SDTM Variable-Level Metadata
#'
#' SDTM (Study Data Tabulation Model) variable-level metadata for DM
#' (Demographics, 17 vars), AE (Adverse Events, 14 vars), and LB
#' (Laboratory Results, 12 vars). Follows CDISC (Clinical Data
#' Interchange Standards Consortium) SDTM conventions.
#'
#' @format A tibble with 43 rows and 6 columns:
#' \describe{
#'   \item{dataset}{Character. SDTM domain name (DM, AE, LB).}
#'   \item{variable}{Character. Variable name.}
#'   \item{label}{Character. Variable label.}
#'   \item{type}{Character. Variable type (Char or Num).}
#'   \item{length}{Integer. Variable length.}
#'   \item{format}{Character. SAS (Statistical Analysis System) format (or NA).}
#' }
#'
#' @source Synthetic metadata based on CDISC SDTM (Study Data Tabulation
#'   Model) standards.
#' @examples
#' data(sdtm_metadata)
#' table(sdtm_metadata$dataset)
"sdtm_metadata"

#' ADaM-to-SDTM Traceability Mapping
#'
#' Maps ADaM (Analysis Data Model) variables to their SDTM (Study Data
#' Tabulation Model) source variables with derivation text and confidence
#' scores. Includes direct copies, derived variables, and unmapped entries.
#' Follows CDISC (Clinical Data Interchange Standards Consortium)
#' traceability conventions.
#'
#' @format A tibble with 25 rows and 6 columns:
#' \describe{
#'   \item{adam_dataset}{Character. Source ADaM dataset.}
#'   \item{adam_var}{Character. Source ADaM variable.}
#'   \item{sdtm_domain}{Character. Target SDTM domain (NA if derived).}
#'   \item{sdtm_var}{Character. Target SDTM variable (NA if derived).}
#'   \item{derivation_text}{Character. Derivation description text.}
#'   \item{confidence}{Numeric. Mapping confidence score (0-1, NA if unmapped).}
#' }
#'
#' @source Synthetic traceability mapping based on CDISC conventions.
#' @examples
#' data(trace_mapping)
#' table(trace_mapping$adam_dataset)
"trace_mapping"

#' Pharma Risk Register
#'
#' A Failure Mode and Effects Analysis (FMEA)-based risk register with
#' 18 risks covering data quality, traceability, documentation,
#' programming, and compliance categories. Includes probability, impact,
#' and detectability scores on a 1-5 scale. Structured according to
#' ICH (International Council for Harmonisation) Q9 quality risk
#' management principles.
#'
#' @format A tibble with 18 rows and 9 columns:
#' \describe{
#'   \item{risk_id}{Character. Unique risk identifier (RISK-001 to RISK-018).}
#'   \item{description}{Character. Risk description.}
#'   \item{category}{Character. Risk category.}
#'   \item{probability}{Integer. Probability of occurrence (1-5).}
#'   \item{impact}{Integer. Impact severity (1-5).}
#'   \item{detectability}{Integer. Detectability rating (1-5).}
#'   \item{owner}{Character. Risk owner name.}
#'   \item{mitigation}{Character. Mitigation action (or NA).}
#'   \item{status}{Character. Status: open, mitigated, closed, accepted.}
#' }
#'
#' @source Synthetic risk register based on ICH (International Council
#'   for Harmonisation) Q9 quality risk management principles.
#' @examples
#' data(risk_register_pharma)
#' table(risk_register_pharma$category)
"risk_register_pharma"

#' Regulatory Indicator Definitions
#'
#' Reference table of 30 indicator definitions across all four R4SUB
#' (R for Regulatory Submission) domains (quality, trace, risk, usability).
#' Each indicator has a unique ID, default severity, typical source, and
#' descriptive tags.
#'
#' @format A tibble with 30 rows and 7 columns:
#' \describe{
#'   \item{indicator_id}{Character. Unique indicator identifier.}
#'   \item{indicator_name}{Character. Human-readable indicator name.}
#'   \item{domain}{Character. Indicator domain: quality, trace, risk, usability.}
#'   \item{description}{Character. Detailed description.}
#'   \item{severity_default}{Character. Default severity level.}
#'   \item{source}{Character. Typical source tool.}
#'   \item{tags}{Character. Comma-separated tags.}
#' }
#'
#' @source Curated indicator definitions for the R4SUB (R for Regulatory
#'   Submission) ecosystem.
#' @examples
#' data(regulatory_indicators)
#' table(regulatory_indicators$domain)
"regulatory_indicators"
