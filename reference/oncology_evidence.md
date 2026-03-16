# Oncology Trial Evidence Table

A synthetic R4SUB evidence table for study ONCO-2025-001 covering all
four R4SUB (R for Regulatory Submission) pillars (quality, trace, risk,
usability) with 29 rows across ADSL, ADRS, and ADTTE datasets.
Demonstrates realistic evidence patterns for an oncology submission with
mixed pass/warn/fail results.

## Usage

``` r
oncology_evidence
```

## Format

A tibble with 29 rows and 17 columns:

- run_id:

  Character. Unique run identifier.

- study_id:

  Character. Study identifier (ONCO-2025-001).

- asset_type:

  Character. Asset type: dataset, define, program, validation, spec,
  other.

- asset_id:

  Character. Asset identifier (e.g., ADSL, ADRS).

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

  Character. Location reference (e.g., ADRS:AVAL).

- evidence_payload:

  Character. JSON payload with additional details.

- created_at:

  POSIXct. Timestamp when evidence was created.

## Source

Synthetic evidence data for a Phase II oncology trial.

## Examples

``` r
data(oncology_evidence)
table(oncology_evidence$indicator_domain)
#> 
#>   quality      risk     trace usability 
#>        10         7         6         6 
table(oncology_evidence$result)
#> 
#> fail pass warn 
#>    4   18    7 
```
