# Implementation Plan: Awesome Lint

**Branch**: `003-awesome-lint` | **Date**: 2026-03-03 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/003-awesome-lint/spec.md`

## Summary

Add awesome-lint to enforce awesome list formatting standards. This involves: (1) a GitHub Actions workflow that runs `npx awesome-lint` on pull requests modifying the README, and (2) fixing the 5 existing violations in the current README (missing awesome badge, missing contributing.md, repository validation, and two spelling issues).

## Technical Context

**Language/Version**: GitHub Actions YAML + Node.js (via npx, no local install)
**Primary Dependencies**: awesome-lint (npm, run via npx), GitHub Actions (`actions/checkout`, `actions/setup-node`)
**Storage**: N/A
**Testing**: Manual verification (run `npx awesome-lint` locally)
**Target Platform**: GitHub Actions (Ubuntu Linux runner)
**Project Type**: CI linting for curated awesome list
**Performance Goals**: N/A (runs once per PR, completes in seconds)
**Constraints**: Must use `fetch-depth: 0` in checkout for repository age validation; must not conflict with existing update-badge workflow
**Scale/Scope**: Single repository, single workflow, single README file

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Curation Quality | Pass | Linting enforces quality standards; does not change curation criteria |
| II. Consistent Formatting | Pass | Directly supports this principle — awesome-lint enforces the formatting rules defined here |
| III. Organized Categories | Pass | awesome-lint checks list structure and sections |
| IV. Link Verification | Pass | Link liveness is explicitly out of scope for this feature; awesome-lint checks formatting, not URLs |
| V. Community Value | Pass | Automated enforcement reduces reviewer burden and ensures consistent contributor experience |

No violations. No complexity tracking needed.

## Project Structure

### Documentation (this feature)

```text
specs/003-awesome-lint/
├── plan.md
├── research.md
├── data-model.md
└── quickstart.md
```

### Source Code (repository root)

```text
.github/
└── workflows/
    ├── update-badge.yml       # EXISTING: badge auto-update
    └── awesome-lint.yml       # NEW: lint check on PRs

contributing.md                # NEW: required by awesome-lint
README.md                     # MODIFIED: fix 5 existing violations
```

**Structure Decision**: No new `src/` or `tests/` directories. This feature adds one workflow file, one contributing.md, and fixes to the existing README. Matches the flat project structure.
