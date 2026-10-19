# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/).
Versioning is done using [Calendar Versioning](https://calver.org/).

## [Unreleased]

### Added

- VS Code: [markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint) recommended, configured by `.markdownlint.yml`.
- CI: [typos](https://github.com/crate-ci/typos) checks the spelling, also in comments (configured in `.typos.toml`).

### Changed

- `manuscript.md` and README.md: markdownlint findings fixed.
- `make spellcheck-aspell`: aspell runs in the [Docker image by DANTE e.V.](https://hub.docker.com/r/danteev/texlive).

### Fixed

- README.md: typo in a book title fixed.

## [2026-10-16]

### Added

- VS Code: [JabRef 4 VSCode](https://marketplace.visualstudio.com/items?itemName=jabref.jabref-4-vscode) recommended.

### Changed

- `make spellcheck` runs all spell checkers (`make aspell` is now `make spellcheck-aspell`).
- GitHub workflows: actions pinned to commit SHAs.

### Fixed

- Makefile: `.PHONY` lists all targets; `make spellcheck-aspell` and `make showundef` work.

## [2026-10-15]

### Added

- `make log` shows the relevant messages of the LaTeX log (texlogsieve).

### Changed

- The document is laid out single-sided.
- `make format` (and thus CI) indents all main files (`main*.tex`), not only `MASTER_TEX`.
- VS Code: the recommended extension is `james-yu.latex-workshop` (`manhen.latex-workshop-2` was removed from the stores).
- VS Code: the background of the PDF viewer follows the light or dark theme.
- Dependabot groups all GitHub Actions updates into one weekly PR.
- `check.yml` pins all GitHub Actions to commit SHAs.
- README.md: sections reordered.
- README.md: on Overleaf, select TeX Live 2026.
- README.md: passages in another language are an FAQ.
- README.md: links the decision records of the template generator.
- README.md: "Usage with docker" merged into "Docker-based (recommended)".
- `.latexmkrc` replaces `_latexmkrc`; it works on Overleaf, too.
- `make` runs the LaTeX tools in the Docker image (`make LOCAL=1` runs them locally).
- `vscode.settings.json` contains the Docker settings of LaTeX Workshop and does not build on save.
- README.md: compilation hints consolidated in "LaTeX compilation".

### Fixed

- `.dockerignore` excludes the generated `figures/*.pdf_tex` files. [generator-latex-template#586](https://github.com/latextemplates/generator-latex-template/pull/586)
- The `.markdown.in` file of the markdown package is ignored by git and removed by `latexmk -c`.
- `make view` opens the PDF on Linux and macOS.
- `vscode.settings.json`: the recipes run `lualatex` (resp. `pdflatex`) with the right bibliography tool.

## [2026-10-14]

### Changed

- References written as `<#id>` in Markdown typeset the type name and the number ("Figure 1") instead of the bare number. The manuscript uses them instead of raw `\zcref`.
- The README uses the TeX Live image of the Island of TeX directly (also in the VS Code setting `latex-workshop.docker.image.latex`) - building an own image `ltg` is no longer needed. The commands to compile in the container are copy-and-paste ready for Windows (PowerShell and Command Prompt), Linux, and macOS.
- The markdown package's cache directory (`_markdown_*/`) is ignored by git.
- The README's tool hints distinguish a Docker-based setup (recommended) from a traditional installation: the [TeX Live image by the Island of TeX](https://gitlab.com/islandoftex/images/texlive) works the same on Windows, macOS, and Linux and makes `minted` work without a separate Python setup. The "Usage with docker" section and the VS Code hints (LaTeX Workshop can compile in the container) are linked from there.

## [2026-10-08]

### Changed

- `_latexmkrc` is organized in sections and lists commented-out alternatives for continuous preview (`-pvc`), the job name, and the PDF viewer (e.g., evince).
- A sentence-initial `Finally,` is allowed by textlint (`.textlintrc.json`), because it marks a sequence rather than weakening a statement.

### Fixed

- `latexmk -pv` opens the PDF on Linux and macOS: the SumatraPDF viewer is only configured on Windows.

## [2026-07-30]

### Added

- The README now links the [latex-snippets site](https://latextemplates.github.io/latex-snippets/) near the top, so you can inspect the source snippets this template is assembled from.
- Initial Markdown quick-start template, generated from [generator-latex-template](https://github.com/latextemplates/generator-latex-template) with `--documentclass=mwe`: write your content in Markdown inside a `\begin{markdown}` block and compile it to a PDF with LuaLaTeX + biber. Ships an English (`main.tex`) and a German (`main-de.tex`) example.
- Acronyms via the `glossaries` package: define them once in the wrapper `.tex`, and they are recognized automatically in the running Markdown text and collected into an acronym list in the backmatter; `[X]{.acronym}` marks up an acronym explicitly. [#4](https://github.com/latextemplates/markdown-latex-quickstart/issues/4)

[Unreleased]: https://github.com/latextemplates/markdown-latex-quickstart/compare/2026-10-16...HEAD
[2026-10-16]: https://github.com/latextemplates/markdown-latex-quickstart/compare/2026-10-15...2026-10-16
[2026-10-15]: https://github.com/latextemplates/markdown-latex-quickstart/compare/2026-10-14...2026-10-15
[2026-10-14]: https://github.com/latextemplates/markdown-latex-quickstart/compare/2026-10-08...2026-10-14
[2026-10-08]: https://github.com/latextemplates/markdown-latex-quickstart/compare/2026-07-30...2026-10-08
[2026-07-30]: https://github.com/latextemplates/markdown-latex-quickstart/releases/tag/2026-07-30
