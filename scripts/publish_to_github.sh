#!/usr/bin/env bash
set -euo pipefail
REPO="https://github.com/verasol23/nrf52840-classroom-response-system.git"
RELEASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
printf 'Cloning current GitHub main to preserve existing history...\n'
git clone "$REPO" "$TMP/repo"
cd "$TMP/repo"
git checkout main
# Keep a rollback ref on the remote, even if the remote backup was already created.
STAMP="$(date +%Y%m%d-%H%M%S)"
git branch "backup/pre-release-$STAMP"
git push origin "backup/pre-release-$STAMP"
# Delete tracked old files only, then copy complete curated release.
git rm -r -q -- .
cp -a "$RELEASE_DIR"/. .
# Do not publish nested repositories, and ignore runtime files.
rm -rf .gitignore.lock 2>/dev/null || true
git add -A
printf '\nChanged files summary:\n'
git diff --cached --stat
printf '\nCommitting and pushing curated release (backup branch created above).\n'
git commit -m "release: curated nRF52840 system with Rev J KiCad and firmware history"
git push origin main
