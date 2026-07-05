#!/bin/sh
# Lint the Markdown prose of a "mwe" (Markdown quick start) LaTeX main.
#
# The prose lives inside a \begin{markdown} … \end{markdown} block, and text
# linters work on Markdown files — so this script pulls that block out, runs
# textlint on it, and rewrites the reported line numbers back to the .tex file.
# You get editor-jumpable "main.tex:LINE:COL: message" output instead of
# findings pointing at a throwaway extract.
#
# Usage:   ./lint.sh [main.tex]        (default: main.tex)
# Needs:   npx (Node.js) and jq. Rules come from .textlintrc.json.
set -eu

MAIN="${1:-main.tex}"

# Line of \begin{markdown}; an extracted line L maps to MAIN line L + OFFSET.
OFFSET=$(grep -n '^\\begin{markdown}' "$MAIN" | head -1 | cut -d: -f1)
[ -n "${OFFSET:-}" ] || { echo "no \\begin{markdown} block found in $MAIN" >&2; exit 1; }

# textlint picks its parser by extension, so the extract must end in .md.
TMPD=$(mktemp -d)
trap 'rm -rf "$TMPD"' EXIT
BODY="$TMPD/body.md"
sed -n '/^\\begin{markdown}/,/^\\end{markdown}/p' "$MAIN" | sed '1d;$d' > "$BODY"

# textlint reports on $BODY; jq adds OFFSET to each line and relabels it as MAIN.
npx --yes \
  --package textlint \
  --package textlint-rule-terminology \
  --package textlint-rule-write-good \
  textlint --format json "$BODY" \
  | jq -r --argjson off "$OFFSET" --arg main "$MAIN" '
      .[].messages[]
      | "\($main):\(.line + $off):\(.column): [\(.ruleId)] \(.message)"'
