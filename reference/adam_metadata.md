# ADaM Variable-Level Metadata

ADaM (Analysis Data Model) variable-level metadata for ADSL
(Subject-Level Analysis Dataset, 16 vars), ADAE (Adverse Events Analysis
Dataset, 10 vars), and ADLB (Laboratory Results Analysis Dataset, 10
vars). Follows CDISC (Clinical Data Interchange Standards Consortium)
ADaM conventions.

## Usage

``` r
adam_metadata
```

## Format

A tibble with 36 rows and 6 columns:

- dataset:

  Character. ADaM dataset name (ADSL, ADAE, ADLB).

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

Synthetic metadata based on CDISC ADaM (Analysis Data Model) standards.

## Examples

``` r
data(adam_metadata)
table(adam_metadata$dataset)
#> 
#> ADAE ADLB ADSL 
#>   10   10   16 
```
