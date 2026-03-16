# Dataset Column Dictionary

Returns column names, types, and descriptions for a given r4subdata
dataset.

## Usage

``` r
dataset_dictionary(dataset)
```

## Arguments

- dataset:

  Character. Name of the dataset (e.g., `"evidence_pharma"`).

## Value

A tibble with columns: `column`, `type`, `description`.

## Examples

``` r
dataset_dictionary("evidence_pharma")
#> # A tibble: 17 × 3
#>    column           type      description                                       
#>    <chr>            <chr>     <chr>                                             
#>  1 run_id           character Unique run identifier                             
#>  2 study_id         character Study identifier (CDISCPILOT01)                   
#>  3 asset_type       character Asset type: dataset, define, program, validation,…
#>  4 asset_id         character Asset identifier (e.g., ADSL, define.xml)         
#>  5 source_name      character Source of the evidence (e.g., pinnacle21, r4subtr…
#>  6 source_version   character Version of the source tool                        
#>  7 indicator_id     character Indicator identifier (e.g., Q-MISS-VAR)           
#>  8 indicator_name   character Human-readable indicator name                     
#>  9 indicator_domain character Indicator domain: quality, trace, risk, usability 
#> 10 severity         character Severity level: info, low, medium, high, critical 
#> 11 result           character Check result: pass, fail, warn, na                
#> 12 metric_value     numeric   Numeric metric value (if applicable)              
#> 13 metric_unit      character Unit for metric_value                             
#> 14 message          character Descriptive message for the evidence row          
#> 15 location         character Location reference (e.g., ADSL:AGE)               
#> 16 evidence_payload character JSON payload with additional details              
#> 17 created_at       POSIXct   Timestamp when evidence was created               
dataset_dictionary("adam_metadata")
#> # A tibble: 6 × 3
#>   column   type      description                         
#>   <chr>    <chr>     <chr>                               
#> 1 dataset  character ADaM dataset name (ADSL, ADAE, ADLB)
#> 2 variable character Variable name                       
#> 3 label    character Variable label                      
#> 4 type     character Variable type (Char or Num)         
#> 5 length   integer   Variable length                     
#> 6 format   character SAS format                          
```
