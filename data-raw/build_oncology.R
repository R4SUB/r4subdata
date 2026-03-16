## Build oncology example datasets for r4subdata
## Run from package root: source("data-raw/build_oncology.R")

library(tibble)

set.seed(20250316)

# ---- oncology_metadata: ADaM variable-level metadata for oncology trial ----
# Covers ADSL, ADRS (Response), ADTTE (Time-to-Event)

oncology_metadata <- tibble(
  dataset = c(
    rep("ADSL",  14),
    rep("ADRS",  10),
    rep("ADTTE",  8)
  ),
  variable = c(
    # ADSL
    "STUDYID", "USUBJID", "SUBJID", "SITEID", "AGE", "SEX",
    "RACE", "ARM", "ARMCD", "TRT01P", "TRT01A",
    "DIAGDTC", "ITTFL", "SAFFL",
    # ADRS
    "STUDYID", "USUBJID", "PARAMCD", "PARAM", "AVAL", "AVALC",
    "AVISIT", "ADT", "RSSTRESC", "OVRLRESP",
    # ADTTE
    "STUDYID", "USUBJID", "PARAMCD", "PARAM", "AVAL",
    "CNSR", "EVNTDESC", "STARTDT"
  ),
  label = c(
    # ADSL
    "Study Identifier", "Unique Subject Identifier", "Subject Identifier",
    "Study Site Identifier", "Age", "Sex", "Race",
    "Planned Arm", "Planned Arm Code",
    "Planned Treatment for Period 01", "Actual Treatment for Period 01",
    "Date of Initial Diagnosis", "Intent-To-Treat Population Flag",
    "Safety Population Flag",
    # ADRS
    "Study Identifier", "Unique Subject Identifier",
    "Parameter Code", "Parameter", "Analysis Value", "Analysis Value (C)",
    "Analysis Visit", "Analysis Date", "Response (RECIST)",
    "Overall Response",
    # ADTTE
    "Study Identifier", "Unique Subject Identifier",
    "Parameter Code", "Parameter", "Analysis Value",
    "Censor", "Event Description", "Start Date"
  ),
  origin = c(
    # ADSL
    "CRF", "CRF", "CRF", "CRF", "CRF", "CRF",
    "CRF", "Assigned", "Derived", "Assigned", "Assigned",
    "CRF", "Derived", "Derived",
    # ADRS
    "CRF", "CRF", "Derived", "Derived", "Derived", "Derived",
    "CRF", "CRF", "CRF", "Derived",
    # ADTTE
    "CRF", "CRF", "Derived", "Derived", "Derived",
    "Derived", "Derived", "CRF"
  ),
  derivation = c(
    # ADSL
    NA, NA, NA, NA, NA, NA,
    NA, NA, "Derived from ARMN", NA, NA,
    NA,
    "Set to Y if subject in ITT population per SAP",
    "Set to Y if subject received at least one dose",
    # ADRS
    NA, NA,
    "PARAMCD derived from RSTESTCD",
    "PARAM derived from RSTEST",
    "AVAL = 1 (CR), 2 (PR), 3 (SD), 4 (PD)",
    "AVALC = RSSTRESC verbatim response text",
    NA, NA, NA,
    "Overall response determined per RECIST 1.1 criteria",
    # ADTTE
    NA, NA,
    "PARAMCD from analysis parameter lookup",
    "PARAM from analysis parameter lookup",
    "AVAL = days from STARTDT to event or censoring",
    "CNSR = 0 if event; 1 if censored",
    "Description of event trigger condition",
    NA
  ),
  codelist = c(
    # ADSL
    NA, NA, NA, NA, NA, "C66731",
    "C74457", NA, NA, NA, NA,
    NA, "NY", "NY",
    # ADRS
    NA, NA, NA, NA, NA, "C96643",
    NA, NA, "C96643", "C96643",
    # ADTTE
    NA, NA, NA, NA, NA, "NY", NA, NA
  ),
  type = c(
    # ADSL
    "Char", "Char", "Char", "Char", "Num", "Char",
    "Char", "Char", "Char", "Char", "Char",
    "Char", "Char", "Char",
    # ADRS
    "Char", "Char", "Char", "Char", "Num", "Char",
    "Char", "Char", "Char", "Char",
    # ADTTE
    "Char", "Char", "Char", "Char", "Num",
    "Num", "Char", "Char"
  )
)

