## Build oncology SDTM metadata and traceability mapping for r4subdata
## Run from package root: source("data-raw/build_trace_oncology.R")
##
## Adds two synthetic datasets for the existing oncology study ONCO-2025-001:
##   * sdtm_metadata_oncology - mirrors the schema of sdtm_metadata
##   * trace_mapping_oncology  - mirrors the schema of trace_mapping
##
## Both are internally consistent with oncology_metadata (same ADaM variable
## names / derivations) and use plausible oncology SDTM domains (DM, RS, TU).
## They are purely synthetic: no real patient data. The mapping references
## only ADaM variables present in oncology_metadata and SDTM variables present
## in sdtm_metadata_oncology, so it round-trips through
## r4subtrace::build_trace_model() cleanly.

library(tibble)

set.seed(20250318)

# ---- sdtm_metadata_oncology: SDTM domain metadata (DM, RS, TU) ----
# DM (Demographics), RS (Disease Response, RECIST 1.1), TU (Tumor
# Identification) are the SDTM sources for the ADSL / ADRS / ADTTE analysis
# datasets described by oncology_metadata.

sdtm_metadata_oncology <- tibble(
  dataset = c(
    rep("DM", 16), rep("RS", 13), rep("TU", 9)
  ),
  variable = c(
    # DM
    "STUDYID", "DOMAIN", "USUBJID", "SUBJID", "RFSTDTC", "RFENDTC",
    "SITEID", "BRTHDTC", "AGE", "AGEU", "SEX", "RACE",
    "ETHNIC", "ARMCD", "ARM", "COUNTRY",
    # RS
    "STUDYID", "DOMAIN", "USUBJID", "RSSEQ", "RSTESTCD", "RSTEST",
    "RSCAT", "RSORRES", "RSSTRESC", "RSEVAL", "VISITNUM", "VISIT", "RSDTC",
    # TU
    "STUDYID", "DOMAIN", "USUBJID", "TUSEQ", "TUTESTCD", "TUTEST",
    "TULOC", "TUORRES", "TUDTC"
  ),
  label = c(
    # DM
    "Study Identifier", "Domain Abbreviation", "Unique Subject Identifier",
    "Subject Identifier for the Study",
    "Subject Reference Start Date/Time", "Subject Reference End Date/Time",
    "Study Site Identifier", "Date/Time of Birth", "Age", "Age Units",
    "Sex", "Race", "Ethnicity", "Planned Arm Code",
    "Description of Planned Arm", "Country",
    # RS
    "Study Identifier", "Domain Abbreviation", "Unique Subject Identifier",
    "Sequence Number", "Response Short Name", "Response Test Name",
    "Category for Response", "Result or Finding in Original Units",
    "Character Result/Finding in Std Format", "Evaluator",
    "Visit Number", "Visit Name", "Date/Time of Assessment",
    # TU
    "Study Identifier", "Domain Abbreviation", "Unique Subject Identifier",
    "Sequence Number", "Tumor Identification Short Name",
    "Tumor Identification Test Name", "Location of the Tumor",
    "Result or Finding in Original Units", "Date/Time of Assessment"
  ),
  type = c(
    # DM
    "Char", "Char", "Char", "Char", "Char", "Char",
    "Char", "Char", "Num", "Char", "Char", "Char",
    "Char", "Char", "Char", "Char",
    # RS
    "Char", "Char", "Char", "Num", "Char", "Char",
    "Char", "Char", "Char", "Char", "Num", "Char", "Char",
    # TU
    "Char", "Char", "Char", "Num", "Char", "Char",
    "Char", "Char", "Char"
  ),
  length = c(
    # DM
    12L, 2L, 20L, 8L, 19L, 19L, 4L, 19L, 8L, 6L, 2L, 40L,
    40L, 20L, 40L, 3L,
    # RS
    12L, 2L, 20L, 8L, 8L, 40L, 40L, 40L, 40L, 40L, 8L, 40L, 19L,
    # TU
    12L, 2L, 20L, 8L, 8L, 40L, 40L, 40L, 19L
  ),
  format = c(
    # DM
    NA, NA, NA, NA, NA, NA, NA, NA, "BEST.", NA, NA, NA,
    NA, NA, NA, NA,
    # RS
    NA, NA, NA, "BEST.", NA, NA, NA, NA, NA, NA, "BEST.", NA, NA,
    # TU
    NA, NA, NA, "BEST.", NA, NA, NA, NA, NA
  )
)

# ---- trace_mapping_oncology: ADaM-to-SDTM traceability mapping ----
# Maps the ADSL / ADRS / ADTTE variables documented in oncology_metadata to
# their oncology SDTM sources. Derived variables carry NA domain/variable and
# NA confidence, mirroring trace_mapping.

