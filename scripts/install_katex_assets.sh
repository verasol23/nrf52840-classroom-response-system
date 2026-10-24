#!/usr/bin/env bash
# Install only the matching upstream KaTeX runtime font assets on the user's machine.
# Does not change any project source files; requires npm / Internet.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
command -v npm >/dev/null || { echo "Requires npm" >&2; exit 1; }
TEMP="$(mktemp -d)"
trap 'rm -rf "$TEMP"' EXIT
cd "$TEMP"
npm pack katex@0.16.11 --silent >/dev/null
TARBALL=$(find . -maxdepth 1 -name 'katex-*.tgz' -print -quit)
[ -n "$TARBALL" ] || { echo "Could not retrieve KaTeX package" >&2; exit 1; }
mkdir -p "$ROOT/web/assets/vendor/katex/fonts"
tar -xzf "$TARBALL" --strip-components=3 -C "$ROOT/web/assets/vendor/katex/fonts" --wildcards 'package/dist/fonts/*'
echo "KaTeX font assets installed locally; their folder is Git-ignored."
