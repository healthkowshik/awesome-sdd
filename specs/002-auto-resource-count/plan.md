# Implementation Plan: Automatic Resource Count

**Branch**: `002-auto-resource-count` | **Date**: 2026-03-02 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/002-auto-resource-count/spec.md`

## Summary

Automate the resource count badge in the README by adding a GitHub Actions workflow that runs on every push to `main`. The workflow calls the existing `scripts/update-badge.sh` script, and if the badge count is stale, auto-commits the fix. A portability fix is needed for the script to run on Linux (GitHub Actions runners).

## Technical Context

**Language/Version**: Bash (POSIX-compatible) + GitHub Actions YAML
**Primary Dependencies**: GitHub Actions (`actions/checkout`, `git`)
**Storage**: N/A (file-based, README.md only)
**Testing**: Shell script tests (bats or manual verification)
**Target Platform**: GitHub Actions (Ubuntu Linux runner) + local macOS
**Project Type**: CI automation for curated list repository
**Performance Goals**: N/A (runs once per push, sub-second script)
**Constraints**: Workflow must only modify the badge line; must not trigger infinite push loops
**Scale/Scope**: Single repository, single workflow, ~1 push/day

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Curation Quality | Pass | Does not affect entry quality; only automates badge metadata |
| II. Consistent Formatting | Pass | Badge format `resources-<count>-blue` preserved exactly |
| III. Organized Categories | Pass | No category changes |
| IV. Link Verification | Pass | No link changes |
| V. Community Value | Pass | Reduces manual maintenance burden for contributors |

No violations. No complexity tracking needed.

## Project Structure

### Documentation (this feature)

```text
specs/002-auto-resource-count/
├── plan.md
├── research.md
├── data-model.md
└── quickstart.md
```

### Source Code (repository root)

```text
.github/
└── workflows/
    └── update-badge.yml    # NEW: GitHub Actions workflow

scripts/
└── update-badge.sh         # MODIFIED: portability fix for Linux sed
```

**Structure Decision**: No new `src/` or `tests/` directories. This feature adds a single workflow file and a portability fix to an existing script. Matches the existing flat project structure.
