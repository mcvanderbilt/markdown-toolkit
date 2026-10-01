#' Convert Markdown to HTML
#'
#' TODO: One-sentence summary of what conversion approach is used (e.g.
#' "Converts a Markdown string or file to an HTML fragment or full document
#' using <engine/approach>.").
#'
#' @param md A Markdown string, or a file path to a `.md` file. TODO: confirm
#'   which input forms this should accept (string vs. file vs. both) and
#'   update this doc + the dispatch logic below to match.
#' @param output TODO: e.g. one of `"fragment"` or `"document"` — whether to
#'   return a bare HTML fragment or a complete HTML document (`<html>`,
#'   `<head>`, `<body>`). Delete this param if not needed.
#' @param file Optional output file path. If supplied, the HTML is written
#'   to this path (invisibly) instead of / in addition to being returned.
#'   TODO: decide return-vs-write-to-file semantics.
#'
#' @return A single string containing the rendered HTML. TODO: confirm
#'   return contract (always returned even when `file` is supplied? invisible
#'   in that case?).
#'
#' @details
#' TODO: note any dependency this relies on (e.g. `commonmark`, `markdown`,
#' or a hand-rolled parser) and whether it's base R, an existing Suggests/
#' Imports dependency, or a NEW dependency that needs Matthew's sign-off
#' before being added to `DESCRIPTION` (per project convention — see
#' `claude/custom-instructions.md`).
#'
#' @examples
#' md_to_html("# Hello\n\nSome **bold** text.")
#'
#' md_path <- system.file("extdata", "sample.md", package = "mdtoolkit")
#' if (nzchar(md_path)) md_to_html(md_path)
#'
#' @export
md_to_html <- function(md, output = "fragment", file = NULL) {
  # TODO: paste in your existing conversion logic here.
  #
  # Suggested shape, following md_table_from_data()'s pattern of a small
  # internal helper for input dispatch (string vs. file path):
  #
  #   text <- .mtk_read_md_input(md)
  #   html <- <your conversion here>
  #
  #   if (!is.null(file)) {
  #     writeLines(html, file)
  #     return(invisible(html))
  #   }
  #   html

  stop("md_to_html() is a template — implementation not yet added.", call. = FALSE)
}

#' @keywords internal
#' @noRd
.mtk_read_md_input <- function(md) {
  if (!is.character(md) || length(md) != 1) {
    stop("`md` must be a single Markdown string or a file path.", call. = FALSE)
  }
  if (file.exists(md) && grepl("\\.md$", md, ignore.case = TRUE)) {
    return(paste(readLines(md, warn = FALSE), collapse = "\n"))
  }
  md
}
