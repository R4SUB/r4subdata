## Build all r4subdata datasets
## Run this script from the package root: source("data-raw/build_datasets.R")

library(tibble)

set.seed(20250115)

# ---- 1. adam_metadata ----

adam_metadata <- tibble(
  dataset = c(
    rep("ADSL", 16), rep("ADAE", 10), rep("ADLB", 10)
  ),
  variable = c(
    # ADSL
    "STUDYID", "USUBJID", "SUBJID", "SITEID", "AGE", "AGEU",
    "AGEGR1", "SEX", "RACE", "ETHNIC", "ARM", "ARMCD",
    "TRT01P", "TRT01A", "SAFFL", "ITTFL",
    # ADAE
    "STUDYID", "USUBJID", "AESEQ", "AEBODSYS", "AEDECOD",
    "AESEV", "AESER", "AEREL", "AESTDTC", "AEENDTC",
    # ADLB
    "STUDYID", "USUBJID", "PARAMCD", "PARAM", "AVAL",
    "BASE", "CHG", "AVISIT", "ABLFL", "ANL01FL"
  ),
  label = c(
    # ADSL
    "Study Identifier", "Unique Subject Identifier", "Subject Identifier",
    "Study Site Identifier", "Age", "Age Units", "Pooled Age Group 1",
    "Sex", "Race", "Ethnicity", "Planned Arm", "Planned Arm Code",
    "Planned Treatment for Period 01", "Actual Treatment for Period 01",
    "Safety Population Flag", "Intent-To-Treat Population Flag",
    # ADAE
    "Study Identifier", "Unique Subject Identifier", "Sequence Number",
    "Body System or Organ Class", "Dictionary-Derived Term",
    "Severity/Intensity", "Serious Event", "Causality",
    "Start Date/Time of Adverse Event", "End Date/Time of Adverse Event",
    # ADLB
    "Study Identifier", "Unique Subject Identifier", "Parameter Code",
    "Parameter", "Analysis Value", "Baseline Value",
    "Change from Baseline", "Analysis Visit", "Baseline Record Flag",
    "Analysis Record Flag 01"
  ),
  type = c(
    # ADSL
    "Char", "Char", "Char", "Char", "Num", "Char", "Char",
    "Char", "Char", "Char", "Char", "Char", "Char", "Char", "Char", "Char",
    # ADAE
    "Char", "Char", "Num", "Char", "Char", "Char", "Char", "Char",
    "Char", "Char",
    # ADLB
    "Char", "Char", "Char", "Char", "Num", "Num", "Num", "Char",
    "Char", "Char"
  ),
  length = c(
    # ADSL
    12L, 20L, 8L, 4L, 8L, 6L, 10L, 2L, 40L, 40L, 40L, 20L,
    40L, 40L, 1L, 1L,
    # ADAE
    12L, 20L, 8L, 100L, 100L, 10L, 1L, 20L, 19L, 19L,
    # ADLB
    12L, 20L, 8L, 40L, 8L, 8L, 8L, 40L, 1L, 1L
  ),
  format = c(
    # ADSL
    NA, NA, NA, NA, "BEST.", NA, NA, NA, NA, NA, NA, NA,
    NA, NA, NA, NA,
    # ADAE
    NA, NA, "BEST.", NA, NA, NA, NA, NA, NA, NA,
    # ADLB
    NA, NA, NA, NA, "BEST.", "BEST.", "BEST.", NA, NA, NA
  )
)

# ---- 2. sdtm_metadata ----

