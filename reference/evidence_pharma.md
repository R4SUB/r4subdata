# Pharma Study Evidence Table

A realistic evidence table for study CDISCPILOT01 (Clinical Data
Interchange Standards Consortium Pilot Study 01) covering all four R4SUB
(R for Regulatory Submission) pillars (quality, trace, risk, usability)
with 250 rows and 18 indicators across multiple datasets and sources.

## Usage

``` r
evidence_pharma
```

## Format

A tibble with 250 rows and 17 columns:

- run_id:

  Character. Unique run identifier.

- study_id:

  Character. Study identifier (CDISCPILOT01).

- asset_type:

  Character. Asset type: dataset, define, program, validation, spec,
  other.

- asset_id:

  Character. Asset identifier (e.g., ADSL, define.xml).

- source_name:

  Character. Source of the evidence (e.g., pinnacle21).

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

  Character. Location reference (e.g., ADSL:AGE).

- evidence_payload:

  Character. JSON payload with additional details.

- created_at:

  POSIXct. Timestamp when evidence was created.

## Source

Synthetic data based on the CDISC (Clinical Data Interchange Standards
Consortium) Pilot Study 01 structure.

## Examples

``` r
data(evidence_pharma)
head(evidence_pharma)
#> # A tibble: 6 × 17
#>   run_id    study_id asset_type asset_id source_name source_version indicator_id
#>   <chr>     <chr>    <chr>      <chr>    <chr>       <chr>          <chr>       
#> 1 R4S-2025… CDISCPI… dataset    ADSL     pinnacle21  1.0.0          Q-VALUE-RAN…
#> 2 R4S-2025… CDISCPI… dataset    ADCM     pinnacle21  1.0.0          R-MITIGATIO…
#> 3 R4S-2025… CDISCPI… dataset    ADLB     manual_rev… 1.0.0          Q-TYPE-MISM…
#> 4 R4S-2025… CDISCPI… dataset    ADCM     manual_rev… 1.0.0          Q-REF-INTEG…
#> 5 R4S-2025… CDISCPI… dataset    ADCM     r4subrisk   1.0.0          Q-CT-COMPLI…
#> 6 R4S-2025… CDISCPI… dataset    LB       define_che… 1.0.0          T-ORPHAN-VAR
#> # ℹ 10 more variables: indicator_name <chr>, indicator_domain <chr>,
#> #   severity <chr>, result <chr>, metric_value <dbl>, metric_unit <chr>,
#> #   message <chr>, location <chr>, evidence_payload <chr>, created_at <dttm>
table(evidence_pharma$indicator_domain)
#> 
#>   quality      risk     trace usability 
#>       120        39        47        44 
```
