# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/).
Versioning is done using [Calendar Versioning](https://calver.org/).

## [Unreleased]

### Added

- Initial Markdown quick-start template, generated from [generator-latex-template](https://github.com/latextemplates/generator-latex-template) with `--documentclass=mwe`: write your content in Markdown inside a `\begin{markdown}` block and compile it to a PDF with LuaLaTeX + biber. Ships an English (`main.tex`) and a German (`main-de.tex`) example.
- Acronyms via the `glossaries` package: define them once in the wrapper `.tex`, and they are recognized automatically in the running Markdown text and collected into an acronym list in the backmatter; `[X]{.acronym}` marks up an acronym explicitly. [#4](https://github.com/latextemplates/markdown-latex-quickstart/issues/4)
