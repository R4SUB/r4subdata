# Oncology Trial Risk Register

A Failure Mode and Effects Analysis (FMEA)-based risk register for the
synthetic oncology study ONCO-2025-001 (the same study described by
`oncology_metadata` and `oncology_evidence`). Contains 15 risks covering
data quality, traceability, documentation, programming, and compliance
categories, with probability, impact, and detectability scores on a 1-5
scale. Mirrors the schema of `risk_register_pharma` exactly and reflects
realistic oncology submission risks (RECIST response, time-to-event, and
program validation). Structured according to ICH (International Council
for Harmonisation) Q9 quality risk management principles.

## Usage

``` r
risk_register_oncology
```

## Format

A tibble with 15 rows and 9 columns:

- risk_id:

  Character. Unique risk identifier (ONCO-RISK-001 to ONCO-RISK-015).

- description:

  Character. Risk description.

- category:

  Character. Risk category.

- probability:

  Integer. Probability of occurrence (1-5).

- impact:

  Integer. Impact severity (1-5).

- detectability:

  Integer. Detectability rating (1-5).

- owner:

  Character. Risk owner name.

- mitigation:

  Character. Mitigation action (or NA).

- status:

  Character. Status: open, mitigated, closed, accepted.

## Source

Synthetic risk register for a Phase II oncology trial, based on ICH
(International Council for Harmonisation) Q9 quality risk management
principles.

## Examples

``` r
data(risk_register_oncology)
table(risk_register_oncology$category)
#> 
#>    compliance  data_quality documentation   programming  traceability 
#>             3             4             3             3             2 
```
