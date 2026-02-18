## Resubmission (Round 2)

Addressing all issues raised by the CRAN reviewer:

### 1. Acronyms

All acronyms have been expanded on first use in both the Description field
and the dataset documentation (man pages). Specifically:

**DESCRIPTION field:**
- **R4SUB**: "R4SUB (R for Regulatory Submission)"
- **ADaM**: "ADaM (Analysis Data Model)"
- **SDTM**: "SDTM (Study Data Tabulation Model)"
- **CDISC**: "CDISC (Clinical Data Interchange Standards Consortium)"
- **ICH Q9**: "ICH (International Council for Harmonisation) Q9"

**Dataset documentation (R/data.R):**
- `evidence_pharma`: CDISCPILOT01, R4SUB
- `adam_metadata`: ADaM, ADSL, ADAE, ADLB, CDISC, SAS
- `sdtm_metadata`: SDTM, DM, AE, LB, CDISC, SAS
- `trace_mapping`: ADaM, SDTM, CDISC
- `risk_register_pharma`: FMEA, ICH Q9
- `regulatory_indicators`: R4SUB

### 2. References

References to CDISC and ICH Q9 standards have been added to the Description
field in the required `<URL>` format:

- CDISC: `(<https://www.cdisc.org>)`
- ICH Q9: `(<https://www.ich.org/page/quality-guidelines>)`

### 3. Copyright holder in Authors@R

The `cph` (copyright holder) role has been added for Pawan Rama Mali in
`Authors@R`, consistent with the LICENSE file.

---

## Test environments

* local: Windows 11 x64, R 4.5.2
* GitHub Actions: ubuntu-latest, R release
* GitHub Actions: windows-latest, R release

## R CMD check results

0 errors | 0 warnings | 0 notes

## Downstream dependencies

No downstream dependencies. This is a resubmission.
