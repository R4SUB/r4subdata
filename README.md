# r4subdata

**r4subdata** provides realistic example datasets for the R4SUB clinical submission readiness ecosystem.

Designed for demos, vignettes, and package testing -- like `nycflights13` or `palmerpenguins`.

## Installation

```r
pak::pak("R4SUB/r4subdata")
```

## Datasets

| Dataset | Rows | Description |
|---|---|---|
| `evidence_pharma` | 250 | Full evidence table for study CDISCPILOT01 across 4 domains |
| `adam_metadata` | 36 | ADaM variable metadata for ADSL, ADAE, ADLB |
| `sdtm_metadata` | 43 | SDTM variable metadata for DM, AE, LB |
| `trace_mapping` | 25 | ADaM-to-SDTM traceability mapping with confidence scores |
| `risk_register_pharma` | 18 | FMEA risk register with P/I/D scores and mitigations |
| `regulatory_indicators` | 30 | Indicator definitions across quality, trace, risk, usability |

## Quick Start

```r
library(r4subdata)

# Browse datasets
list_datasets()

# Load and explore
data(evidence_pharma)
table(evidence_pharma$indicator_domain)

# Column dictionary
dataset_dictionary("evidence_pharma")
```

## Usage with R4SUB Packages

```r
library(r4subcore)
library(r4subscore)
library(r4subdata)

# Score the pharma evidence
scores <- compute_indicator_scores(evidence_pharma)
pillars <- compute_pillar_scores(evidence_pharma)
sci <- compute_sci(pillars)

# Trace with metadata
library(r4subtrace)
model <- build_trace_model(adam_metadata, sdtm_metadata, trace_mapping)

# Risk analysis
library(r4subrisk)
rr <- create_risk_register(risk_register_pharma)
```

## License

MIT