sdtm_metadata <- tibble(
  dataset = c(
    rep("DM", 17), rep("AE", 14), rep("LB", 12)
  ),
  variable = c(
    # DM
    "STUDYID", "DOMAIN", "USUBJID", "SUBJID", "RFSTDTC", "RFENDTC",
    "SITEID", "INVID", "BRTHDTC", "AGE", "AGEU", "SEX", "RACE",
    "ETHNIC", "ARMCD", "ARM", "COUNTRY",
    # AE
    "STUDYID", "DOMAIN", "USUBJID", "AESEQ", "AETERM", "AEDECOD",
    "AEBODSYS", "AESEV", "AESER", "AEREL", "AEACN", "AEOUT",
    "AESTDTC", "AEENDTC",
    # LB
    "STUDYID", "DOMAIN", "USUBJID", "LBSEQ", "LBTESTCD", "LBTEST",
    "LBORRES", "LBORRESU", "LBSTRESN", "LBSTRESU", "LBBLFL", "LBDTC"
  ),
  label = c(
    # DM
    "Study Identifier", "Domain Abbreviation", "Unique Subject Identifier",
    "Subject Identifier for the Study",
    "Subject Reference Start Date/Time", "Subject Reference End Date/Time",
    "Study Site Identifier", "Investigator Identifier", "Date/Time of Birth",
    "Age", "Age Units", "Sex", "Race", "Ethnicity",
    "Planned Arm Code", "Description of Planned Arm", "Country",
    # AE
    "Study Identifier", "Domain Abbreviation", "Unique Subject Identifier",
    "Sequence Number", "Reported Term for the Adverse Event",
    "Dictionary-Derived Term", "Body System or Organ Class",
    "Severity/Intensity", "Serious Event", "Causality",
    "Action Taken with Study Treatment", "Outcome of Adverse Event",
    "Start Date/Time of Adverse Event", "End Date/Time of Adverse Event",
    # LB
    "Study Identifier", "Domain Abbreviation", "Unique Subject Identifier",
    "Sequence Number", "Lab Test or Examination Short Name",
    "Lab Test or Examination Name", "Result or Finding in Original Units",
    "Original Units", "Numeric Result/Finding in Standard Units",
    "Standard Units", "Baseline Flag", "Date/Time of Specimen Collection"
  ),
  type = c(
    # DM
    "Char", "Char", "Char", "Char", "Char", "Char", "Char", "Char",
    "Char", "Num", "Char", "Char", "Char", "Char", "Char", "Char", "Char",
    # AE
    "Char", "Char", "Char", "Num", "Char", "Char", "Char", "Char",
    "Char", "Char", "Char", "Char", "Char", "Char",
    # LB
    "Char", "Char", "Char", "Num", "Char", "Char", "Char", "Char",
    "Num", "Char", "Char", "Char"
  ),
  length = c(
    # DM
    12L, 2L, 20L, 8L, 19L, 19L, 4L, 10L, 19L, 8L, 6L, 2L,
    40L, 40L, 20L, 40L, 3L,
    # AE
    12L, 2L, 20L, 8L, 200L, 200L, 200L, 10L, 1L, 20L, 40L, 40L,
    19L, 19L,
    # LB
    12L, 2L, 20L, 8L, 8L, 40L, 20L, 20L, 8L, 20L, 1L, 19L
  ),
  format = c(
    # DM
    NA, NA, NA, NA, NA, NA, NA, NA, NA, "BEST.", NA, NA,
    NA, NA, NA, NA, NA,
    # AE
    NA, NA, NA, "BEST.", NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
    # LB
    NA, NA, NA, "BEST.", NA, NA, NA, NA, "BEST.", NA, NA, NA
  )
)

# ---- 3. trace_mapping ----

