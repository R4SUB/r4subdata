## Build the CNS (neuroscience) example bundle for r4subdata
## Run from package root: source("data-raw/build_cns.R")
##
## Adds a second synthetic therapeutic-area study, CNS-2025-001 (a Phase II
## Alzheimer's disease / CNS trial), mirroring the shape of the existing
## oncology bundle exactly so downstream functions work unchanged:
##   * cns_metadata       - ADaM metadata   (mirrors oncology_metadata)
##   * cns_evidence       - evidence table  (mirrors oncology_evidence)
##   * risk_register_cns  - FMEA register   (mirrors risk_register_oncology)
##   * sdtm_metadata_cns  - SDTM metadata   (mirrors sdtm_metadata_oncology)
##   * trace_mapping_cns  - trace mapping   (mirrors trace_mapping_oncology)
##
## All values are purely synthetic: no real patient data and no fabricated
## regulatory reference values. The CDISC SDTM/ADaM variable names/roles are
## used only as structure. The codelist codes reused here (C66731 SEX,
## C74457 RACE, NY) are the same ones already shipped in the oncology bundle.
## IDs line up across the trace mapping: every mapped ADaM variable exists in
## cns_metadata and every mapped SDTM variable exists in sdtm_metadata_cns, so
## the bundle round-trips through r4subtrace::build_trace_model() cleanly.

library(tibble)

set.seed(20250319)

study_id <- "CNS-2025-001"

# ---- cns_metadata: ADaM variable-level metadata (ADSL, ADQS, ADTTE) --------
# ADSL (subject level), ADQS (BDS questionnaire scores, e.g. cognitive scales),
# ADTTE (time-to-event, e.g. time to clinical progression). Mirrors the 7-col
# schema of oncology_metadata (dataset, variable, label, origin, derivation,
# codelist, type).

cns_metadata <- tibble(
  dataset = c(
    rep("ADSL",  14),
    rep("ADQS",  10),
    rep("ADTTE",  8)
  ),
  variable = c(
    # ADSL
    "STUDYID", "USUBJID", "SUBJID", "SITEID", "AGE", "SEX",
    "RACE", "ARM", "ARMCD", "TRT01P", "TRT01A",
    "EDUCLVL", "ITTFL", "SAFFL",
    # ADQS
    "STUDYID", "USUBJID", "PARAMCD", "PARAM", "AVAL", "AVALC",
    "AVISIT", "ADT", "QSSTRESC", "CHG",
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
    "Education Level", "Intent-To-Treat Population Flag",
    "Safety Population Flag",
    # ADQS
    "Study Identifier", "Unique Subject Identifier",
    "Parameter Code", "Parameter", "Analysis Value", "Analysis Value (C)",
    "Analysis Visit", "Analysis Date", "Standardized Result (C)",
    "Change from Baseline",
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
    # ADQS
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
    # ADQS
    NA, NA,
    "PARAMCD derived from QSTESTCD",
    "PARAM derived from QSTEST",
    "AVAL = standardized questionnaire score (QSSTRESN)",
    "AVALC = QSSTRESC verbatim standardized result",
    NA, NA, NA,
    "CHG = AVAL minus baseline AVAL",
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
    # ADQS
    NA, NA, NA, NA, NA, NA,
    NA, NA, NA, NA,
    # ADTTE
    NA, NA, NA, NA, NA, "NY", NA, NA
  ),
  type = c(
    # ADSL
    "Char", "Char", "Char", "Char", "Num", "Char",
    "Char", "Char", "Char", "Char", "Char",
    "Char", "Char", "Char",
    # ADQS
    "Char", "Char", "Char", "Char", "Num", "Char",
    "Char", "Char", "Char", "Num",
    # ADTTE
    "Char", "Char", "Char", "Char", "Num",
    "Num", "Char", "Char"
  )
)

# ---- sdtm_metadata_cns: SDTM domain metadata (DM, QS, SC) -------------------
# DM (Demographics), QS (Questionnaires - cognitive/functional scales),
# SC (Subject Characteristics - e.g. education) are the SDTM sources for the
# ADSL / ADQS / ADTTE analysis datasets. Mirrors the 6-col schema of
# sdtm_metadata_oncology (dataset, variable, label, type, length, format).

