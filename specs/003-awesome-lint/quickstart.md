# Quickstart: Awesome Lint

**Feature**: 003-awesome-lint
**Date**: 2026-03-03

## What This Feature Does

After implementation, every pull request that modifies the README is automatically checked against awesome list formatting standards. The check appears as a status check on the PR — passing if formatting is correct, failing with specific error details if violations are found.

## How It Works

1. A contributor opens a PR that modifies `README.md` or `contributing.md`
2. The `awesome-lint` GitHub Actions workflow triggers
3. The workflow runs `npx awesome-lint` against the README
4. If violations are found, the PR status check fails and error details appear in the workflow log
5. If no violations are found, the PR status check passes

## Files Involved

| File | Role |
|------|------|
| `.github/workflows/awesome-lint.yml` | Workflow definition (trigger, lint step) |
| `contributing.md` | Contribution guidelines (required by awesome-lint) |
| `README.md` | The awesome list being linted |

## Running Locally

Check the README against awesome list standards:

```bash
npx awesome-lint
```

No local installation needed — `npx` downloads and runs the latest version.

## Verification

After merging, verify the automation works by:

1. Creating a branch with a deliberately malformed list entry (e.g., `* Wrong marker [Title](url)`)
2. Opening a PR targeting `main`
3. Checking that the `awesome-lint` workflow triggers and the PR status check fails
4. Fixing the entry and pushing — the check should pass on the next run