trace_mapping <- tibble(
  adam_dataset = c(
    # ADSL mappings
    rep("ADSL", 12),
    # ADAE mappings
    rep("ADAE", 7),
    # ADLB mappings
    rep("ADLB", 6)
  ),
  adam_var = c(
    # ADSL
    "STUDYID", "USUBJID", "SUBJID", "SITEID", "AGE", "AGEU",
    "AGEGR1", "SEX", "RACE", "ETHNIC", "ARM", "ARMCD",
    # ADAE
    "STUDYID", "USUBJID", "AESEQ", "AEBODSYS", "AEDECOD",
    "AESEV", "AESER",
    # ADLB
    "STUDYID", "USUBJID", "PARAMCD", "AVAL", "BASE", "CHG"
  ),
  sdtm_domain = c(
    # ADSL -> DM
    "DM", "DM", "DM", "DM", "DM", "DM", NA, "DM", "DM", "DM", "DM", "DM",
    # ADAE -> AE
    "AE", "AE", "AE", "AE", "AE", "AE", "AE",
    # ADLB -> LB
    "LB", "LB", "LB", "LB", NA, NA
  ),
  sdtm_var = c(
    # ADSL -> DM
    "STUDYID", "USUBJID", "SUBJID", "SITEID", "AGE", "AGEU",
    NA, "SEX", "RACE", "ETHNIC", "ARM", "ARMCD",
    # ADAE -> AE
    "STUDYID", "USUBJID", "AESEQ", "AEBODSYS", "AEDECOD",
    "AESEV", "AESER",
    # ADLB -> LB
    "STUDYID", "USUBJID", "LBTESTCD", "LBSTRESN", NA, NA
  ),

  derivation_text = c(
    # ADSL
    "Direct copy from DM.STUDYID",
    "Direct copy from DM.USUBJID",
    "Direct copy from DM.SUBJID",
    "Direct copy from DM.SITEID",
    "Direct copy from DM.AGE",
    "Direct copy from DM.AGEU",
    "Derived from AGE using protocol-defined age groups: <65, 65-80, >80",
    "Direct copy from DM.SEX",
    "Direct copy from DM.RACE",
    "Direct copy from DM.ETHNIC",
    "Direct copy from DM.ARM",
    "Direct copy from DM.ARMCD",
    # ADAE
    "Direct copy from AE.STUDYID",
    "Direct copy from AE.USUBJID",
    "Direct copy from AE.AESEQ",
    "Mapped from AE.AEBODSYS via MedDRA coding",
    "Mapped from AE.AEDECOD via MedDRA preferred term",
    "Direct copy from AE.AESEV",
    "Direct copy from AE.AESER",
    # ADLB
    "Direct copy from LB.STUDYID",
    "Direct copy from LB.USUBJID",
    "Mapped from LB.LBTESTCD with parameter lookup",
    "Standardized numeric result from LB.LBSTRESN",
    "Derived: first non-missing value where ABLFL='Y'",
    "Derived: AVAL - BASE (change from baseline)"
  ),
  confidence = c(
    # ADSL
    1.0, 1.0, 1.0, 1.0, 0.95, 0.95, NA, 1.0, 1.0, 1.0, 1.0, 1.0,
    # ADAE
    1.0, 1.0, 1.0, 0.90, 0.90, 1.0, 1.0,
    # ADLB
    1.0, 1.0, 0.85, 0.90, NA, NA
  )
)

# ---- 4. risk_register_pharma ----