sdtm_metadata_cns <- tibble(
  dataset = c(
    rep("DM", 16), rep("QS", 14), rep("SC", 8)
  ),
  variable = c(
    # DM
    "STUDYID", "DOMAIN", "USUBJID", "SUBJID", "RFSTDTC", "RFENDTC",
    "SITEID", "BRTHDTC", "AGE", "AGEU", "SEX", "RACE",
    "ETHNIC", "ARMCD", "ARM", "COUNTRY",
    # QS
    "STUDYID", "DOMAIN", "USUBJID", "QSSEQ", "QSTESTCD", "QSTEST",
    "QSCAT", "QSORRES", "QSSTRESC", "QSSTRESN", "QSBLFL",
    "VISITNUM", "VISIT", "QSDTC",
    # SC
    "STUDYID", "DOMAIN", "USUBJID", "SCSEQ", "SCTESTCD", "SCTEST",
    "SCORRES", "SCSTRESC"
  ),
  label = c(
    # DM
    "Study Identifier", "Domain Abbreviation", "Unique Subject Identifier",
    "Subject Identifier for the Study",
    "Subject Reference Start Date/Time", "Subject Reference End Date/Time",
    "Study Site Identifier", "Date/Time of Birth", "Age", "Age Units",
    "Sex", "Race", "Ethnicity", "Planned Arm Code",
    "Description of Planned Arm", "Country",
    # QS
    "Study Identifier", "Domain Abbreviation", "Unique Subject Identifier",
    "Sequence Number", "Question Short Name", "Question Name",
    "Category of Question", "Finding in Original Units",
    "Character Result/Finding in Std Format",
    "Numeric Finding in Standard Units", "Baseline Flag",
    "Visit Number", "Visit Name", "Date/Time of Finding",
    # SC
    "Study Identifier", "Domain Abbreviation", "Unique Subject Identifier",
    "Sequence Number", "Subject Characteristic Short Name",
    "Subject Characteristic", "Result or Finding in Original Units",
    "Character Result/Finding in Std Format"
  ),
  type = c(
    # DM
    "Char", "Char", "Char", "Char", "Char", "Char",
    "Char", "Char", "Num", "Char", "Char", "Char",
    "Char", "Char", "Char", "Char",
    # QS
    "Char", "Char", "Char", "Num", "Char", "Char",
    "Char", "Char", "Char", "Num", "Char",
    "Num", "Char", "Char",
    # SC
    "Char", "Char", "Char", "Num", "Char", "Char",
    "Char", "Char"
  ),
  length = c(
    # DM
    12L, 2L, 20L, 8L, 19L, 19L, 4L, 19L, 8L, 6L, 2L, 40L,
    40L, 20L, 40L, 3L,
    # QS
    12L, 2L, 20L, 8L, 8L, 40L, 40L, 40L, 40L, 8L, 1L,
    8L, 40L, 19L,
    # SC
    12L, 2L, 20L, 8L, 8L, 40L, 40L, 40L
  ),
  format = c(
    # DM
    NA, NA, NA, NA, NA, NA, NA, NA, "BEST.", NA, NA, NA,
    NA, NA, NA, NA,
    # QS
    NA, NA, NA, "BEST.", NA, NA, NA, NA, NA, "BEST.", NA,
    "BEST.", NA, NA,
    # SC
    NA, NA, NA, "BEST.", NA, NA, NA, NA
  )
)

# ---- trace_mapping_cns: ADaM-to-SDTM traceability mapping -------------------
# Maps the ADSL / ADQS / ADTTE variables in cns_metadata to their CNS SDTM
# sources in sdtm_metadata_cns. Derived variables carry NA domain/variable and
# NA confidence, mirroring trace_mapping_oncology.

