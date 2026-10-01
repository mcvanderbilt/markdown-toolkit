#' Build a Markdown table from a data file or data frame
#'
#' Reads tabular data from a `data.frame`, a CSV file, or an Excel file and
#' renders it as a GitHub-Flavored Markdown pipe table.
#'
#' @param data A `data.frame`, or a file path (`.csv`, `.xlsx`, or `.xls`).
#' @param sheet For Excel input, the sheet to read (name or index). Passed
#'   to `readxl::read_excel()`. Ignored for other input types.
#' @param align Column alignment for the header separator row: one of
#'   `"left"`, `"center"`, or `"right"`, or a character vector with one
#'   value per column. Defaults to `"left"`.
#' @param digits Number of decimal places to round numeric columns to
#'   before formatting. `NULL` (the default) leaves numeric values as-is.
#'
#' @return A single string containing the Markdown table, with lines
#'   separated by `"\n"`. Invisibly returned and also printed via `cat()`
#'   would be a natural next step for interactive use, but this function
#'   only returns the string so callers can write it to a file or compose
#'   it into a larger document.
#'
#' @details
#' Excel input requires the `readxl` package (listed under `Suggests`, not
#' `Imports`, per this package's minimal-dependency policy). If `readxl` is
#' not installed, an informative error is raised naming it.
#'
#' @examples
#' df <- data.frame(name = c("Alice", "Bob"), score = c(91.5, 87.25))
#' cat(md_table_from_data(df, digits = 1))
#'
#' csv_path <- system.file("extdata", "sample_scores.csv", package = "mdtoolkit")
#' if (nzchar(csv_path)) cat(md_table_from_data(csv_path))
#'
#' @export
md_table_from_data <- function(data, sheet = 1, align = "left", digits = NULL) {
  df <- .mtk_read_table_input(data, sheet = sheet)

  if (!is.data.frame(df)) {
    stop("`data` must resolve to a data.frame.", call. = FALSE)
  }
  if (ncol(df) == 0) {
    stop("`data` has no columns to render.", call. = FALSE)
  }

  if (!is.null(digits)) {
    numeric_cols <- vapply(df, is.numeric, logical(1))
    df[numeric_cols] <- lapply(df[numeric_cols], round, digits = digits)
  }

  align <- .mtk_normalize_align(align, ncol(df))

  cells <- lapply(df, function(col) format(col, trim = TRUE, scientific = FALSE))
  cells <- as.data.frame(cells, stringsAsFactors = FALSE, check.names = FALSE)

  header <- colnames(df)
  widths <- pmax(nchar(header), vapply(cells, function(col) max(nchar(col), 0L), integer(1)))

  sep <- vapply(seq_along(align), function(i) {
    switch(align[i],
      left   = paste0(":", strrep("-", max(widths[i] - 1L, 2L))),
      right  = paste0(strrep("-", max(widths[i] - 1L, 2L)), ":"),
      center = paste0(":", strrep("-", max(widths[i] - 2L, 1L)), ":")
    )
  }, character(1))

  fmt_row <- function(values) paste0("| ", paste(values, collapse = " | "), " |")

  rows <- if (nrow(df) == 0) {
    character(0)
  } else {
    apply(cells, 1, function(row) fmt_row(as.character(row)))
  }

  paste(c(fmt_row(header), fmt_row(sep), rows), collapse = "\n")
}

#' @keywords internal
#' @noRd
.mtk_read_table_input <- function(data, sheet) {
  if (is.data.frame(data)) {
    return(data)
  }

  if (!is.character(data) || length(data) != 1) {
    stop(
      "`data` must be a data.frame or a single file path (csv/xlsx/xls).",
      call. = FALSE
    )
  }
  if (!file.exists(data)) {
    stop("File not found: ", data, call. = FALSE)
  }

  ext <- tolower(tools::file_ext(data))
  switch(ext,
    csv = utils::read.csv(data, stringsAsFactors = FALSE, check.names = FALSE),
    xlsx = ,
    xls = {
      if (!requireNamespace("readxl", quietly = TRUE)) {
        stop(
          "Reading .", ext, " files requires the 'readxl' package. ",
          "Install it with install.packages(\"readxl\").",
          call. = FALSE
        )
      }
      as.data.frame(readxl::read_excel(data, sheet = sheet), stringsAsFactors = FALSE)
    },
    stop(
      "Unsupported file type: '.", ext, "'. Supported: .csv, .xlsx, .xls.",
      call. = FALSE
    )
  )
}

#' @keywords internal
#' @noRd
.mtk_normalize_align <- function(align, n) {
  allowed <- c("left", "center", "right")
  if (length(align) == 1) {
    align <- rep(align, n)
  }
  if (length(align) != n) {
    stop("`align` must have length 1 or ncol(data).", call. = FALSE)
  }
  if (!all(align %in% allowed)) {
    stop("`align` values must be one of: ", paste(allowed, collapse = ", "), call. = FALSE)
  }
  align
}
