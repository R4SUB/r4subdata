# Pharma Risk Register

A Failure Mode and Effects Analysis (FMEA)-based risk register with 18
risks covering data quality, traceability, documentation, programming,
and compliance categories. Includes probability, impact, and
detectability scores on a 1-5 scale. Structured according to ICH
(International Council for Harmonisation) Q9 quality risk management
principles.

## Usage

``` r
risk_register_pharma
```

## Format

A tibble with 18 rows and 9 columns:

- risk_id:

  Character. Unique risk identifier (RISK-001 to RISK-018).

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

Synthetic risk register based on ICH (International Council for
Harmonisation) Q9 quality risk management principles.

## Examples

``` r
data(risk_register_pharma)
table(risk_register_pharma$category)
#> 
#>    compliance  data_quality documentation   programming  traceability 
#>             4             6             4             2             2 
```