# ---- oncology_evidence: evidence table for synthetic oncology trial ----

study_id <- "ONCO-2025-001"
run_id   <- "run-onco-001"
ts       <- as.POSIXct("2025-03-16 09:00:00", tz = "UTC")

make_ev <- function(asset_type, asset_id, source_name, source_version,
                    indicator_id, indicator_name, indicator_domain,
                    severity, result, metric_value, metric_unit,
                    message, location) {
  tibble(
    run_id           = run_id,
    study_id         = study_id,
    asset_type       = asset_type,
    asset_id         = asset_id,
    source_name      = source_name,
    source_version   = source_version,
    indicator_id     = indicator_id,
    indicator_name   = indicator_name,
    indicator_domain = indicator_domain,
    severity         = severity,
    result           = result,
    metric_value     = metric_value,
    metric_unit      = metric_unit,
    message          = message,
    location         = location,
    evidence_payload = "{}",
    created_at       = ts
  )
}

# Quality indicators
q_rows <- rbind(
  make_ev("dataset", "ADSL", "pinnacle21", "3.1.1",
          "Q-MISS-VAR", "Missing Variable", "quality",
          "info", "pass", 0, "count",
          "ADSL: no missing required variables", "ADSL"),
  make_ev("dataset", "ADRS", "pinnacle21", "3.1.1",
          "Q-MISS-VAR", "Missing Variable", "quality",
          "medium", "warn", 1, "count",
          "ADRS: OVRLRESP missing for 2 subjects", "ADRS:OVRLRESP"),
  make_ev("dataset", "ADTTE", "pinnacle21", "3.1.1",
          "Q-MISS-VAR", "Missing Variable", "quality",
          "info", "pass", 0, "count",
          "ADTTE: no missing required variables", "ADTTE"),
  make_ev("define", "define.xml", "metacore", "1.0.0",
          "Q-DEFINE-001", "Dataset Description", "quality",
          "info", "pass", 1, "score",
          "All datasets have Description attribute", "define.xml"),
  make_ev("define", "define.xml", "metacore", "1.0.0",
          "Q-DEFINE-002", "Variable Label", "quality",
          "medium", "warn", 0.93, "proportion",
          "1 variable missing Label attribute in define.xml", "define.xml"),
  make_ev("dataset", "ADSL", "r4subcore", "0.1.2",
          "Q-FORMAT", "Format Consistency", "quality",
          "info", "pass", 1, "score",
          "ADSL: all formats consistent with metadata", "ADSL"),
  make_ev("dataset", "ADRS", "r4subcore", "0.1.2",
          "Q-FORMAT", "Format Consistency", "quality",
          "high", "fail", 0, "score",
          "ADRS: AVAL numeric format mismatch", "ADRS:AVAL"),
  make_ev("dataset", "ADTTE", "r4subcore", "0.1.2",
          "Q-FORMAT", "Format Consistency", "quality",
          "info", "pass", 1, "score",
          "ADTTE: all formats consistent with metadata", "ADTTE"),
  make_ev("validation", "ADSL", "r4subcore", "0.1.2",
          "Q-KEYS", "Key Variable Presence", "quality",
          "info", "pass", 1, "score",
          "ADSL: USUBJID and STUDYID present", "ADSL"),
  make_ev("validation", "ADTTE", "r4subcore", "0.1.2",
          "Q-KEYS", "Key Variable Presence", "quality",
          "info", "pass", 1, "score",
          "ADTTE: USUBJID, PARAMCD, CNSR present", "ADTTE")
)

# Traceability indicators
t_rows <- rbind(
  make_ev("spec", "ADSL", "r4subtrace", "0.1.0",
          "T-001", "SDTM-to-ADaM Mapping", "trace",
          "info", "pass", 0.94, "proportion",
          "ADSL: 94% of variables traced to SDTM source", "ADSL"),
  make_ev("spec", "ADRS", "r4subtrace", "0.1.0",
          "T-001", "SDTM-to-ADaM Mapping", "trace",
          "medium", "warn", 0.80, "proportion",
          "ADRS: 80% of variables traced to SDTM source", "ADRS"),
  make_ev("spec", "ADTTE", "r4subtrace", "0.1.0",
          "T-001", "SDTM-to-ADaM Mapping", "trace",
          "info", "pass", 1.0, "proportion",
          "ADTTE: 100% of variables traced to SDTM source", "ADTTE"),
  make_ev("spec", "ADSL", "r4subtrace", "0.1.0",
          "T-002", "Derivation Documented", "trace",
          "info", "pass", 1.0, "proportion",
          "ADSL: all derived variables have derivation text", "ADSL"),
  make_ev("spec", "ADRS", "r4subtrace", "0.1.0",
          "T-002", "Derivation Documented", "trace",
          "high", "fail", 0.70, "proportion",
          "ADRS: 3 derived variables missing derivation", "ADRS"),
  make_ev("spec", "ADTTE", "r4subtrace", "0.1.0",
          "T-002", "Derivation Documented", "trace",
          "info", "pass", 1.0, "proportion",
          "ADTTE: all derived variables documented", "ADTTE")
)