trace_mapping_oncology <- tibble(
  adam_dataset = c(
    rep("ADSL", 12),
    rep("ADRS", 10),
    rep("ADTTE", 8)
  ),
  adam_var = c(
    # ADSL
    "STUDYID", "USUBJID", "SUBJID", "SITEID", "AGE", "SEX",
    "RACE", "ARM", "ARMCD", "TRT01P", "TRT01A", "DIAGDTC",
    # ADRS
    "STUDYID", "USUBJID", "PARAMCD", "PARAM", "AVALC", "RSSTRESC",
    "AVISIT", "ADT", "AVAL", "OVRLRESP",
    # ADTTE
    "STUDYID", "USUBJID", "STARTDT", "PARAMCD", "PARAM", "AVAL",
    "CNSR", "EVNTDESC"
  ),
  sdtm_domain = c(
    # ADSL -> DM
    "DM", "DM", "DM", "DM", "DM", "DM", "DM", "DM", "DM", "DM", NA, NA,
    # ADRS -> RS
    "RS", "RS", "RS", "RS", "RS", "RS", "RS", "RS", NA, NA,
    # ADTTE -> DM (anchor) / derived
    "DM", "DM", "DM", NA, NA, NA, NA, NA
  ),
  sdtm_var = c(
    # ADSL -> DM
    "STUDYID", "USUBJID", "SUBJID", "SITEID", "AGE", "SEX",
    "RACE", "ARM", "ARMCD", "ARM", NA, NA,
    # ADRS -> RS
    "STUDYID", "USUBJID", "RSTESTCD", "RSTEST", "RSSTRESC", "RSSTRESC",
    "VISIT", "RSDTC", NA, NA,
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
    "Date of initial diagnosis derived from MH medical history",
    # ADRS
    "Direct copy from RS.STUDYID",
    "Direct copy from RS.USUBJID",
    "Mapped from RS.RSTESTCD via parameter lookup",
    "Mapped from RS.RSTEST via parameter lookup",
    "Character response copied from RS.RSSTRESC",
    "Direct copy from RS.RSSTRESC",
    "Mapped from RS.VISIT via visit windowing",
    "Analysis date derived from RS.RSDTC",
    "Numeric response AVAL = 1 (CR), 2 (PR), 3 (SD), 4 (PD)",
    "Overall response derived per RECIST 1.1 from RS assessments",
    # ADTTE
    "Direct copy from DM.STUDYID",
    "Direct copy from DM.USUBJID",
    "Time-to-event origin set to DM.RFSTDTC",
    "PARAMCD from analysis parameter lookup",
    "PARAM from analysis parameter lookup",
    "AVAL = days from STARTDT to event or censoring",
    "CNSR = 0 if event; 1 if censored",
    "Event description derived from RS progression or DS death record"
  ),
  confidence = c(
    # ADSL
    1.0, 1.0, 1.0, 1.0, 0.95, 1.0, 1.0, 1.0, 1.0, 0.90, NA, NA,
    # ADRS
    1.0, 1.0, 0.90, 0.90, 0.95, 1.0, 0.90, 0.95, NA, NA,
    # ADTTE
    1.0, 1.0, 0.95, NA, NA, NA, NA, NA
  )
)

# ---- Internal-consistency checks -------------------------------------------

# Schemas mirror the pharma equivalents exactly.
stopifnot(
  identical(names(sdtm_metadata_oncology), names(r4subdata::sdtm_metadata)),
  identical(names(trace_mapping_oncology), names(r4subdata::trace_mapping))
)

# Mapped ADaM variables must exist in oncology_metadata.
om <- r4subdata::oncology_metadata
adam_keys <- paste0(om$dataset, ".", om$variable)
map_keys <- paste0(trace_mapping_oncology$adam_dataset, ".",
                   trace_mapping_oncology$adam_var)
stopifnot(all(map_keys %in% adam_keys))

# Mapped SDTM variables must exist in sdtm_metadata_oncology.
sdtm_keys <- paste0(sdtm_metadata_oncology$dataset, ".",
                    sdtm_metadata_oncology$variable)
mapped <- !is.na(trace_mapping_oncology$sdtm_domain)
sdtm_ref <- paste0(trace_mapping_oncology$sdtm_domain[mapped], ".",
                   trace_mapping_oncology$sdtm_var[mapped])
stopifnot(all(sdtm_ref %in% sdtm_keys))

conf <- trace_mapping_oncology$confidence
stopifnot(all(conf[!is.na(conf)] >= 0 & conf[!is.na(conf)] <= 1))

usethis::use_data(sdtm_metadata_oncology, overwrite = TRUE)
usethis::use_data(trace_mapping_oncology, overwrite = TRUE)

message("sdtm_metadata_oncology: ", nrow(sdtm_metadata_oncology), " rows x ",
        ncol(sdtm_metadata_oncology), " cols")
message("trace_mapping_oncology: ", nrow(trace_mapping_oncology), " rows x ",
        ncol(trace_mapping_oncology), " cols")
