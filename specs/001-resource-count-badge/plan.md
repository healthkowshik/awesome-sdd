# Implementation Plan: Resource Count Badge

**Branch**: `001-resource-count-badge` | **Date**: 2026-02-28 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `/specs/001-resource-count-badge/spec.md`

## Summary

Display a shields.io static badge at the top of the README showing the
total count of curated resources. A bash script counts lines matching the
`- ` pattern (outside fenced code blocks) and updates the badge URL
in-place. Maintainers run the script before merging changes that add or
remove resources.

## Technical Context

**Language/Version**: Bash (POSIX-compatible shell script)
**Primary Dependencies**: grep, sed (standard Unix tools)
**Storage**: N/A (README.md is the single source of truth)
**Testing**: Manual verification — compare badge count to
`grep -c '^- ' README.md`
**Target Platform**: GitHub README rendering (GitHub-flavored Markdown)
**Project Type**: Curated list / documentation
**Performance Goals**: N/A (single file, sub-second execution)
**Constraints**: Badge must render on GitHub without authenticated
external services; shields.io is public and unauthenticated
**Scale/Scope**: Single README file, currently 9 resources

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Curation Quality | PASS | Feature does not add/remove resources; badge is metadata |
| II. Consistent Formatting | PASS | Badge uses standard shields.io markdown image syntax; positioned consistently between tagline and first section |
| III. Organized Categories | PASS | Badge is above all sections, does not affect categorization |
| IV. Link Verification | PASS | shields.io badge URL returns 200; verified as publicly accessible |
| V. Community Value | PASS | Badge gives visitors an immediate sense of list breadth |

No violations. Complexity Tracking section not needed.

## Project Structure

### Documentation (this feature)

```text
specs/001-resource-count-badge/
├── plan.md              # This file
├── research.md          # Badge approach research
├── data-model.md        # Entity definitions
├── quickstart.md        # Usage instructions
└── tasks.md             # Task list (created by /speckit.tasks)
```

### Source Code (repository root)

```text
scripts/
└── update-badge.sh      # Counts resources, updates badge URL in README

README.md                # Badge added between tagline and first section
```

**Structure Decision**: Minimal single-script layout. The script lives in
`scripts/` at the repository root. No `src/` or `tests/` directories are
needed — this feature modifies the README and provides a maintenance
script.
