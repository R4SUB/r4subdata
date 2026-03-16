# SDTM Variable-Level Metadata

SDTM (Study Data Tabulation Model) variable-level metadata for DM
(Demographics, 17 vars), AE (Adverse Events, 14 vars), and LB
(Laboratory Results, 12 vars). Follows CDISC (Clinical Data Interchange
Standards Consortium) SDTM conventions.

## Usage

``` r
sdtm_metadata
```

## Format

A tibble with 43 rows and 6 columns:

- dataset:

  Character. SDTM domain name (DM, AE, LB).

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

Synthetic metadata based on CDISC SDTM (Study Data Tabulation Model)
standards.

## Examples

``` r
data(sdtm_metadata)
table(sdtm_metadata$dataset)
#> 
#> AE DM LB 
#> 14 17 12 
```