trace_mapping_cns <- tibble(
  adam_dataset = c(
    rep("ADSL", 12),
    rep("ADQS", 10),
    rep("ADTTE", 8)
  ),
  adam_var = c(
    # ADSL
    "STUDYID", "USUBJID", "SUBJID", "SITEID", "AGE", "SEX",
    "RACE", "ARM", "ARMCD", "TRT01P", "TRT01A", "EDUCLVL",
    # ADQS
    "STUDYID", "USUBJID", "PARAMCD", "PARAM", "AVAL", "AVALC",
    "AVISIT", "ADT", "QSSTRESC", "CHG",
    # ADTTE
    "STUDYID", "USUBJID", "STARTDT", "PARAMCD", "PARAM", "AVAL",
    "CNSR", "EVNTDESC"
  ),
  sdtm_domain = c(
    # ADSL -> DM / SC / derived
    "DM", "DM", "DM", "DM", "DM", "DM", "DM", "DM", "DM", "DM", NA, "SC",
    # ADQS -> QS / derived
    "QS", "QS", "QS", "QS", "QS", "QS", "QS", "QS", "QS", NA,
    # ADTTE -> DM (anchor) / derived
    "DM", "DM", "DM", NA, NA, NA, NA, NA
  ),
  sdtm_var = c(
    # ADSL -> DM / SC / derived
    "STUDYID", "USUBJID", "SUBJID", "SITEID", "AGE", "SEX",
    "RACE", "ARM", "ARMCD", "ARM", NA, "SCSTRESC",
    # ADQS -> QS / derived
    "STUDYID", "USUBJID", "QSTESTCD", "QSTEST", "QSSTRESN", "QSSTRESC",
    "VISIT", "QSDTC", "QSSTRESC", NA,
    # ADTTE -> DM / derived
    "STUDYID", "USUBJID", "RFSTDTC", NA, NA, NA, NA, NA
  ),
  derivation_text = c(
    # ADSL
    "Direct copy from DM.STUDYID",
    "Direct copy from DM.USUBJID",
    "Direct copy from DM.SUBJID",
    "Direct copy from DM.SITEID",
    "Direct copy from DM.AGE",
    "Direct copy from DM.SEX",
    "Direct copy from DM.RACE",
    "Direct copy from DM.ARM",
    "Direct copy from DM.ARMCD",
    "Planned treatment assigned from DM.ARM",
    "Actual treatment derived from EX exposure records",
    "Education level mapped from SC where SCTESTCD=EDLEVEL",
    # ADQS
    "Direct copy from QS.STUDYID",
    "Direct copy from QS.USUBJID",
    "Mapped from QS.QSTESTCD via parameter lookup",
    "Mapped from QS.QSTEST via parameter lookup",
    "Numeric score copied from QS.QSSTRESN",
    "Character result copied from QS.QSSTRESC",
    "Mapped from QS.VISIT via visit windowing",
    "Analysis date derived from QS.QSDTC",
    "Direct copy from QS.QSSTRESC",
    "Change from baseline = AVAL minus baseline AVAL",
    # ADTTE
    "Direct copy from DM.STUDYID",
    "Direct copy from DM.USUBJID",
    "Time-to-event origin set to DM.RFSTDTC",
    "PARAMCD from analysis parameter lookup",
    "PARAM from analysis parameter lookup",
    "AVAL = days from STARTDT to event or censoring",
    "CNSR = 0 if event; 1 if censored",
    "Event description derived from QS decline or DS discontinuation record"
  ),
  confidence = c(
    # ADSL
    1.0, 1.0, 1.0, 1.0, 0.95, 1.0, 1.0, 1.0, 1.0, 0.90, NA, 0.90,
    # ADQS
    1.0, 1.0, 0.90, 0.90, 0.95, 1.0, 0.90, 0.95, 1.0, NA,
    # ADTTE
    1.0, 1.0, 0.95, NA, NA, NA, NA, NA
  )
)

# ---- risk_register_cns: FMEA risk register ---------------------------------
# Mirrors the 9-col schema of risk_register_oncology EXACTLY and reflects
# realistic CNS submission risks (cognitive endpoints, time-to-progression,
# program validation). 1-5 FMEA scale for probability / impact / detectability.