risk_register_pharma <- tibble(
  risk_id = paste0("RISK-", sprintf("%03d", 1:18)),
  description = c(
    "Missing required SDTM variables in DM domain",
    "Unmapped ADaM derivation for AGEGR1 variable",
    "Define.xml incomplete for LB domain variables",
    "Inconsistent date formats across AE domain",
    "Duplicate records found in ADAE dataset",
    "Laboratory units not standardized across sites",
    "Pinnacle21 validation errors in ADSL dataset",
    "Traceability gap: ADLB.BASE derivation undocumented",
    "Critical MedDRA coding discrepancy in AEBODSYS",
    "Reviewer note: excessive variable labels truncated",
    "Missing controlled terminology for RACE variable",
    "Unresolved programming discrepancy in ADTTE",
    "Incomplete audit trail for manual data corrections",
    "Cross-domain referential integrity failure (DM-AE)",
    "Define.xml version mismatch with submission datasets",
    "Statistical analysis results not reproducible",
    "eCTD folder structure non-compliant",
    "Insufficient documentation for imputation methods"
  ),
  category = c(
    "data_quality", "traceability", "documentation", "data_quality",
    "data_quality", "data_quality", "compliance", "traceability",
    "data_quality", "documentation", "compliance", "programming",
    "compliance", "data_quality", "documentation", "programming",
    "compliance", "documentation"
  ),
  probability = c(
    3L, 4L, 2L, 3L, 2L, 4L, 3L, 4L, 2L, 3L, 3L, 2L, 3L, 2L, 3L, 2L, 1L, 3L
  ),
  impact = c(
    4L, 3L, 4L, 3L, 3L, 4L, 4L, 3L, 5L, 2L, 4L, 3L, 4L, 4L, 3L, 5L, 3L, 3L
  ),
  detectability = c(
    2L, 3L, 2L, 3L, 1L, 3L, 1L, 4L, 3L, 2L, 2L, 3L, 4L, 2L, 2L, 3L, 2L, 3L
  ),
  owner = c(
    "Data Management", "Statistical Programming", "Medical Writing",
    "Data Management", "Statistical Programming", "Data Management",
    "Quality Assurance", "Statistical Programming", "Medical Coding",
    "Statistical Programming", "Data Management", "Statistical Programming",
    "Quality Assurance", "Data Management", "Medical Writing",
    "Biostatistics", "Regulatory Affairs", "Biostatistics"
  ),
  mitigation = c(
    "Run SDTM compliance checks; add missing variables from specification",
    "Document derivation rule; add traceability mapping entry",
    "Update define.xml with complete LB variable definitions",
    "Standardize date parsing with ISO 8601 conversion utility",
    NA,
    "Implement central lab unit conversion table",
    "Fix P21 errors and re-run validation before submission",
    NA,
    "Re-map using latest MedDRA version; validate with medical reviewer",
    "Truncate labels to 40 characters per CDISC guidelines",
    "Map RACE to CDISC controlled terminology codelist",
    NA,
    "Implement electronic audit trail system",
    "Add cross-domain referential integrity checks to validation suite",
    "Regenerate define.xml from latest dataset specifications",
    "Set random seeds; document software versions; re-run analyses",
    "Restructure eCTD folders per regional requirements",
    "Add imputation methods appendix to SAP and CSR"
  ),
  status = c(
    "open", "open", "mitigated", "open", "closed", "open",
    "mitigated", "open", "open", "closed", "open", "open",
    "open", "mitigated", "open", "open", "accepted", "open"
  )
)

# ---- 5. regulatory_indicators ----

