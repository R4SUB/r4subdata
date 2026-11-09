## Build the oncology FMEA risk register for r4subdata
## Run from package root: source("data-raw/build_risk_register_oncology.R")
##
## Mirrors the schema of risk_register_pharma EXACTLY (same columns/types)
## and is internally consistent with oncology_metadata / oncology_evidence
## for the synthetic study ONCO-2025-001 (ADSL, ADRS, ADTTE).

library(tibble)

set.seed(20250317)

# Study referenced by oncology_metadata and oncology_evidence
study_id <- "ONCO-2025-001"

risk_register_oncology <- tibble(
  risk_id = paste0("ONCO-RISK-", sprintf("%03d", 1:15)),
  description = c(
    "RECIST 1.1 overall response (OVRLRESP) missing for 2 ADRS subjects",
    "ADRS AVAL numeric format inconsistent with ADaM metadata",
    "Three derived ADRS variables lack documented derivation text",
    "prod_adrs.R program validation plan (DVP) not submitted",
    "Independent QC not completed for ADRS response dataset",
    "ADTTE censoring flag (CNSR) derivation ambiguous for early terminations",
    "Time-to-event start date (STARTDT) missing for subset of ADTTE subjects",
    "Define.xml missing Label attribute for one oncology variable",
    "ADRS annotation coverage below 100% target for derived variables",
    "Tumor response confirmation window not applied per protocol",
    "ADTTE QC in progress and not finalized before database lock",
    "RECIST response codelist (C96643) version mismatch across sources",
    "Subject count mismatch between ADSL and ADRS populations",
    "Progression-free survival derivation not fully reproducible",
    "Analysis reviewer guide (ADRG) lacks oncology endpoint description"
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
    "Biostatistics", "Statistical Programming", "Medical Coding",
    "Data Management", "Biostatistics", "Medical Writing"
  ),
  mitigation = c(
    "Query sites for missing response assessments; re-derive OVRLRESP",
    "Align AVAL display format with ADaM specification and re-run checks",
    "Document derivation rules in define.xml and traceability mapping",
    "Complete and submit DVP before independent QC sign-off",
    "Schedule independent QC and record results before lock",
    NA,
    "Impute or query STARTDT per SAP; document imputation method",
    "Add missing Label attribute to define.xml and revalidate",
    "Annotate remaining derived variables in the aCRF",
    "Apply RECIST confirmation window and re-derive overall response",
    "Finalize ADTTE QC and reconcile before database lock",
    "Re-map response terms to current CDISC controlled terminology",
    NA,
    "Set random seeds and document software versions for PFS derivation",
    "Add oncology endpoint section to the ADRG"
  ),
  status = c(
    "open", "open", "open", "open", "open", "mitigated", "open",
    "mitigated", "open", "accepted", "open", "open", "closed",
    "open", "mitigated"
  )
)

stopifnot(
  nrow(risk_register_oncology) == 15L,
  identical(names(risk_register_oncology), names(r4subdata::risk_register_pharma))
)

usethis::use_data(risk_register_oncology, overwrite = TRUE)

message("risk_register_oncology: ", nrow(risk_register_oncology), " rows (",
        study_id, ")")
