# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/).
Versioning is done using [Calendar Versioning](https://calver.org/).

## [Unreleased]

### Changed

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

[Unreleased]: https://github.com/latextemplates/markdown-latex-quickstart/compare/2026-10-08...HEAD
[2026-10-08]: https://github.com/latextemplates/markdown-latex-quickstart/compare/2026-07-30...2026-10-08
[2026-07-30]: https://github.com/latextemplates/markdown-latex-quickstart/releases/tag/2026-07-30
