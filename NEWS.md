# r4subdata (development version)

- `dataset_dictionary()` now returns column dictionaries for `oncology_metadata`
  and `oncology_evidence`; previously these two datasets (exported and listed by
  `list_datasets()`) raised an "Unknown dataset" error.
- Fixed stale "R for Regulatory Submission" expansions of "R4SUB" in the dataset
  documentation and vignette to match the DESCRIPTION ("Ready for Submission").
- Corrected the ADaM/SDTM variable counts shown by `list_datasets()`
  (36 and 43, matching the actual datasets).

# r4subdata 0.1.4

- Exclude the pkgdown config and site from the build to clear an R CMD check NOTE.

# r4subdata 0.1.3

- Clarified the package DESCRIPTION: "R4SUB" expands to "Ready for Submission"
  (previously "R for Regulatory Submission", inconsistent with the rest of the
  ecosystem).

# r4subdata 0.1.2

- Added `oncology_metadata`: ADaM variable-level metadata for a synthetic oncology trial (ADSL, ADRS, ADTTE).
- Added `oncology_evidence`: 29-row R4SUB evidence table for study ONCO-2025-001, covering all four pillars.

# r4subdata 0.1.1

- Fixed version conflict warning on load.
- Added ORCID to author metadata.

# r4subdata 0.1.0

- Initial CRAN release.
