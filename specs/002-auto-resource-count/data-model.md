# Data Model: Automatic Resource Count

**Feature**: 002-auto-resource-count
**Date**: 2026-03-02

## Entities

### Resource Entry

A line in the README matching the pattern `- [Title](URL)` (optionally followed by ` - Description`) that appears outside fenced code blocks.

| Attribute | Description |
|-----------|-------------|
| Line content | Full text of the list item |
| Position | Must be outside ``` fenced code blocks |
| Pattern | Starts with `- ` at the beginning of the line |

**Counting rule**: Count all lines matching `^- ` that are not inside a fenced code block pair. This is the existing logic in `scripts/update-badge.sh` using `awk`.

### Badge

The shields.io image URL embedded in the README that displays the resource count.

| Attribute | Description |
|-----------|-------------|
| URL pattern | `img.shields.io/badge/resources-<count>-blue` |
| Location | Near the top of README.md, after the title and description |
| Count value | Integer matching the number of Resource Entries |

**State transitions**:
- `count matches` → No action taken, script exits cleanly
- `count mismatch` → Badge URL updated in-place, auto-commit pushed

## Relationships

```text
README.md
├── Badge (exactly 1)
│   └── count value derived from →
└── Resource Entries (0..N)
    └── counted by awk script
```

No persistent storage. All state lives in `README.md` and is computed fresh on each workflow run.