regulatory_indicators <- tibble(
  indicator_id = c(
    # Quality (10)
    "Q-MISS-VAR", "Q-TYPE-MISMATCH", "Q-LABEL-LEN", "Q-DUP-RECORDS",
    "Q-FORMAT-ERR", "Q-VALUE-RANGE", "Q-CT-COMPLIANCE", "Q-DATE-FORMAT",
    "Q-REF-INTEGRITY", "Q-ENCODING",
    # Trace (8)
    "T-ORPHAN-VAR", "T-TRACE-LEVEL", "T-AMBIGUOUS-MAP", "T-DERIVATION-DOC",
    "T-COVERAGE-L2", "T-COVERAGE-L3", "T-CONFLICT", "T-SPEC-MATCH",
    # Risk (6)
    "R-HIGH-RPN", "R-OPEN-RISK", "R-MITIGATION-GAP", "R-CRITICAL-COUNT",
    "R-OVERALL-SCORE", "R-TREND-WORSENING",
    # Usability (6)
    "U-DEFINE-COMPLETE", "U-REVIEWER-NOTE", "U-LABEL-QUALITY",
    "U-DATASET-SIZE", "U-ACRF-AVAILABLE", "U-NAVIGATION"
  ),
  indicator_name = c(
    # Quality
    "Missing Variables", "Type Mismatch", "Label Length Violation",
    "Duplicate Records", "Format Error", "Value Out of Range",
    "Controlled Terminology Compliance", "Date Format Check",
    "Referential Integrity", "Character Encoding Check",
    # Trace
    "Orphan Variable", "Traceability Level", "Ambiguous Mapping",
    "Derivation Documentation", "L2+ Coverage", "L3+ Coverage",
    "Mapping Conflict", "Specification Match",
    # Risk
    "High RPN Item", "Open Risk", "Mitigation Gap",
    "Critical Risk Count", "Overall Risk Score", "Worsening Trend",
    # Usability
    "Define Completeness", "Reviewer Note", "Label Quality",
    "Dataset Size Check", "ACRF Availability", "Navigation Aid"
  ),
  domain = c(
    rep("quality", 10), rep("trace", 8), rep("risk", 6), rep("usability", 6)
  ),
  description = c(
    # Quality
    "Variable listed in specification but missing from dataset",
    "Variable type (Char/Num) does not match specification",
    "Variable label exceeds maximum allowed length (40 characters)",
    "Duplicate rows detected within a dataset",
    "Display format does not match specification or CDISC standards",
    "Numeric value falls outside expected or protocol-defined range",
    "Value not found in CDISC controlled terminology codelist",
    "Date/time value does not conform to ISO 8601 format",
    "Foreign key reference to another domain fails (e.g., USUBJID not in DM)",
    "Non-ASCII or non-UTF-8 characters detected in character variables",
    # Trace
    "ADaM variable has no SDTM mapping or derivation source",
    "Traceability level assigned to variable (L0=none to L3=full)",
    "Variable maps to multiple SDTM sources without clear precedence",
    "Derivation text is missing or incomplete for a derived variable",
    "Fraction of variables with traceability level L2 or higher",
    "Fraction of variables with traceability level L3 (full trace)",
    "Conflicting mapping entries for the same variable",
    "Variable attributes match between dataset and define.xml specification",
    # Risk
    "Risk item with RPN above critical threshold",
    "Risk item with status 'open' (unresolved)",
    "Risk item with no documented mitigation action",
    "Count of risks classified as critical level",
    "Aggregate risk score normalized to 0-1 scale",
    "Risk scores have increased compared to previous assessment",
    # Usability
    "Define.xml completeness for all dataset variables and codelists",
    "Reviewer feedback or annotation requiring attention",
    "Variable labels are clear, non-truncated, and standards-compliant",
    "Dataset row/column count within recommended limits for reviewers",
    "Annotated Case Report Form is available and linked",
    "Submission includes navigation aids (hyperlinks, bookmarks)"
  ),
  severity_default = c(
    # Quality
    "high", "high", "medium", "high", "medium", "medium",
    "medium", "low", "high", "low",
    # Trace
    "high", "info", "medium", "medium", "info", "info",
    "high", "medium",
    # Risk
    "critical", "high", "high", "critical", "info", "medium",
    # Usability
    "medium", "low", "low", "info", "medium", "low"
  ),
  source = c(
    # Quality
    "pinnacle21", "pinnacle21", "pinnacle21", "pinnacle21", "pinnacle21",
    "manual_review", "pinnacle21", "pinnacle21", "pinnacle21", "pinnacle21",
    # Trace
    "r4subtrace", "r4subtrace", "r4subtrace", "r4subtrace",
    "r4subtrace", "r4subtrace", "r4subtrace", "define_checker",
    # Risk
    "r4subrisk", "r4subrisk", "r4subrisk", "r4subrisk",
    "r4subrisk", "r4subrisk",
    # Usability
    "define_checker", "manual_review", "manual_review",
    "manual_review", "manual_review", "manual_review"
  ),
  tags = c(
    # Quality
    "cdisc,sdtm,adam", "cdisc,specification", "cdisc,label",
    "data_integrity", "cdisc,format", "data_integrity,range",
    "cdisc,ct", "iso8601,date", "relational,key", "encoding,character",
    # Trace
    "traceability,orphan", "traceability,level", "traceability,mapping",
    "traceability,derivation", "traceability,coverage", "traceability,coverage",
    "traceability,conflict", "specification,define",
    # Risk
    "fmea,rpn", "fmea,status", "fmea,mitigation", "fmea,critical",
    "fmea,aggregate", "fmea,trend",
    # Usability
    "define,completeness", "reviewer,feedback", "label,quality",
    "performance,size", "acrf,annotation", "navigation,usability"
  )
)

# ---- 6. evidence_pharma ----

# Build a realistic ~250 row evidence table
run_id <- "R4S-20250115120000-demo0001"
study_id <- "CDISCPILOT01"
created_at <- as.POSIXct("2025-01-15 12:00:00", tz = "UTC")

