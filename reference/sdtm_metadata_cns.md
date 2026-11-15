# CNS Trial SDTM Variable-Level Metadata

SDTM (Study Data Tabulation Model) variable-level metadata for the
synthetic CNS study CNS-2025-001 (the same study described by
`cns_metadata` and `cns_evidence`). Covers the CNS source domains DM
(Demographics, 16 vars), QS (Questionnaires, 14 vars), and SC (Subject
Characteristics, 8 vars). Mirrors the schema of `sdtm_metadata` exactly
and follows CDISC (Clinical Data Interchange Standards Consortium) SDTM
conventions.

## Usage

``` r
sdtm_metadata_cns
```

## Format

A tibble with 38 rows and 6 columns:

- dataset:

  Character. SDTM domain name (DM, QS, SC).

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

Synthetic metadata for a Phase II CNS (Alzheimer's disease) trial
following CDISC (Clinical Data Interchange Standards Consortium) SDTM
(Study Data Tabulation Model) standards.

## Examples

``` r
data(sdtm_metadata_cns)
table(sdtm_metadata_cns$dataset)
#> 
#> DM QS SC 
#> 16 14  8 
```
