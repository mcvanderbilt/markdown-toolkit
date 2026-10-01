# TODO

Working checklist for markdown-toolkit (R package name: `mdtoolkit` — see
README §7 on the naming decision). Lightweight, package-scaffolding-style
TODO, not a ticketed backlog — once the package has real users/contributors
beyond this repo, move to GitHub Issues instead of hand-maintaining this
file.

## Setup
- [x] Package scaffolding in place (`DESCRIPTION`, `NAMESPACE`,
      `.Rbuildignore`, `R/`, `man/`, `tests/testthat/`, `vignettes/`,
      `inst/extdata/`) — 2026-09-25
- [x] `LICENSE` + `LICENSE.md` added: MIT — 2026-09-25
- [x] `tests/testthat/` scaffolded with `testthat.R` and a first test file —
      2026-09-25
- [x] `NEWS.md` started — 2026-09-25
- [x] `inst/extdata/` populated with first synthetic example files
      (`sample_scores.csv`, `sample.md`) — 2026-09-25
- [ ] Open in RStudio/VS Code and run `devtools::document()` to generate
      `man/*.Rd` from the roxygen2 comments already in `R/` (no R available
      in the session that scaffolded this — see README §6)
- [ ] Run `devtools::check()` / `devtools::test()` locally to confirm the
      scaffold actually builds and the first tests pass
- [ ] `usethis::use_readme_rmd()` or keep hand-written `README.md` (current
      SPEC-style version stays either way; decide if it should also render
      from an `.Rmd`)
- [ ] GitHub Actions CI (`usethis::use_github_action("check-standard")`) —
      fine to defer until more function(s) land

## First functions
- [x] `md_table_from_data()` — builds a Markdown table from a data.frame,
      CSV, or Excel file (`R/md_table_from_data.R`) — 2026-09-25.
      **Needs local verification**: written without a working R
      interpreter available, so it hasn't actually been run yet.
- [ ] One parsing/extraction function (e.g. extract YAML front matter)
- [ ] One validation/linting function (e.g. check for broken relative links)
- [ ] `md_to_html()` — conversion/rendering: Markdown → HTML — **template
      only**, scaffolded 2026-09-26 (`R/md_to_html.R`,
      `tests/testthat/test-md_to_html.R`). Matthew has working conversion
      logic already written elsewhere; next step is to paste it into the
      template, confirm/rename the function per the naming options
      discussed, note any new dependency it needs (sign-off required before
      adding to `DESCRIPTION`), then flesh out the roxygen `@param`/`@return`
      TODOs and the test assertions to match the real behavior.

## Open questions
- [ ] Should markdown-toolkit ever depend on functions promoted out of the
      Code Library `r/` folder, or stay fully independent?
- [ ] CRAN-bound eventually, or personal/GitHub-only?
- [ ] Confirm the `Package: mdtoolkit` name (R package names can't contain
      hyphens, so it can't literally be `markdown-toolkit` — see README §7)
      — keep it, or prefer something else (e.g. `mdtools`, `mdkit`)?
- [ ] Final name for the markdown→HTML function — see options proposed in
      chat on 2026-09-26 (`md_to_html()` recommended to match the existing
      `md_table_from_data()` verb-object naming pattern).

## Documentation
- [x] Package-level doc (`R/mdtoolkit-package.R` with `@keywords internal`
      / `"_PACKAGE"`) — 2026-09-25
- [ ] At least one vignette once 2-3 functions exist
- [ ] Keep `README.md` decision log current as choices are made