indicators <- list(
  list(id = "Q-MISS-VAR", name = "Missing Variables", domain = "quality"),
  list(id = "Q-TYPE-MISMATCH", name = "Type Mismatch", domain = "quality"),
  list(id = "Q-LABEL-LEN", name = "Label Length Violation", domain = "quality"),
  list(id = "Q-DUP-RECORDS", name = "Duplicate Records", domain = "quality"),
  list(id = "Q-FORMAT-ERR", name = "Format Error", domain = "quality"),
  list(id = "Q-VALUE-RANGE", name = "Value Out of Range", domain = "quality"),
  list(id = "Q-CT-COMPLIANCE", name = "Controlled Terminology Compliance", domain = "quality"),
  list(id = "Q-REF-INTEGRITY", name = "Referential Integrity", domain = "quality"),
  list(id = "T-ORPHAN-VAR", name = "Orphan Variable", domain = "trace"),
  list(id = "T-TRACE-LEVEL", name = "Traceability Level", domain = "trace"),
  list(id = "T-AMBIGUOUS-MAP", name = "Ambiguous Mapping", domain = "trace"),
  list(id = "T-DERIVATION-DOC", name = "Derivation Documentation", domain = "trace"),
  list(id = "R-HIGH-RPN", name = "High RPN Item", domain = "risk"),
  list(id = "R-OPEN-RISK", name = "Open Risk", domain = "risk"),
  list(id = "R-MITIGATION-GAP", name = "Mitigation Gap", domain = "risk"),
  list(id = "U-DEFINE-COMPLETE", name = "Define Completeness", domain = "usability"),
  list(id = "U-REVIEWER-NOTE", name = "Reviewer Note", domain = "usability"),
  list(id = "U-LABEL-QUALITY", name = "Label Quality", domain = "usability")
)

assets <- c("ADSL", "ADAE", "ADLB", "ADCM", "ADTTE", "DM", "AE", "LB",
             "define.xml")
asset_types <- c("dataset", "dataset", "dataset", "dataset", "dataset",
                 "dataset", "dataset", "dataset", "define")
sources <- c("pinnacle21", "r4subtrace", "r4subrisk", "manual_review",
             "define_checker")

n_rows <- 250L
rows <- vector("list", n_rows)

severity_pool <- c(rep("info", 25), rep("low", 25), rep("medium", 25),
                   rep("high", 15), rep("critical", 10))
result_pool <- c(rep("pass", 55), rep("warn", 20), rep("fail", 20),
                 rep("na", 5))

variables <- c("STUDYID", "USUBJID", "SUBJID", "SITEID", "AGE", "AGEU",
               "SEX", "RACE", "ARM", "AESEQ", "AEDECOD", "AEBODSYS",
               "AESEV", "PARAMCD", "PARAM", "AVAL", "BASE", "CHG",
               "AVISIT", "ABLFL", "AGEGR1", "TRT01P")

messages_quality <- c(
  "Variable %s missing from dataset %s",
  "Type mismatch for %s in %s: expected Char, found Num",
  "Label for %s exceeds 40 characters in %s",
  "Duplicate records detected for variable %s in %s",
  "Format error for %s in %s: expected BEST.",
  "Value out of range for %s in %s",
  "Controlled terminology violation for %s in %s",
  "Referential integrity check failed for %s in %s"
)
messages_trace <- c(
  "Variable %s in %s has no SDTM source mapping (orphan)",
  "Traceability level for %s in %s",
  "Variable %s in %s maps to multiple SDTM sources",
  "Derivation text missing for %s in %s"
)
messages_risk <- c(
  "High RPN detected for risk item affecting %s in %s",
  "Open risk remains for %s in %s",
  "No mitigation documented for risk related to %s in %s"
)
messages_usability <- c(
  "Define.xml entry incomplete for %s in %s",
  "Reviewer flagged %s in %s for clarification",
  "Label quality issue for %s in %s"
)