risk_register_cns <- tibble(
  risk_id = paste0("CNS-RISK-", sprintf("%03d", 1:15)),
  description = c(
    "ADAS-Cog total score (AVAL) missing for 3 ADQS subjects",
    "ADQS change-from-baseline (CHG) inconsistent with ADaM metadata",
    "Three derived ADQS variables lack documented derivation text",
    "prod_adqs.R program validation plan (DVP) not submitted",
    "Independent QC not completed for ADQS questionnaire dataset",
    "ADTTE censoring flag (CNSR) derivation ambiguous for early withdrawals",
    "Time-to-event start date (STARTDT) missing for subset of ADTTE subjects",
    "Define.xml missing Label attribute for one CNS variable",
    "ADQS annotation coverage below 100% target for derived variables",
    "Baseline questionnaire visit window not applied per protocol",
    "ADTTE QC in progress and not finalized before database lock",
    "Questionnaire category (QSCAT) values not aligned across sources",
    "Subject count mismatch between ADSL and ADQS populations",
    "Time-to-progression derivation not fully reproducible",
    "Analysis reviewer guide (ADRG) lacks CNS endpoint description"
  ),
  category = c(
    "data_quality", "data_quality", "traceability", "programming",
    "compliance", "traceability", "data_quality", "documentation",
    "documentation", "compliance", "programming", "compliance",
    "data_quality", "programming", "documentation"
  ),
  probability = c(
    3L, 3L, 4L, 4L, 4L, 2L, 2L, 2L, 3L, 2L, 3L, 2L, 2L, 3L, 3L
  ),
  impact = c(
    4L, 3L, 4L, 4L, 4L, 3L, 4L, 2L, 3L, 4L, 4L, 3L, 4L, 5L, 2L
  ),
  detectability = c(
    2L, 2L, 4L, 1L, 2L, 4L, 3L, 2L, 3L, 4L, 2L, 3L, 2L, 3L, 2L
  ),
  owner = c(
    "Data Management", "Statistical Programming", "Statistical Programming",
    "Quality Assurance", "Quality Assurance", "Statistical Programming",
    "Data Management", "Medical Writing", "Statistical Programming",
    "Biostatistics", "Statistical Programming", "Data Management",
    "Data Management", "Biostatistics", "Medical Writing"
  ),
  mitigation = c(
    "Query sites for missing assessments; re-derive ADAS-Cog total",
    "Align CHG derivation with ADaM specification and re-run checks",
    "Document derivation rules in define.xml and traceability mapping",
    "Complete and submit DVP before independent QC sign-off",
    "Schedule independent QC and record results before lock",
    NA,
    "Impute or query STARTDT per SAP; document imputation method",
    "Add missing Label attribute to define.xml and revalidate",
    "Annotate remaining derived variables in the aCRF",
    "Apply baseline visit window and re-derive baseline score",
    "Finalize ADTTE QC and reconcile before database lock",
    "Reconcile QSCAT values to a single controlled list across sources",
    NA,
    "Set random seeds and document software versions for TTP derivation",
    "Add CNS endpoint section to the ADRG"
  ),
  status = c(
    "open", "open", "open", "open", "open", "mitigated", "open",
    "mitigated", "open", "accepted", "open", "open", "closed",
    "open", "mitigated"
  )
)

# ---- cns_evidence: R4SUB evidence table ------------------------------------
# Mirrors the 17-col schema of oncology_evidence for study CNS-2025-001.

run_id <- "run-cns-001"
ts     <- as.POSIXct("2025-03-19 09:00:00", tz = "UTC")

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
  make_ev("dataset", "ADQS", "pinnacle21", "3.1.1",
          "Q-MISS-VAR", "Missing Variable", "quality",
          "medium", "warn", 3, "count",
          "ADQS: AVAL missing for 3 subjects", "ADQS:AVAL"),
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
          "medium", "warn", 0.94, "proportion",
          "1 variable missing Label attribute in define.xml", "define.xml"),
  make_ev("dataset", "ADSL", "r4subcore", "0.1.2",
          "Q-FORMAT", "Format Consistency", "quality",
          "info", "pass", 1, "score",
          "ADSL: all formats consistent with metadata", "ADSL"),
  make_ev("dataset", "ADQS", "r4subcore", "0.1.2",
          "Q-FORMAT", "Format Consistency", "quality",
          "high", "fail", 0, "score",
          "ADQS: CHG numeric format mismatch", "ADQS:CHG"),
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
          "info", "pass", 0.92, "proportion",
          "ADSL: 92% of variables traced to SDTM source", "ADSL"),
  make_ev("spec", "ADQS", "r4subtrace", "0.1.0",
          "T-001", "SDTM-to-ADaM Mapping", "trace",
          "medium", "warn", 0.90, "proportion",
          "ADQS: 90% of variables traced to SDTM source", "ADQS"),
  make_ev("spec", "ADTTE", "r4subtrace", "0.1.0",
          "T-001", "SDTM-to-ADaM Mapping", "trace",
          "info", "pass", 1.0, "proportion",
          "ADTTE: 100% of variables traced to SDTM source", "ADTTE"),
  make_ev("spec", "ADSL", "r4subtrace", "0.1.0",
          "T-002", "Derivation Documented", "trace",
          "info", "pass", 1.0, "proportion",
          "ADSL: all derived variables have derivation text", "ADSL"),
  make_ev("spec", "ADQS", "r4subtrace", "0.1.0",
          "T-002", "Derivation Documented", "trace",
          "high", "fail", 0.70, "proportion",
          "ADQS: 3 derived variables missing derivation", "ADQS"),
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
  make_ev("program", "prod_adqs.R", "r4subrisk", "0.1.0",
          "R-001", "Program Validation", "risk",
          "high", "fail", 0, "score",
          "prod_adqs.R: DVP not submitted", "prod_adqs.R"),
  make_ev("program", "prod_adtte.R", "r4subrisk", "0.1.0",
          "R-001", "Program Validation", "risk",
          "medium", "warn", 0.5, "score",
          "prod_adtte.R: DVP draft, not approved", "prod_adtte.R"),
  make_ev("validation", "ADSL", "r4subrisk", "0.1.0",
          "R-002", "Independent QC", "risk",
          "info", "pass", 1, "score",
          "ADSL: independent QC completed", "ADSL"),
  make_ev("validation", "ADQS", "r4subrisk", "0.1.0",
          "R-002", "Independent QC", "risk",
          "high", "fail", 0, "score",
          "ADQS: independent QC not completed", "ADQS"),
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
  make_ev("spec", "ADQS", "r4subusability", "0.1.0",
          "U-001", "Variable Label Quality", "usability",
          "medium", "warn", 0.9, "score",
          "ADQS: 1 label exceeds 40 chars", "ADQS:QSSTRESC"),
  make_ev("define", "define.xml", "r4subusability", "0.1.0",
          "U-002", "Define-XML Completeness", "usability",
          "info", "pass", 1, "score",
          "All required Define-XML fields populated", "define.xml"),
  make_ev("spec", "ADQS", "r4subusability", "0.1.0",
          "U-003", "Annotation Coverage", "usability",
          "medium", "warn", 0.80, "proportion",
          "ADQS: 80% of derived variables annotated", "ADQS"),
  make_ev("spec", "ADSL", "r4subusability", "0.1.0",
          "U-003", "Annotation Coverage", "usability",
          "info", "pass", 1.0, "proportion",
          "ADSL: 100% of derived variables annotated", "ADSL"),
  make_ev("spec", "submission_package", "r4subusability", "0.1.0",
          "U-004", "Reviewer Guide Presence", "usability",
          "info", "pass", 1, "score",
          "ADRG detected in submission package", "submission_package")
)

