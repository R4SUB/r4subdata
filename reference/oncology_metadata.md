# Oncology Trial Variable-Level Metadata

ADaM (Analysis Data Model) variable-level metadata for a synthetic
oncology trial covering ADSL (Subject-Level Analysis Dataset, 14 vars),
ADRS (Response Analysis Dataset, 10 vars), and ADTTE (Time-to-Event
Analysis Dataset, 8 vars). Includes origin, derivation, and codelist
columns suitable for use with `r4subusability` assessments.

## Usage

``` r
oncology_metadata
```

## Format

A tibble with 32 rows and 7 columns:

- dataset:

  Character. ADaM dataset name (ADSL, ADRS, ADTTE).

- variable:

  Character. Variable name.

- label:

  Character. Variable label.

- origin:

  Character. Variable origin (CRF, Derived, Assigned).

- derivation:

  Character. Derivation text (NA if not derived).

- codelist:

  Character. CDISC (Clinical Data Interchange Standards Consortium)
  codelist code (NA if not applicable).

- type:

  Character. Variable type (Char or Num).

## Source

Synthetic metadata for a Phase II oncology trial following CDISC
(Clinical Data Interchange Standards Consortium) ADaM conventions.

## Examples

``` r
data(oncology_metadata)
table(oncology_metadata$dataset)
#> 
#>  ADRS  ADSL ADTTE 
#>    10    14     8 
table(oncology_metadata$origin)
#> 
#> Assigned      CRF  Derived 
#>        3       16       13 
```
