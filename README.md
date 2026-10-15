# LaTeX Document

This is a **minimal Markdown quick start**. Write your content as plain Markdown in [`manuscript.md`](manuscript.md); the thin wrapper [`main.tex`](main.tex) pulls it in with `\markdownInput` and LaTeX turns it into a PDF — no thesis scaffolding, just the essentials: headings, citations, footnotes, tables, figures, smart cross-references (`\zcref`), and acronyms (defined once in the wrapper, recognized automatically in the running text and collected in an acronym list). Keeping the prose in a real `.md` file means your editor treats it as Markdown and the spell-/prose-checkers below lint it directly.

The LaTeX snippets this template is assembled from can be inspected at <https://latextemplates.github.io/latex-snippets/>.

## Quick start

- Write your text in [`manuscript.md`](manuscript.md).
- Compile with "lualatex + biber" in your TeX editor or with `latexmk main` / `make` on the command line.

## LaTeX compilation

Compile either in a Docker container (recommended) or with a LaTeX distribution installed on your machine.

### Docker-based (recommended)

The [TeX Live docker image by the Island of TeX](https://gitlab.com/islandoftex/images/texlive#tex-live-docker-image) works the same on Windows, macOS, and Linux.
It ships a complete TeX Live including `latexmk`, `biber`, `latexindent`, Python, and [latexminted].
Thus, `minted` works out of the box - also on Windows, without a separate Python setup.

1. Install [Docker](https://docs.docker.com/get-started/get-docker/) ([Docker Desktop](https://docs.docker.com/desktop/) on Windows and macOS).
1. Open a terminal in the directory of this document and compile in the container.
   The first run downloads the image (approx. 3 GB); its tag selects the TeX Live version of this template.

   Windows (PowerShell):

   ```powershell
   docker run --rm -v "${PWD}:/workdir" registry.gitlab.com/islandoftex/images/texlive:latest latexmk main
   ```

   Windows (Command Prompt):

   ```cmd
   docker run --rm -v "%cd%:/workdir" registry.gitlab.com/islandoftex/images/texlive:latest latexmk main
   ```

   Linux and macOS:

   ```shell
   docker run --rm -v "$PWD:/workdir" registry.gitlab.com/islandoftex/images/texlive:latest latexmk main
   ```

1. Optional: Let VS Code compile in the container, see ["VS Code configuration"](#vs-code-configuration).

If you need additional tools in the image (for instance, PlantUML), extend the generated `Dockerfile`, build it with `docker build -t ltg .`, and use `ltg` instead of the image name.

### Traditional

Install a LaTeX distribution on your machine:

- Windows: Recent [MiKTeX](http://miktex.org/). MiKTeX installation hints are given at <http://latextemplates.github.io/scientific-thesis-template/#installation-hints-for-windows>.
- macOS: Recent [TeX Live](https://www.tug.org/texlive/) (e.g. through [MacTeX](https://tug.org/mactex/)) - Try `sudo tlmgr update --all` if you encounter issues with biblatex
- Linux: Recent TeX Live distribution

To have `minted` running with a traditional installation, you have to do following steps on Windows (the Docker image already contains all of this):

1. Install python: `choco install python` - that uses [chocolatey](https://chocolatey.org/) to install Python
2. Install [latexminted]: `pip install latexminted` - that uses the Python package manager to install the minted library
3. When latexing, use `-shell-escape`: `pdflatex -shell-escape main`.
   You can also just execute `latexmk main`.
### latexmk hints

[latexmk] runs the LaTeX tools (e.g., lualatex and biber) as often as needed to get the final PDF ([why `latexmk` is great](https://tex.stackexchange.com/a/249243/9075)).
It reads its configuration from `.latexmkrc` in the directory of the document.
Overleaf reads `.latexmkrc`, too, so the "Compiler" setting of the Overleaf project does not matter.
To use the configuration for all your documents, put it at [the right place](http://tex.stackexchange.com/a/41149/9075).

Build the document:

```bash
latexmk main
```

In the Docker-based setup, put the `docker run ...` part from ["Docker-based (recommended)"](#docker-based-recommended) in front, or just run `make`.
In the traditional setup, `latexmk` needs Perl (TeX Live ships it; with MiKTeX, install it, e.g., via `choco install strawberryperl`).

To recompile on every change and open the PDF, run:

```bash
latexmk -pvc main
```

On Windows, the configuration opens the PDF in [Sumatra PDF], which reloads the PDF automatically.

## Tool hints

### Editor and bibliography

Independent of the chosen setup:

- Grammar and spell checking is available at [TeXstudio].
  Please download [LanguageTool] (Windows: `choco install languagetool`) and [configure TeXstudio to use it](http://wiki.languagetool.org/checking-la-tex-with-languagetool#toc4).
  Note that it is enough to point to `languagetool.jar`.
  **If TeXstudio doesn't fit your need, check [the list of all available LaTeX Editors](http://tex.stackexchange.com/questions/339/latex-editors-ides).**
- Use [JabRef] to manage your bibliography (Windows: `choco install jabref`).

### Advanced usage

On the command line, there are additional features:

- `make` builds the PDF in the Docker container; `make LOCAL=1` uses your local LaTeX distribution (this works for all `make` targets)
- `latexmk -C` or `make clean` for cleaning up
- `make log` shows only the relevant messages of the last LaTeX run (using [texlogsieve](https://ctan.org/pkg/texlogsieve))
- `make format` to reformat the `.tex` files (one sentence per line and indent)
- `make aspell` for interactive spell checking
- `make stand`: Creates a new PDF with the current status of the document.
- `make view`: Opens the configured viewer
- `make mrproper`: Cleans up and removes also editor backup files.

### Linting your Markdown

Because the prose is a plain Markdown file, the text linters run on it directly — no extraction, and the reported line numbers point straight at `manuscript.md`. Two workflows lint it and post inline annotations: `check-markdown` runs [Vale](https://vale.sh) (spelling, repetition), and `check-textlint` runs [textlint](https://github.com/textlint/textlint) (`write-good` + `terminology`).

Run textlint locally with `npx` (needs Node.js; rules come from `.textlintrc.json`):

```bash
npx --yes --package textlint --package textlint-rule-terminology --package textlint-rule-write-good textlint manuscript.md
```

For Vale, install it (`brew install vale` / `choco install vale`, or see <https://vale.sh/docs>) and point it at the file:

```bash
vale manuscript.md
```

### VS Code configuration

Currently, following extensions are recommended:

- [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop) to support LaTeX in VS Code and
- [LaTeX Utilities](https://marketplace.visualstudio.com/items?itemName=tecosaur.latex-utilities) to enhance LaTeX Workshop
- [LTeX+] to have a nice spell checker that also identifies grammar issues

LaTeX Workshop builds with `latexmk`, which reads the configuration of this template (see ["latexmk hints"](#latexmk-hints)).
To compile in the Docker container (see ["Docker-based (recommended)"](#docker-based-recommended)), add the following lines to VS Code's `settings.json` (<kbd>Shift</kbd>+<kbd>Ctrl</kbd>+<kbd>P</kbd>, then "Preferences: Open Settings (JSON)"):

```javascript
    "latex-workshop.docker.enabled": true,
    "latex-workshop.docker.image.latex": "registry.gitlab.com/islandoftex/images/texlive:latest",
```

The following settings are additionally recommended:

```javascript
{
    "editor.wordWrap": "on",                                          // enable soft line breaks
    "latex-workshop.view.pdf.viewer": "tab",                          // display the generated PDF in a separate tab
    "latex-workshop.view.pdf.color.light.backgroundColor": "#cccccc", // light theme: use a darker background in the PDF viewer to lift the pages off it
    "latex-workshop.view.pdf.color.dark.backgroundColor": "#121314",  // dark theme: same, with a dark gray matching the editor
    "latex-workshop.latex.autoBuild.run": "never",                    // never automatically build; alternative: "onSave" (on saving .tex files)
    "editor.renderWhitespace": "all",                                 // display all whitespaces
}
```

Alternatively, just copy and paste the contents of the [vscode.settings.json](vscode.settings.json) file to your VS Code settings file.

You can manually trigger compilation by hitting the green button in the extension or using other methods provided by LaTeX Workshop.

### LTeX+ tips and tricks

[LTeX+] is an offline grammar and spell checker with support for LaTeX and Markdown.

Add a magic comment to your files to tell LTeX+ which language to use:

```latex
% LTeX: language=de-DE
```

If you want to use different languages in the text, use the `\foreignlanguage{language}{text}` command.
LTeX+ will detect these elements and automatically switch the spell checker's language.
For example:

```latex
\foreignlanguage{english}{Therefore, our proposed approach will change the world.}
```
## FAQs

### Q: How do I find the cause of a LaTeX error?

In case something goes wrong, you can instruct the LaTeX compiler to stop at the first error:

```bash
lualatex --synctex=1 --shell-escape main
```

Run `biber main` to get the bibliography rendered (execute `lualatex` afterwards).

## Further information

- Why the templates use which packages: [decision records of the template generator](https://github.com/latextemplates/generator-latex-template/tree/main/docs/decisions)
- Other templates: <https://latextemplates.github.io/>
- For German users, go to <https://texfragen.de/>.
- Frank Mittelbach with Ulrike Fischer: [The LaTeX Companion](https://www.latex-project.org/news/2023/03/17/TLC3/) is the ultimate guide for LaTeX: The authors went through all packages offered by [CTAN](https://ctan.org/), selected the most promising ones, described them, and provide minimal working example for each of it.
- Lutz Hering, Heike Hering: [How to Write Technial Reports](https://doi.org/10.1007/978-3-540-69929-3), Springer, 2010; also available in German [Technische Berichte - verständlich gliedern, gut gestalten, überzeugend vortragen](https://doi.org/10.1007/978-3-8348-8317-9). - Highly recommended, because it guides through all aspects of a report (such as a Master Thesis).
- Marcus Deininger et al.: [Studienarbeiten - Ein Leitfaden zur Erstellung, Durchführung und Präsentation wissenschaftlicher Abschlussarbeiten am Beispiel Informatik](https://vdf.ch/studienarbeiten.html?author_id=2877), vdf. - Recommended as guideline for planning and working on the whole thesis.
- Charles Lipson, [Cite Right, Second Edition: A Quick Guide to Citation Styles--MLA, APA, Chicago, the Sciences, Professions, and More](http://www.press.uchicago.edu/ucp/books/book/chicago/C/bo10702043.html), Chicago Guides to Writing, Editing, and Publishing, 2011. - Recommended in case you are unsure about how to correctly cite something.

## License

The license of this work is [0BSD](https://spdx.org/licenses/0BSD.html) which corresponds to "public domain".
Any derived work can freely be relicensed and can omit original copyright and license information.

[biber]: https://www.ctan.org/pkg/biber
[biblatex]: http://tex.stackexchange.com/tags/biblatex/info
[bibtex]: https://www.ctan.org/pkg/bibtex
[booktabs]: https://ctan.org/pkg/booktabs
[zref-clever]: https://ctan.org/pkg/zref-clever
[csquotes]: https://www.ctan.org/pkg/csquotes
[hypcap]: https://www.ctan.org/pkg/hypcap
[hyperref]: https://ctan.org/pkg/hyperref
[latexindent]: https://ctan.org/pkg/latexindent
[latexmk]: http://tex.stackexchange.com/tags/latexmk/info
[listings]: https://ctan.org/pkg/listings
[lualatex]: http://www.luatex.org/
[microtype]: https://ctan.org/pkg/microtype
[minted]: https://ctan.org/pkg/minted
[natbib]: https://ctan.org/pkg/natbib
[paralist]: https://www.ctan.org/pkg/paralist
[pdfcomment]: https://www.ctan.org/pkg/pdfcomment
[upquote]: https://www.ctan.org/pkg/upquote

[JabRef]: https://www.jabref.org
[LanguageTool]: https://languagetool.org/
[latex template generator]: https://www.npmjs.com/package/generator-latex-template
[LTeX+]: https://marketplace.visualstudio.com/items?itemName=ltex-plus.vscode-ltex-plus
[latexminted]: https://pypi.org/project/latexminted/
[Sumatra PDF]: https://www.sumatrapdfreader.org/free-pdf-reader

<!-- disable markdown-lint rules contradicting our writing of FAQs -->
<!-- markdownlint-disable-file MD001 MD013 MD026 -->
