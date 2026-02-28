# Data Model: Resource Count Badge

**Feature**: 001-resource-count-badge
**Date**: 2026-02-28

## Entities

### Resource Entry

A single line in README.md that represents a curated item.

| Attribute | Description |
|-----------|-------------|
| Line content | Full text of the line |
| Line number | Position in README.md |
| Pattern match | Line starts with `- ` (dash + space) at column 0 |
| Code block context | Whether the line is inside a fenced code block |

**Identity rule**: A line is a Resource Entry if and only if:
1. It starts with `- ` (dash followed by space) at the beginning of the line
2. It is NOT inside a fenced code block (delimited by `` ``` ``)

**Lifecycle**: Resource entries are added/removed by editing README.md.
No state transitions — an entry either exists or it does not.

### Badge

A shields.io static image embedded in README.md.

| Attribute | Description |
|-----------|-------------|
| Label | Fixed string: `resources` |
| Count | Integer >= 0 representing total Resource Entries |
| Color | Fixed: `blue` |
| URL | `https://img.shields.io/badge/resources-{count}-blue` |
| Position | Between the tagline blockquote and the first `##` section |

**Identity rule**: Exactly one badge exists in README.md, identified by
the markdown image pattern `![Resources](https://img.shields.io/badge/resources-...)`.

**Lifecycle**: The badge is inserted once. On subsequent updates, only the
count value in the URL changes.

## Relationships

```
README.md
├── Badge (exactly 1, positioned after tagline)
└── Resource Entries (0..N, spread across sections)
    └── Badge.count = count(Resource Entries)
```

The badge count is a derived value: it equals the total number of
Resource Entry lines in the README.
