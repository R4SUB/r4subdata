# Example Datasets in r4subdata

The `r4subdata` package provides synthetic example datasets for the
R4SUB (R for Regulatory Submission) ecosystem. They are suitable for
demos, vignettes, and package testing.

``` r
library(r4subdata)
```

## Available datasets

Use
[`list_datasets()`](https://r4sub.github.io/r4subdata/reference/list_datasets.md)
to see all datasets with descriptions:

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

## Pharma study evidence table

`evidence_pharma` is a 250-row evidence table for study CDISCPILOT01,
covering all four R4SUB pillars.

``` r
data(evidence_pharma)
dim(evidence_pharma)
#> [1] 250  17
table(evidence_pharma$indicator_domain)
#> 
#>   quality      risk     trace usability 
#>       120        39        47        44
table(evidence_pharma$result)
#> 
#> fail   na pass warn 
#>   49   20  134   47
```

## ADaM metadata

`adam_metadata` contains variable-level metadata for three ADaM
datasets: ADSL, ADAE, and ADLB.

``` r
data(adam_metadata)
table(adam_metadata$dataset)
#> 
#> ADAE ADLB ADSL 
#>   10   10   16
head(adam_metadata[, c("dataset", "variable", "label", "type")])
#> # A tibble: 6 × 4
#>   dataset variable label                     type 
#>   <chr>   <chr>    <chr>                     <chr>
#> 1 ADSL    STUDYID  Study Identifier          Char 
#> 2 ADSL    USUBJID  Unique Subject Identifier Char 
#> 3 ADSL    SUBJID   Subject Identifier        Char 
#> 4 ADSL    SITEID   Study Site Identifier     Char 
#> 5 ADSL    AGE      Age                       Num  
#> 6 ADSL    AGEU     Age Units                 Char
```

## SDTM metadata

`sdtm_metadata` mirrors the same structure for SDTM domains DM, AE, and
LB.

``` r
data(sdtm_metadata)
table(sdtm_metadata$dataset)
#> 
#> AE DM LB 
#> 14 17 12
```

## Traceability mapping

`trace_mapping` links ADaM variables to their SDTM source variables.

``` r
data(trace_mapping)
head(trace_mapping)
#> # A tibble: 6 × 6
#>   adam_dataset adam_var sdtm_domain sdtm_var derivation_text          confidence
#>   <chr>        <chr>    <chr>       <chr>    <chr>                         <dbl>
#> 1 ADSL         STUDYID  DM          STUDYID  Direct copy from DM.STU…       1   
#> 2 ADSL         USUBJID  DM          USUBJID  Direct copy from DM.USU…       1   
#> 3 ADSL         SUBJID   DM          SUBJID   Direct copy from DM.SUB…       1   
#> 4 ADSL         SITEID   DM          SITEID   Direct copy from DM.SIT…       1   
#> 5 ADSL         AGE      DM          AGE      Direct copy from DM.AGE        0.95
#> 6 ADSL         AGEU     DM          AGEU     Direct copy from DM.AGEU       0.95
```

## Risk register

`risk_register_pharma` is an FMEA-based risk register with 18 risks
structured according to ICH Q9 principles.

``` r
data(risk_register_pharma)
table(risk_register_pharma$category)
#> 
#>    compliance  data_quality documentation   programming  traceability 
#>             4             6             4             2             2
table(risk_register_pharma$status)
#> 
#>  accepted    closed mitigated      open 
#>         1         2         3        12
```

## Regulatory indicator definitions

`regulatory_indicators` is a reference table of 30 indicator definitions
across all four R4SUB domains.

``` r
data(regulatory_indicators)
table(regulatory_indicators$domain)
#> 
#>   quality      risk     trace usability 
#>        10         6         8         6
```

## Oncology trial datasets

Two additional datasets represent a synthetic oncology submission (study
ONCO-2025-001) with ADSL, ADRS, and ADTTE datasets.

``` r
data(oncology_metadata)
table(oncology_metadata$dataset)
#> 
#>  ADRS  ADSL ADTTE 
#>    10    14     8
table(oncology_metadata$origin)
#> 
#> Assigned      CRF  Derived 
#>        3       16       13
```

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

The oncology metadata includes `origin`, `derivation`, and `codelist`
columns needed by `r4subusability::assess_define_completeness()` and
`r4subusability::assess_annotation_coverage()`.
