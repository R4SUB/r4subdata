# CNS Trial Variable-Level Metadata

ADaM (Analysis Data Model) variable-level metadata for a synthetic CNS
(neuroscience) study, CNS-2025-001, modelled on a Phase II Alzheimer's
disease trial. Covers ADSL (Subject-Level Analysis Dataset, 14 vars),
ADQS (Questionnaire Analysis Dataset for cognitive/functional scales, 10
vars), and ADTTE (Time-to-Event Analysis Dataset, 8 vars). Mirrors the
schema of `oncology_metadata` exactly (including the `origin`,
`derivation`, and `codelist` columns) so the same downstream functions
work unchanged.

## Usage

``` r
cns_metadata
```

## Format

A tibble with 32 rows and 7 columns:

- dataset:

  Character. ADaM dataset name (ADSL, ADQS, ADTTE).

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

Synthetic metadata for a Phase II CNS (Alzheimer's disease) trial
following CDISC (Clinical Data Interchange Standards Consortium) ADaM
conventions.

## Examples

``` r
data(cns_metadata)
table(cns_metadata$dataset)
#> 
#>  ADQS  ADSL ADTTE 
#>    10    14     8 
table(cns_metadata$origin)
#> 
#> Assigned      CRF  Derived 
#>        3       16       13 
```
