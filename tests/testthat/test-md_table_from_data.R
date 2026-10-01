test_that("renders a data.frame as a markdown table", {
  df <- data.frame(name = c("Alice", "Bob"), score = c(91.5, 87.25))
  out <- md_table_from_data(df, digits = 1)

  expect_type(out, "character")
  expect_length(out, 1)
  lines <- strsplit(out, "\n")[[1]]
  expect_equal(lines[1], "| name | score |")
  expect_match(lines[2], "^\\|:-+\\|:-+\\|$")
  expect_equal(lines[3], "| Alice | 91.5 |")
  expect_equal(lines[4], "| Bob | 87.25 |")
})

test_that("reads a csv file", {
  path <- system.file("extdata", "sample_scores.csv", package = "mdtoolkit")
  skip_if(!nzchar(path), "sample_scores.csv not found (package not installed)")

  out <- md_table_from_data(path)
  expect_type(out, "character")
  expect_true(grepl("^\\| ", out))
})

test_that("errors informatively on bad input", {
  expect_error(md_table_from_data(42), "data.frame or a single file path")
  expect_error(md_table_from_data("does-not-exist.csv"), "File not found")
  expect_error(md_table_from_data(data.frame()), "no columns")
})

test_that("errors on unsupported file extension", {
  tmp <- tempfile(fileext = ".txt")
  writeLines("not tabular data", tmp)
  on.exit(unlink(tmp))
  expect_error(md_table_from_data(tmp), "Unsupported file type")
})

test_that("align argument is validated", {
  df <- data.frame(x = 1:2)
  expect_error(md_table_from_data(df, align = "up"), "must be one of")
  expect_error(md_table_from_data(df, align = c("left", "right")), "length 1 or ncol")
})
