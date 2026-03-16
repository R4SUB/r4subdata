# ADaM-to-SDTM Traceability Mapping

Maps ADaM (Analysis Data Model) variables to their SDTM (Study Data
Tabulation Model) source variables with derivation text and confidence
scores. Includes direct copies, derived variables, and unmapped entries.
Follows CDISC (Clinical Data Interchange Standards Consortium)
traceability conventions.

## Usage

``` r
trace_mapping
```

## Format

A tibble with 25 rows and 6 columns:

- adam_dataset:

  Character. Source ADaM dataset.

- adam_var:

  Character. Source ADaM variable.

- sdtm_domain:

  Character. Target SDTM domain (NA if derived).

- sdtm_var:

  Character. Target SDTM variable (NA if derived).

- derivation_text:

  Character. Derivation description text.

- confidence:

  Numeric. Mapping confidence score (0-1, NA if unmapped).

## Source

Synthetic traceability mapping based on CDISC conventions.

## Examples

``` r
data(trace_mapping)
table(trace_mapping$adam_dataset)
#> 
#> ADAE ADLB ADSL 
#>    7    6   12 
```
