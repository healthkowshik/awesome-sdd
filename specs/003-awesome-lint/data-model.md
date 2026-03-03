# Data Model: Awesome Lint

**Feature**: 003-awesome-lint
**Date**: 2026-03-03

## Entities

This feature has no persistent data model. awesome-lint is a stateless linting tool that reads the README on each run and produces pass/fail output.

### Lint Rule

A formatting check enforced by awesome-lint against the README.

| Attribute | Description |
|-----------|-------------|
| Rule name | Identifier (e.g., `awesome-badge`, `awesome-spell-check`) |
| Severity | Error (all rules are errors by default) |
| Scope | What the rule checks (badge presence, file existence, formatting, spelling) |
| Suppressible | Can be disabled via `<!--lint disable rule-name-->` comments |

### Lint Result

The output of a single awesome-lint run.

| Attribute | Description |
|-----------|-------------|
| Status | Pass (0 errors) or Fail (1+ errors) |
| Error count | Number of violations found |
| Error details | Per-error: file, line, column, rule name, message |

## State Transitions

```text
Pull Request opened/updated
    │
    ▼
Lint workflow triggered
    │
    ▼
awesome-lint runs against README.md
    │
    ├── 0 errors → Status check: PASS ✓
    │
    └── 1+ errors → Status check: FAIL ✗
                     (error details shown in workflow log)
```

No persistent state. Each run is independent.
