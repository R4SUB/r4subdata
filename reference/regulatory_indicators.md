# Regulatory Indicator Definitions

Reference table of 30 indicator definitions across all four R4SUB (R for
Regulatory Submission) domains (quality, trace, risk, usability). Each
indicator has a unique ID, default severity, typical source, and
descriptive tags.

## Usage

``` r
regulatory_indicators
```

## Format

A tibble with 30 rows and 7 columns:

- indicator_id:

  Character. Unique indicator identifier.

- indicator_name:

  Character. Human-readable indicator name.

- domain:

  Character. Indicator domain: quality, trace, risk, usability.

- description:

  Character. Detailed description.

- severity_default:

  Character. Default severity level.

- source:

  Character. Typical source tool.

- tags:

  Character. Comma-separated tags.

## Source

Curated indicator definitions for the R4SUB (R for Regulatory
Submission) ecosystem.

## Examples

``` r
data(regulatory_indicators)
table(regulatory_indicators$domain)
#> 
#>   quality      risk     trace usability 
#>        10         6         8         6 
```
