# Validate a Data Frame Against an r4subdata Schema

Checks that a data frame conforms to the column/type schema of one of
the r4subdata reference datasets (as defined by
[`dataset_dictionary()`](https://r4sub.github.io/r4subdata/reference/dataset_dictionary.md)),
or to a custom dictionary of the same shape. This is a structural,
non-inventive helper: it compares column names and types only and does
not check or impose any regulatory values, thresholds, or code lists. It
is useful for validating data frames that downstream code builds to look
like a shipped dataset (for example a user-constructed evidence table or
metadata table) before feeding them to the rest of the R4SUB (Ready for
Submission) ecosystem.

## Usage

``` r
validate_dataset(data, schema, strict = FALSE)
```

## Arguments

- data:

  A data frame or tibble to validate.

- schema:

  Either the name of an r4subdata dataset (a length-one character, e.g.
  `"evidence_pharma"`) whose
  [`dataset_dictionary()`](https://r4sub.github.io/r4subdata/reference/dataset_dictionary.md)
  defines the expected schema, or a dictionary tibble/data frame with at
  least the columns `column` and `type`.

- strict:

  Logical. When `TRUE`, the columns of `data` must appear in the same
  order as the schema; an ordering difference is reported as an issue.
  Defaults to `FALSE`.

## Value

A tibble of validation issues with columns `issue`, `column`,
`expected`, `actual`, and `message`. A zero-row tibble means `data`
conforms to the schema. The returned object also carries a logical
`"valid"` attribute (retrievable with `attr(x, "valid")`). Possible
`issue` values are `"missing_column"`, `"unexpected_column"`,
`"type_mismatch"`, and `"column_order"`.

## Details

Type comparison uses the same vocabulary as
[`dataset_dictionary()`](https://r4sub.github.io/r4subdata/reference/dataset_dictionary.md)
(`"character"`, `"integer"`, `"numeric"`, `"POSIXct"`). An `integer`
column satisfies an expected `numeric` type (integer is a numeric
subtype), but a double column does not satisfy an expected `integer`
type.

## See also

[`dataset_dictionary()`](https://r4sub.github.io/r4subdata/reference/dataset_dictionary.md),
[`list_datasets()`](https://r4sub.github.io/r4subdata/reference/list_datasets.md)

## Examples

``` r
# A shipped dataset validates cleanly against its own schema.
validate_dataset(adam_metadata, "adam_metadata")
#> # A tibble: 0 × 5
#> # ℹ 5 variables: issue <chr>, column <chr>, expected <chr>, actual <chr>,
#> #   message <chr>

# A data frame with a missing column and a wrong type reports issues.
bad <- data.frame(
  dataset = "ADSL", variable = "AGE",
  label = "Age", type = "Num", length = "8"
)
validate_dataset(bad, "adam_metadata")
#> # A tibble: 2 × 5
#>   issue          column expected  actual    message                             
#>   <chr>          <chr>  <chr>     <chr>     <chr>                               
#> 1 missing_column format character NA        Column 'format' is required by the …
#> 2 type_mismatch  length integer   character Column 'length' should be integer b…
```