# Risk indicators
r_rows <- rbind(
  make_ev("program", "prod_adsl.R", "r4subrisk", "0.1.0",
          "R-001", "Program Validation", "risk",
          "info", "pass", 1, "score",
          "prod_adsl.R: DVP complete and approved", "prod_adsl.R"),
  make_ev("program", "prod_adrs.R", "r4subrisk", "0.1.0",
          "R-001", "Program Validation", "risk",
          "high", "fail", 0, "score",
          "prod_adrs.R: DVP not submitted", "prod_adrs.R"),
  make_ev("program", "prod_adtte.R", "r4subrisk", "0.1.0",
          "R-001", "Program Validation", "risk",
          "medium", "warn", 0.5, "score",
          "prod_adtte.R: DVP draft, not approved", "prod_adtte.R"),
  make_ev("validation", "ADSL", "r4subrisk", "0.1.0",
          "R-002", "Independent QC", "risk",
          "info", "pass", 1, "score",
          "ADSL: independent QC completed", "ADSL"),
  make_ev("validation", "ADRS", "r4subrisk", "0.1.0",
          "R-002", "Independent QC", "risk",
          "high", "fail", 0, "score",
          "ADRS: independent QC not completed", "ADRS"),
  make_ev("validation", "ADTTE", "r4subrisk", "0.1.0",
          "R-002", "Independent QC", "risk",
          "medium", "warn", 0.5, "score",
          "ADTTE: QC in progress, not final", "ADTTE"),
  make_ev("spec", "submission_package", "r4subrisk", "0.1.0",
          "R-003", "Submission Checklist", "risk",
          "info", "pass", 1, "score",
          "All required submission components listed", "submission_package")
)

# Usability indicators
u_rows <- rbind(
  make_ev("spec", "ADSL", "r4subusability", "0.1.0",
          "U-001", "Variable Label Quality", "usability",
          "info", "pass", 1, "score",
          "ADSL: all labels within acceptable length range", "ADSL"),
  make_ev("spec", "ADRS", "r4subusability", "0.1.0",
          "U-001", "Variable Label Quality", "usability",
          "medium", "warn", 0.9, "score",
          "ADRS: 1 label exceeds 40 chars", "ADRS:OVRLRESP"),
  make_ev("define", "define.xml", "r4subusability", "0.1.0",
          "U-002", "Define-XML Completeness", "usability",
          "info", "pass", 1, "score",
          "All required Define-XML fields populated", "define.xml"),
  make_ev("spec", "ADRS", "r4subusability", "0.1.0",
          "U-003", "Annotation Coverage", "usability",
          "medium", "warn", 0.80, "proportion",
          "ADRS: 80% of derived variables annotated", "ADRS"),
  make_ev("spec", "ADSL", "r4subusability", "0.1.0",
          "U-003", "Annotation Coverage", "usability",
          "info", "pass", 1.0, "proportion",
          "ADSL: 100% of derived variables annotated", "ADSL"),
  make_ev("spec", "submission_package", "r4subusability", "0.1.0",
          "U-004", "Reviewer Guide Presence", "usability",
          "info", "pass", 1, "score",
          "ADRG detected in submission package", "submission_package")
)

oncology_evidence <- rbind(q_rows, t_rows, r_rows, u_rows)

# Save datasets
usethis::use_data(oncology_metadata, overwrite = TRUE)
usethis::use_data(oncology_evidence,  overwrite = TRUE)

message("oncology_metadata: ", nrow(oncology_metadata), " rows")
message("oncology_evidence: ",  nrow(oncology_evidence),  " rows")
