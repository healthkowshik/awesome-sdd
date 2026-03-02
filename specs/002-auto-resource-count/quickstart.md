# Quickstart: Automatic Resource Count

**Feature**: 002-auto-resource-count
**Date**: 2026-03-02

## What This Feature Does

After implementation, the resource count badge in the README automatically stays in sync. When you push a change to `main` that adds or removes a resource, a GitHub Actions workflow detects the mismatch and commits a badge fix within seconds.

## How It Works

1. You push a commit to `main` that modifies `README.md`
2. The `update-badge` GitHub Actions workflow triggers
3. The workflow runs `scripts/update-badge.sh` which:
   - Counts resource entries (list items outside code blocks)
   - Compares to the badge count in the shields.io URL
   - If they differ, updates the badge URL in-place
4. If the badge was updated, the workflow commits and pushes the fix
5. The auto-commit includes `[skip ci]` to prevent re-triggering

## Files Involved

| File | Role |
|------|------|
| `.github/workflows/update-badge.yml` | Workflow definition (trigger, steps, auto-commit) |
| `scripts/update-badge.sh` | Badge counting and updating logic (already exists, needs portability fix) |
| `README.md` | Contains the badge and resource entries |

## Local Development

The existing script still works locally for manual checks:

```bash
./scripts/update-badge.sh
```

No local setup is needed for the automation — it runs entirely in GitHub Actions.

## Verification

After merging, verify the automation works by:

1. Adding a test resource line to README.md
2. Pushing to `main`
3. Checking that a follow-up commit appears within ~30 seconds updating the badge count
4. Removing the test resource and pushing again to confirm the count decreases
