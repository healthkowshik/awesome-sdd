# Research: Resource Count Badge

**Feature**: 001-resource-count-badge
**Date**: 2026-02-28

## Badge Rendering Approach

**Decision**: Static shields.io badge with count embedded in the URL.

**Rationale**: shields.io static badges are the standard for awesome lists
and GitHub README badges. They require no server, no authentication, and
render reliably on GitHub. The URL pattern
`https://img.shields.io/badge/<label>-<value>-<color>` is well-established
and widely used. The badge is a simple image tag in markdown.

**Alternatives considered**:

| Alternative | Why rejected |
|-------------|--------------|
| Dynamic shields.io endpoint | Requires hosting a JSON endpoint; over-engineered for a static list |
| GitHub Actions auto-update | Adds CI complexity for a simple count; maintainer-triggered is sufficient |
| Plain markdown text (no image) | Does not match awesome list conventions; less visually distinct |
| Custom SVG committed to repo | Extra file to maintain; shields.io handles rendering and caching |

## Count Mechanism

**Decision**: Bash script using grep to count lines starting with `- `
(outside fenced code blocks) and sed to update the badge URL in-place.

**Rationale**: The README is a single file. grep and sed are universally
available on macOS and Linux. No dependencies to install. The script is
simple enough to audit in seconds.

**Alternatives considered**:

| Alternative | Why rejected |
|-------------|--------------|
| Python script | Adds a runtime dependency for a trivial task |
| Node.js script | Same — unnecessary dependency |
| Manual count | Error-prone; spec requires updateability (FR-005) |
| Makefile target | Adds build tooling overhead; a standalone script is simpler |

## Code Block Exclusion

**Decision**: Use awk to track fenced code block state (toggle on lines
matching `` ``` ``) and only count `- ` lines when outside a code block.

**Rationale**: Simple grep cannot distinguish `- ` inside vs outside code
blocks. awk provides stateful line-by-line processing without external
dependencies. This satisfies FR-002 and the fenced code block edge case.

## Badge Styling

**Decision**: Use the `blue` color with label `resources`.

**Rationale**: Blue is neutral and commonly used in awesome list badges.
The label "resources" matches FR-004's example and clearly communicates
what the number represents.

**Badge URL pattern**:
```
https://img.shields.io/badge/resources-COUNT-blue
```

**Rendered markdown**:
```markdown
![Resources](https://img.shields.io/badge/resources-9-blue)
```
