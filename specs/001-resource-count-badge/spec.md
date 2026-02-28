# Feature Specification: Resource Count Badge

**Feature Branch**: `001-resource-count-badge`
**Created**: 2026-02-28
**Status**: Draft
**Input**: User description: "Display the count of resources currently on the README as a badge. Resources are listed on the README in separate lines, the line begins with a dash -, and then there is a space and then some text."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - View Total Resource Count at a Glance (Priority: P1)

A visitor lands on the awesome-sdd README and immediately sees a badge
near the top of the page displaying the total number of curated resources.
This gives them an instant sense of the list's breadth without scrolling
through every section.

**Why this priority**: The badge is the entire feature — displaying an
accurate count is the core value proposition.

**Independent Test**: Open the README and verify the badge is visible near
the top and shows the correct total count of resources.

**Acceptance Scenarios**:

1. **Given** the README contains resource entries (lines starting with
   `- ` followed by text), **When** a visitor views the README,
   **Then** a badge is displayed near the top showing the total count
   of all resources across every section.
2. **Given** a new resource entry is added to any section of the README,
   **When** the badge value is refreshed, **Then** the displayed count
   increases by the number of entries added.
3. **Given** a resource entry is removed from the README, **When** the
   badge value is refreshed, **Then** the displayed count decreases
   accordingly.

---

### User Story 2 - Accurate Count Across All Sections (Priority: P2)

A maintainer adds, removes, or reorganizes resources across sections
(Articles, Tooling, Videos, or any future section) and expects the badge
count to reflect only valid resource entries — not headings, blank lines,
or other markdown content.

**Why this priority**: Accuracy of the count is essential for the badge
to be trustworthy, but this is a correctness concern that follows from
the display concern in US1.

**Independent Test**: Modify the README by adding and removing entries in
different sections, then verify the badge count matches a manual count of
all lines matching the `- ` pattern.

**Acceptance Scenarios**:

1. **Given** the README has resource entries spread across multiple
   sections, **When** the count is calculated, **Then** it equals the
   total number of lines that start with `- ` followed by text,
   regardless of which section they belong to.
2. **Given** a line starts with `- ` but appears inside a code block or
   non-resource context, **When** the count is calculated, **Then** that
   line is excluded from the count.

---

### Edge Cases

- What happens when the README has zero resource entries? The badge MUST
  display `0`.
- What happens when a line starts with `- ` but is inside a fenced code
  block (` ``` `)? It MUST NOT be counted as a resource.
- What happens when a line starts with `-` but has no space after the
  dash? It MUST NOT be counted (the pattern requires `- ` — dash followed
  by a space).

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The README MUST display a badge showing the total count of
  resources.
- **FR-002**: A resource is defined as any line in the README that starts
  with `- ` (dash followed by a space) and is not inside a fenced code
  block.
- **FR-003**: The badge MUST be positioned between the page title/tagline
  and the first content section.
- **FR-004**: The badge MUST display a label (e.g., "resources") and the
  numeric count.
- **FR-005**: The count MUST be updateable whenever the README content
  changes (resources added or removed).

### Key Entities

- **Resource Entry**: A single line in the README starting with `- `
  (outside of code blocks) that represents a curated item in the list.
- **Badge**: A visual indicator displayed at the top of the README
  showing the total number of resource entries.

### Assumptions

- The badge is displayed on the README rendered by GitHub (standard
  GitHub-flavored Markdown rendering).
- The current README structure uses `## Section` headings to organize
  resources, with each resource on its own `- ` prefixed line.
- The badge label and style follow conventions commonly seen in other
  awesome lists (e.g., shields-style badge).

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: The badge is visible within the first screenful of the
  README (above the fold) on a standard desktop viewport.
- **SC-002**: The count displayed on the badge matches a manual count
  of all `- ` prefixed lines (outside code blocks) in the README, with
  100% accuracy.
- **SC-003**: After a resource is added or removed, the badge count can
  be updated to reflect the change before merging.
- **SC-004**: The badge renders correctly on GitHub's README preview
  without requiring any external service that the visitor must
  authenticate with.
