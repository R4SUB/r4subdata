# Oncology Trial SDTM Variable-Level Metadata

SDTM (Study Data Tabulation Model) variable-level metadata for the
synthetic oncology study ONCO-2025-001 (the same study described by
`oncology_metadata` and `oncology_evidence`). Covers the oncology source
domains DM (Demographics, 16 vars), RS (Disease Response following
RECIST 1.1, 13 vars), and TU (Tumor Identification, 9 vars). Mirrors the
schema of `sdtm_metadata` exactly and follows CDISC (Clinical Data
Interchange Standards Consortium) SDTM conventions.

## Usage

``` r
sdtm_metadata_oncology
```

## Format

A tibble with 38 rows and 6 columns:

- dataset:

  Character. SDTM domain name (DM, RS, TU).

- variable:

  Character. Variable name.

- label:

  Character. Variable label.

- type:

  Character. Variable type (Char or Num).

- length:

  Integer. Variable length.

- format:

  Character. SAS (Statistical Analysis System) format (or NA).

## Source

Synthetic metadata for a Phase II oncology trial following CDISC
(Clinical Data Interchange Standards Consortium) SDTM (Study Data
Tabulation Model) standards.

## Examples

``` r
data(sdtm_metadata_oncology)
table(sdtm_metadata_oncology$dataset)
#> 
#> DM RS TU 
#> 16 13  9 
```
