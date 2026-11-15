# List Available r4subdata Datasets

Returns a summary of all datasets included in the r4subdata package.

## Usage

``` r
list_datasets()
```

## Value

A tibble with columns: `name`, `group`, `description`, `n_rows`,
`n_cols`. The `group` column tags each dataset as `"pharma"`
(CDISCPILOT01 / general reference) or `"oncology"` (ONCO-2025-001).

## Examples

``` r
list_datasets()
#> # A tibble: 16 × 5
#>    name                   group    description                     n_rows n_cols
#>    <chr>                  <chr>    <chr>                            <int>  <int>
#>  1 evidence_pharma        pharma   Pharma study evidence table (C…    250     17
#>  2 adam_metadata          pharma   ADaM metadata for ADSL, ADAE, …     36      6
#>  3 sdtm_metadata          pharma   SDTM metadata for DM, AE, LB (…     43      6
#>  4 trace_mapping          pharma   ADaM-to-SDTM traceability mapp…     25      6
#>  5 risk_register_pharma   pharma   FMEA risk register with 18 ris…     18      9
#>  6 regulatory_indicators  pharma   Regulatory indicator definitio…     30      7
#>  7 oncology_metadata      oncology Oncology trial ADaM metadata f…     32      7
#>  8 oncology_evidence      oncology Oncology trial evidence table …     29     17
#>  9 risk_register_oncology oncology Oncology trial FMEA risk regis…     15      9
#> 10 sdtm_metadata_oncology oncology Oncology trial SDTM metadata f…     38      6
#> 11 trace_mapping_oncology oncology Oncology trial ADaM-to-SDTM tr…     30      6
#> 12 cns_metadata           cns      CNS trial ADaM metadata for CN…     32      7
#> 13 cns_evidence           cns      CNS trial evidence table (CNS-…     29     17
#> 14 risk_register_cns      cns      CNS trial FMEA risk register (…     15      9
#> 15 sdtm_metadata_cns      cns      CNS trial SDTM metadata for DM…     38      6
#> 16 trace_mapping_cns      cns      CNS trial ADaM-to-SDTM traceab…     30      6
```
