# List Available r4subdata Datasets

Returns a summary of all datasets included in the r4subdata package.

## Usage

``` r
list_datasets()
```

## Value

A tibble with columns: `name`, `description`, `n_rows`, `n_cols`.

## Examples

``` r
list_datasets()
#> # A tibble: 8 × 4
#>   name                  description                                n_rows n_cols
#>   <chr>                 <chr>                                       <int>  <int>
#> 1 evidence_pharma       Pharma study evidence table (CDISCPILOT01…    250     17
#> 2 adam_metadata         ADaM metadata for ADSL, ADAE, ADLB (30 va…     36      6
#> 3 sdtm_metadata         SDTM metadata for DM, AE, LB (40 variable…     43      6
#> 4 trace_mapping         ADaM-to-SDTM traceability mapping (25 map…     25      6
#> 5 risk_register_pharma  FMEA risk register with 18 risks and miti…     18      9
#> 6 regulatory_indicators Regulatory indicator definitions across 4…     30      7
#> 7 oncology_metadata     Oncology trial ADaM metadata for ADSL, AD…     32      7
#> 8 oncology_evidence     Oncology trial evidence table (ONCO-2025-…     29     17
```