for (i in seq_len(n_rows)) {
  ind <- indicators[[sample(length(indicators), 1)]]
  asset_idx <- sample(length(assets), 1)
  asset_id <- assets[asset_idx]
  asset_type <- asset_types[asset_idx]
  src <- sample(sources, 1)
  sev <- sample(severity_pool, 1)
  res <- sample(result_pool, 1)
  var_name <- sample(variables, 1)
  loc <- paste0(asset_id, ":", var_name)

  msg_pool <- switch(ind$domain,
    quality = messages_quality,
    trace = messages_trace,
    risk = messages_risk,
    usability = messages_usability
  )
  msg <- sprintf(sample(msg_pool, 1), var_name, asset_id)

  mv <- if (ind$domain == "trace" && ind$id == "T-TRACE-LEVEL") {
    sample(0:3, 1)
  } else if (res == "pass") {
    1.0
  } else if (res == "fail") {
    0.0
  } else if (res == "warn") {
    round(runif(1, 0.3, 0.7), 2)
  } else {
    NA_real_
  }

  mu <- if (ind$domain == "trace" && ind$id == "T-TRACE-LEVEL") {
    "level"
  } else {
    "score"
  }

  payload <- sprintf('{"variable":"%s","dataset":"%s"}', var_name, asset_id)

  rows[[i]] <- list(
    run_id = run_id,
    study_id = study_id,
    asset_type = asset_type,
    asset_id = asset_id,
    source_name = src,
    source_version = "1.0.0",
    indicator_id = ind$id,
    indicator_name = ind$name,
    indicator_domain = ind$domain,
    severity = sev,
    result = res,
    metric_value = mv,
    metric_unit = mu,
    message = msg,
    location = loc,
    evidence_payload = payload,
    created_at = created_at
  )
}

evidence_pharma <- tibble(
  run_id = vapply(rows, `[[`, character(1), "run_id"),
  study_id = vapply(rows, `[[`, character(1), "study_id"),
  asset_type = vapply(rows, `[[`, character(1), "asset_type"),
  asset_id = vapply(rows, `[[`, character(1), "asset_id"),
  source_name = vapply(rows, `[[`, character(1), "source_name"),
  source_version = vapply(rows, `[[`, character(1), "source_version"),
  indicator_id = vapply(rows, `[[`, character(1), "indicator_id"),
  indicator_name = vapply(rows, `[[`, character(1), "indicator_name"),
  indicator_domain = vapply(rows, `[[`, character(1), "indicator_domain"),
  severity = vapply(rows, `[[`, character(1), "severity"),
  result = vapply(rows, `[[`, character(1), "result"),
  metric_value = vapply(rows, `[[`, double(1), "metric_value"),
  metric_unit = vapply(rows, `[[`, character(1), "metric_unit"),
  message = vapply(rows, `[[`, character(1), "message"),
  location = vapply(rows, `[[`, character(1), "location"),
  evidence_payload = vapply(rows, `[[`, character(1), "evidence_payload"),
  created_at = rep(created_at, n_rows)
)

# ---- Save all datasets ----

save(evidence_pharma, file = "data/evidence_pharma.rda", compress = "xz")
save(adam_metadata, file = "data/adam_metadata.rda", compress = "xz")
save(sdtm_metadata, file = "data/sdtm_metadata.rda", compress = "xz")
save(trace_mapping, file = "data/trace_mapping.rda", compress = "xz")
save(risk_register_pharma, file = "data/risk_register_pharma.rda", compress = "xz")
save(regulatory_indicators, file = "data/regulatory_indicators.rda", compress = "xz")

cat("All datasets saved to data/\n")
cat("  evidence_pharma:      ", nrow(evidence_pharma), "rows x",
    ncol(evidence_pharma), "cols\n")
cat("  adam_metadata:         ", nrow(adam_metadata), "rows x",
    ncol(adam_metadata), "cols\n")
cat("  sdtm_metadata:         ", nrow(sdtm_metadata), "rows x",
    ncol(sdtm_metadata), "cols\n")
cat("  trace_mapping:         ", nrow(trace_mapping), "rows x",
    ncol(trace_mapping), "cols\n")
cat("  risk_register_pharma:  ", nrow(risk_register_pharma), "rows x",
    ncol(risk_register_pharma), "cols\n")
cat("  regulatory_indicators: ", nrow(regulatory_indicators), "rows x",
    ncol(regulatory_indicators), "cols\n")
