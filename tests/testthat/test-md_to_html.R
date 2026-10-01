# TODO: this test file is a template — flesh out once md_to_html()'s real
# implementation lands. Follow the pattern in test-md_table_from_data.R:
# one happy-path test, one file-input test using inst/extdata, and one or
# more error/edge-case tests.

test_that("renders a markdown string to html", {
  out <- md_to_html("# Hello\n\nSome **bold** text.")

  expect_type(out, "character")
  expect_length(out, 1)
  # TODO: replace with real assertions once the implementation exists, e.g.:
  # expect_match(out, "<h1>Hello</h1>")
  # expect_match(out, "<strong>bold</strong>")
})

test_that("reads a markdown file", {
  path <- system.file("extdata", "sample.md", package = "mdtoolkit")
  skip_if(!nzchar(path), "sample.md not found (package not installed)")

  out <- md_to_html(path)
  expect_type(out, "character")
})

test_that("errors informatively on bad input", {
  # TODO: fill in once input validation is finalized, e.g.:
  # expect_error(md_to_html(42), "single Markdown string")
})
