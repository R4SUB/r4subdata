#' Validate a Data Frame Against an r4subdata Schema
#'
#' Checks that a data frame conforms to the column/type schema of one of the
#' r4subdata reference datasets (as defined by [dataset_dictionary()]), or to a
#' custom dictionary of the same shape. This is a structural, non-inventive
#' helper: it compares column names and types only and does not check or impose
#' any regulatory values, thresholds, or code lists. It is useful for validating
#' data frames that downstream code builds to look like a shipped dataset (for
#' example a user-constructed evidence table or metadata table) before feeding
#' them to the rest of the R4SUB (Ready for Submission) ecosystem.
#'
#' Type comparison uses the same vocabulary as [dataset_dictionary()]
#' (`"character"`, `"integer"`, `"numeric"`, `"POSIXct"`). An `integer` column
#' satisfies an expected `numeric` type (integer is a numeric subtype), but a
#' double column does not satisfy an expected `integer` type.
#'
#' @param data A data frame or tibble to validate.
#' @param schema Either the name of an r4subdata dataset (a length-one
#'   character, e.g. `"evidence_pharma"`) whose [dataset_dictionary()] defines
#'   the expected schema, or a dictionary tibble/data frame with at least the
#'   columns `column` and `type`.
#' @param strict Logical. When `TRUE`, the columns of `data` must appear in the
#'   same order as the schema; an ordering difference is reported as an issue.
#'   Defaults to `FALSE`.
#'
#' @return A tibble of validation issues with columns `issue`, `column`,
#'   `expected`, `actual`, and `message`. A zero-row tibble means `data`
#'   conforms to the schema. The returned object also carries a logical
#'   `"valid"` attribute (retrievable with `attr(x, "valid")`). Possible
#'   `issue` values are `"missing_column"`, `"unexpected_column"`,
#'   `"type_mismatch"`, and `"column_order"`.
#'
#' @seealso [dataset_dictionary()], [list_datasets()]
#'
#' @examples
#' # A shipped dataset validates cleanly against its own schema.
#' validate_dataset(adam_metadata, "adam_metadata")
#'
#' # A data frame with a missing column and a wrong type reports issues.
#' bad <- data.frame(
#'   dataset = "ADSL", variable = "AGE",
#'   label = "Age", type = "Num", length = "8"
#' )
#' validate_dataset(bad, "adam_metadata")
#'
#' @export
validate_dataset <- function(data, schema, strict = FALSE) {
  if (!is.data.frame(data)) {
    stop("`data` must be a data frame or tibble.", call. = FALSE)
  }
  if (!is.logical(strict) || length(strict) != 1L || is.na(strict)) {
    stop("`strict` must be a single logical value (TRUE or FALSE).",
         call. = FALSE)
  }

  dict <- resolve_schema(schema)
  expected_cols <- dict$column
  expected_types <- dict$type
  actual_cols <- names(data)

  issues <- empty_validation_report()

  # Missing columns: in the schema but absent from the data.
  for (col in setdiff(expected_cols, actual_cols)) {
    exp_type <- expected_types[match(col, expected_cols)]
    issues <- add_issue(
      issues, "missing_column", col, exp_type, NA_character_,
      paste0("Column '", col, "' is required by the schema but is missing.")
    )
  }

  # Unexpected columns: in the data but not in the schema.
  for (col in setdiff(actual_cols, expected_cols)) {
    act_type <- schema_type_of(data[[col]])
    issues <- add_issue(
      issues, "unexpected_column", col, NA_character_, act_type,
      paste0("Column '", col, "' is not part of the schema.")
    )
  }

  # Type mismatches on the columns present in both.
  for (col in intersect(expected_cols, actual_cols)) {
    exp_type <- expected_types[match(col, expected_cols)]
    act_type <- schema_type_of(data[[col]])
    if (!type_satisfies(act_type, exp_type)) {
      issues <- add_issue(
        issues, "type_mismatch", col, exp_type, act_type,
        paste0("Column '", col, "' should be ", exp_type,
               " but is ", act_type, ".")
      )
    }
  }

  # Optional ordering check: only meaningful when the column sets match.
  if (strict && setequal(expected_cols, actual_cols)) {
    common_order <- actual_cols[actual_cols %in% expected_cols]
    if (!identical(common_order, expected_cols)) {
      issues <- add_issue(
        issues, "column_order", NA_character_,
        paste(expected_cols, collapse = ", "),
        paste(actual_cols, collapse = ", "),
        "Columns are not in the schema-defined order."
      )
    }
  }

  attr(issues, "valid") <- nrow(issues) == 0L
  issues
}

# Resolve `schema` to a dictionary tibble with `column` and `type` columns.
resolve_schema <- function(schema) {
  if (is.character(schema) && length(schema) == 1L) {
    return(dataset_dictionary(schema))
  }
  if (is.data.frame(schema)) {
    if (!all(c("column", "type") %in% names(schema))) {
      stop("A `schema` data frame must have `column` and `type` columns.",
           call. = FALSE)
    }
    return(schema)
  }
  stop(
    "`schema` must be a single dataset name or a dictionary data frame ",
    "with `column` and `type` columns.",
    call. = FALSE
  )
}

# Map an R column to the dataset_dictionary() type vocabulary.
schema_type_of <- function(x) {
  if (inherits(x, "POSIXct")) return("POSIXct")
  if (is.integer(x)) return("integer")
  if (is.numeric(x)) return("numeric")
  if (is.character(x)) return("character")
  class(x)[1]
}

# TRUE if an actual type satisfies the expected type. An integer column
# satisfies an expected numeric type; the reverse is not accepted.
type_satisfies <- function(actual, expected) {
  if (identical(actual, expected)) return(TRUE)
  identical(expected, "numeric") && identical(actual, "integer")
}

empty_validation_report <- function() {
  tibble::tibble(
    issue = character(0),
    column = character(0),
    expected = character(0),
    actual = character(0),
    message = character(0)
  )
}

add_issue <- function(report, issue, column, expected, actual, message) {
  tibble::add_row(
    report,
    issue = issue,
    column = column,
    expected = expected,
    actual = actual,
    message = message
  )
}
