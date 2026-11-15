# CNS Trial ADaM-to-SDTM Traceability Mapping

Maps the ADaM (Analysis Data Model) variables of the synthetic CNS study
CNS-2025-001 (ADSL, ADQS, ADTTE, as documented by `cns_metadata`) to
their SDTM (Study Data Tabulation Model) source variables in
`sdtm_metadata_cns`, with derivation text and confidence scores.
Includes direct copies, derived variables, and unmapped (derived)
entries. Mirrors the schema of `trace_mapping` exactly and is designed
to round-trip through `r4subtrace::build_trace_model()`. Follows CDISC
(Clinical Data Interchange Standards Consortium) traceability
conventions.

## Usage

``` r
trace_mapping_cns
```

## Format

A tibble with 30 rows and 6 columns:

- adam_dataset:

  Character. Source ADaM dataset (ADSL, ADQS, ADTTE).

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

Synthetic traceability mapping for a Phase II CNS (Alzheimer's disease)
trial based on CDISC (Clinical Data Interchange Standards Consortium)
conventions.

## Examples

``` r
data(trace_mapping_cns)
table(trace_mapping_cns$adam_dataset)
#> 
#>  ADQS  ADSL ADTTE 
#>    10    12     8 
```
