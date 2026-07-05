# LaTeX Document

This is a **minimal Markdown quick start**. Write your content as plain Markdown in [`manuscript.md`](manuscript.md); the thin wrapper [`main.tex`](main.tex) pulls it in with `\markdownInput` and LaTeX turns it into a PDF — no thesis scaffolding, just the essentials: headings, citations, footnotes, tables, figures, and smart cross-references (`\zcref`). Keeping the prose in a real `.md` file means your editor treats it as Markdown and the spell-/prose-checkers below lint it directly.

## Usage

- `main.tex` is the main document
- Use "lualatex + biblatex" in your TeX editor or `latexmk main` / `make` in the command line

### Using `latexmk`

[latexmk] is a very smart tool for latex compilation.
It executes the latex tools as often as needed to get the final PDF.
(More information about why `latexmk` is great can be found at <https://tex.stackexchange.com/a/249243/9075>.)

To build the whole document, execute following command.
Note that this requires a working perl installation.

```bash
latexmk main
```

To enable latexmk, please move `_latexmkrc` to `latexmkrc`.

If you want automatic compilation use following command:

```bash
latexmk -pvc main
```

This will also open a [Sumatra PDF] and only works with the supplied configuration.

#### latexmk configuration

This repository ships a `.latexmkrc` which is read by latexmk.
In case there is a `_latexmkrc` file, you need to rename it to `.latexmkrc`.
It is configured for Windows and especially sets Sumatra PDF as default PDF viewer.
You can make this local configuration a global configuration, when you put it at [the right place](http://tex.stackexchange.com/a/41149/9075).

If you want to add more packages, configure it there.
For instance, for support of `makeglossaries` see <http://tex.stackexchange.com/questions/1226/how-to-make-latexmk-use-makeglossaries>.

### Debugging LaTeX errors

In case something goes wrong, you can instruct the LaTeX compiler to stop at the first error:

```bash
lualatex --synctex=1 --shell-escape main
```

Run `biber main` to get the bibliography rendered (execute `lualatex` afterwards).

### Advanced usage

On the command line, there are additional features:

- `latexmk -C` or `make clean` for cleaning up
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

## Tool hints

### Prerequisites

- Windows: Recent [MiKTeX](http://miktex.org/). MiKTeX installation hints are given at <http://latextemplates.github.io/scientific-thesis-template/#installation-hints-for-windows>.
- Mac OS X: Recent [TeX Live](https://www.tug.org/texlive/) (e.g. through [MacTeX](https://tug.org/mactex/)) - Try `sudo tlmgr update --all` if you encounter issues with biblatex
- Linux: Recent TeX Live distribution
- Grammar and spell checking is available at [TeXstudio].
  Please download [LanguageTool] (Windows: `choco install languagetool`) and [configure TeXstudio to use it](http://wiki.languagetool.org/checking-la-tex-with-languagetool#toc4).
  Note that it is enough to point to `languagetool.jar`.
  **If TeXstudio doesn't fit your need, check [the list of all available LaTeX Editors](http://tex.stackexchange.com/questions/339/latex-editors-ides).**
- Use [JabRef] to manage your bibliography (Windows: `choco install jabref`).

### Usage of `minted`

To have minted running properly, you have to do following steps on Windows:

1. Install python: `choco install python` - that uses [chocolatey](https://chocolatey.org/) to install Python
2. Install [latexminted]: `pip instal latexminted` - that uses the Python package manager to install the minted library
3. When latexing, use `-shell-escape`: `pdflatex -shell-escape main`.
   You can also just execute `latexmk main`.

### VS Code configuration

Currently, following extensions are recommended:

- [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop) to support LaTeX in VS Code and
- [LaTeX Utilities](https://marketplace.visualstudio.com/items?itemName=tecosaur.latex-utilities) to enhance LaTeX Workshop
- [LTeX+] to have a nice spell checker that also identifies grammar issues

Then, change the setting of LaTeX Workshop to use `biber`:

Press <kbd>Shift</kbd>+<kbd>Ctrl</kbd>+<kbd>P</kbd> to open the command palette.
Then type "JSON" and select "Preferences: Open Settings (JSON)" to open `settings.json`.

Update the following lines in VS Code's `settings.json` to contain:

```javascript
    "latex-workshop.latex.recipes": [
        {
            "name": "lualatex ➞ biblatex ➞ lualatex × 2 🔃",
            "tools": [
                "lualatex",
                "biblatex",
                "lualatex",
                "lualatex"
            ]
        },
    ],
    "latex-workshop.latex.tools": [
        // ...
        {
            "name": "biblatex",
            "command": "biblatex",
            "args": [
                "%DOCFILE%"
            ],
            "env": {}
        },
        // ...
    ],
```

The following settings are additionally recommended:

```javascript
{
    "editor.wordWrap": "on",                              // enable soft line breaks
    "latex-workshop.view.pdf.viewer": "tab",              // display the generaded PDF in a separate tab
    "latex-workshop.view.pdf.backgroundColor": "#cccccc", // use a darker background in de PDF viewer to lift of the pages from it
    "latex-workshop.latex.autoBuild.run": "never",        // never automatically build; alternative: "onSave" (on saving .tex files)
    "editor.renderWhitespace": "all",                     // display all whitespaces
}
```

Alternatively, just copy and paste the contents of the [vscode.settings.json](vscode.settings.json) file to your VS Code settings file.

You can manually trigger compilation by hitting the green button in the extension or using other methods provided by LaTeX Workshop.

Please remove the magic comments (`% !TeX program ...`) at the top of the `main.tex` file.
Although [LaTeX-Workshop supports magic comments](https://github.com/James-Yu/LaTeX-Workshop/blob/master/README.md#magic-comments), it currently does not work reliably.
Without the magic comments, compilation works.

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

## Usage with docker

The generated `Dockerfile` is based on the [Dockerfile by the Island of TeX](https://gitlab.com/islandoftex/images/texlive#tex-live-docker-image).

```cmd
docker run --rm -v "c:\users\example\latex-document:/workdir" ltg latexmk
```

Following one-time setup is required:

```cmd
docker build -t ltg .
```

## Further information

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
[cleveref]: https://ctan.org/pkg/cleveref
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
