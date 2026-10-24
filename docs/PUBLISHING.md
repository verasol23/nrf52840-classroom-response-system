# Publish this curated release to GitHub

The GitHub connector may only be able to edit repository text and cannot transfer every uploaded CAD/binary file from this local archive. This release therefore includes a small script that imports the complete tree from Ubuntu using your normal Git credentials and keeps a remote rollback branch.

1. Extract this release into its own directory (do not unpack over a live deployment or old checkout).
2. Read the [release checklist](RELEASE_CHECKLIST.md) and confirm team permission to publish.
3. Execute `bash scripts/publish_to_github.sh` from the **extracted** release. The script clones the existing remote, creates/pushes a backup branch, replaces tracked files, shows the staged summary, commits and pushes `main` with normal (non-force) Git history.
4. Check GitHub main and GitHub Actions after the push.

The GitHub remote URL is `https://github.com/verasol23/nrf52840-classroom-response-system.git`. The script does not use `--force`, so it will not overwrite someone else's newer remote commits; backup can be used to restore an earlier release.
