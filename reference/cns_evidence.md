# CNS Trial Evidence Table

A synthetic R4SUB evidence table for study CNS-2025-001 (the synthetic
CNS study described by `cns_metadata`) covering all four R4SUB (Ready
for Submission) pillars (quality, trace, risk, usability) with 29 rows
across ADSL, ADQS, and ADTTE datasets. Mirrors the schema of
`oncology_evidence` exactly and demonstrates realistic evidence patterns
for a CNS submission with mixed pass/warn/fail results.

## Usage

``` r
cns_evidence
```

## Format

A tibble with 29 rows and 17 columns:

- run_id:

  Character. Unique run identifier.

- study_id:

  Character. Study identifier (CNS-2025-001).

- asset_type:

  Character. Asset type: dataset, define, program, validation, spec,
  other.

- asset_id:

  Character. Asset identifier (e.g., ADSL, ADQS).

- source_name:

  Character. Source tool name.

- source_version:

  Character. Version of the source tool.

- indicator_id:

  Character. Indicator identifier (e.g., Q-MISS-VAR).

- indicator_name:

  Character. Human-readable indicator name.

- indicator_domain:

  Character. Domain: quality, trace, risk, usability.

- severity:

  Character. Severity: info, low, medium, high, critical.

- result:

  Character. Result: pass, fail, warn, na.

- metric_value:

  Numeric. Metric value (if applicable).

- metric_unit:

  Character. Unit for metric_value.

- message:

  Character. Descriptive message.

- location:

  Character. Location reference (e.g., ADQS:AVAL).

- evidence_payload:

  Character. JSON payload with additional details.

- created_at:

  POSIXct. Timestamp when evidence was created.

## Source

Synthetic evidence data for a Phase II CNS (Alzheimer's disease) trial.

## Examples

``` r
data(cns_evidence)
table(cns_evidence$indicator_domain)
#> 
#>   quality      risk     trace usability 
#>        10         7         6         6 
table(cns_evidence$result)
#> 
#> fail pass warn 
#>    4   18    7 
```