cns_evidence <- rbind(q_rows, t_rows, r_rows, u_rows)

# ---- Internal-consistency checks -------------------------------------------

# Schemas mirror the oncology / pharma equivalents exactly.
stopifnot(
  identical(names(cns_metadata),      names(r4subdata::oncology_metadata)),
  identical(names(cns_evidence),      names(r4subdata::oncology_evidence)),
  identical(names(risk_register_cns), names(r4subdata::risk_register_pharma)),
  identical(names(sdtm_metadata_cns), names(r4subdata::sdtm_metadata)),
  identical(names(trace_mapping_cns), names(r4subdata::trace_mapping))
)

# Mapped ADaM variables must exist in cns_metadata.
adam_keys <- paste0(cns_metadata$dataset, ".", cns_metadata$variable)
map_keys  <- paste0(trace_mapping_cns$adam_dataset, ".",
                    trace_mapping_cns$adam_var)
stopifnot(all(map_keys %in% adam_keys))

# Mapped SDTM variables must exist in sdtm_metadata_cns.
sdtm_keys <- paste0(sdtm_metadata_cns$dataset, ".", sdtm_metadata_cns$variable)
mapped    <- !is.na(trace_mapping_cns$sdtm_domain)
sdtm_ref  <- paste0(trace_mapping_cns$sdtm_domain[mapped], ".",
                    trace_mapping_cns$sdtm_var[mapped])
stopifnot(all(sdtm_ref %in% sdtm_keys))

# Confidence scores are in [0, 1] where present.
conf <- trace_mapping_cns$confidence
stopifnot(all(conf[!is.na(conf)] >= 0 & conf[!is.na(conf)] <= 1))

# Evidence study id and risk ids are internally consistent.
stopifnot(
  all(cns_evidence$study_id == study_id),
  all(grepl("^CNS-RISK-[0-9]{3}$", risk_register_cns$risk_id))
)

usethis::use_data(cns_metadata,      overwrite = TRUE, compress = "bzip2")
usethis::use_data(cns_evidence,      overwrite = TRUE, compress = "bzip2")
usethis::use_data(risk_register_cns, overwrite = TRUE, compress = "bzip2")
usethis::use_data(sdtm_metadata_cns, overwrite = TRUE, compress = "bzip2")
usethis::use_data(trace_mapping_cns, overwrite = TRUE, compress = "bzip2")

message("cns_metadata:       ", nrow(cns_metadata),      " rows x ",
        ncol(cns_metadata),      " cols")
message("cns_evidence:       ", nrow(cns_evidence),      " rows x ",
        ncol(cns_evidence),      " cols")
message("risk_register_cns:  ", nrow(risk_register_cns), " rows x ",
        ncol(risk_register_cns), " cols")
message("sdtm_metadata_cns:  ", nrow(sdtm_metadata_cns), " rows x ",
        ncol(sdtm_metadata_cns), " cols")
message("trace_mapping_cns:  ", nrow(trace_mapping_cns), " rows x ",
        ncol(trace_mapping_cns), " cols")
