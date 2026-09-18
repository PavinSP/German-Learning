#!/usr/bin/env bash
# Regenerate "Complete Notes.tex" and "Complete Notes.pdf" from "Complete Notes.md".
#
# Run this EVERY time Complete Notes.md changes (see the hard rule in
# CURRENT_STATE.md). The .tex and .pdf are generated artefacts — never edit
# them by hand, edit the Markdown and re-run this.
#
# Requires: pandoc + xelatex (both confirmed present 2026-09-18).
# XeLaTeX specifically — the notes contain umlauts, arrows and symbols that
# pdflatex mangles.

set -euo pipefail

cd "$(dirname "$0")"

SRC="Complete Notes.md"
TEX="Complete Notes.tex"
PDF="Complete Notes.pdf"
PREAMBLE="notes_preamble.tex"

if [[ ! -f "$SRC" ]]; then
  echo "ERROR: $SRC not found — nothing to build." >&2
  exit 1
fi

echo "Building from $SRC ..."

# Emoji and some symbols have no glyph in the text font and would either be
# dropped silently or abort the build. Swap them for LaTeX-safe equivalents
# on the way through. The Markdown keeps the emoji (nicer to read on GitHub);
# only the PDF pipeline substitutes them.
STAGED="$(mktemp -t notes_staged).md"
trap 'rm -f "$STAGED"' EXIT

# Note on arrows: Palatino has no U+2192 glyph, so a literal → is dropped
# silently from the PDF. Since arrows carry real meaning here (der->den->dem,
# es->ihm), they are replaced with an ASCII arrow rather than lost.
sed -e 's/⚠️/**!**/g' \
    -e 's/🔴/**[HIGH]**/g' \
    -e 's/🟡/**[MED]**/g' \
    -e 's/🟢/**[OK]**/g' \
    -e 's/💡/**Tip:**/g' \
    -e 's/✅/(correct)/g' \
    -e 's/❌/(wrong)/g' \
    -e 's/⚡/*/g' \
    -e 's/→/->/g' \
    -e 's/←/<-/g' \
    -e 's/⟶/->/g' \
    -e 's/↑/^/g' \
    "$SRC" > "$STAGED"

pandoc "$STAGED" \
  --from=markdown+pipe_tables+yaml_metadata_block \
  --to=latex \
  --standalone \
  --pdf-engine=xelatex \
  --include-in-header="$PREAMBLE" \
  --toc --toc-depth=2 \
  --variable=geometry:"a4paper,margin=2.2cm" \
  --variable=fontsize:11pt \
  --variable=colorlinks:true \
  --variable=linkcolor:headingblue \
  --variable=toccolor:headingblue \
  --metadata title="German — Complete Notes" \
  --metadata subtitle="Everything covered so far, in study format" \
  --metadata date="Rebuilt $(date +%Y-%m-%d)" \
  --output="$TEX"

echo "  wrote $TEX"

pandoc "$STAGED" \
  --from=markdown+pipe_tables+yaml_metadata_block \
  --pdf-engine=xelatex \
  --include-in-header="$PREAMBLE" \
  --toc --toc-depth=2 \
  --variable=geometry:"a4paper,margin=2.2cm" \
  --variable=fontsize:11pt \
  --variable=colorlinks:true \
  --variable=linkcolor:headingblue \
  --variable=toccolor:headingblue \
  --metadata title="German — Complete Notes" \
  --metadata subtitle="Everything covered so far, in study format" \
  --metadata date="Rebuilt $(date +%Y-%m-%d)" \
  --output="$PDF"

echo "  wrote $PDF"
echo "Done."
