# Feature Specification: Automatic Resource Count

**Feature Branch**: `002-auto-resource-count`
**Created**: 2026-03-02
**Status**: Draft
**Input**: User description: "Keep resource count up to date automatically. What are a few options and which one is recommended?"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Resource Count Stays Accurate After Edits (Priority: P1)

As a contributor, when I add or remove a resource entry in the README, the resource count badge should update automatically without me having to remember to run a script or manually edit the badge number.

**Why this priority**: This is the core value of the feature. Today, contributors must manually run `scripts/update-badge.sh` or edit the badge count by hand, which is error-prone and easy to forget. Automating this eliminates the most common source of badge staleness.

**Independent Test**: Can be fully tested by adding a new resource line to the README and verifying the badge count updates to the correct number without manual intervention.

**Acceptance Scenarios**:

1. **Given** the README has 11 resources and badge shows `resources-11-blue`, **When** a contributor adds a 12th resource entry, **Then** the badge updates to `resources-12-blue` without manual action.
2. **Given** the README has 12 resources and badge shows `resources-12-blue`, **When** a contributor removes a resource entry, **Then** the badge updates to `resources-11-blue` without manual action.
3. **Given** the README has 11 resources and badge already shows `resources-11-blue`, **When** a contributor edits an existing resource (e.g., fixes a typo in a URL), **Then** the badge remains `resources-11-blue` and no unnecessary changes are made.

---

### Edge Cases

- What happens when the README contains list items inside fenced code blocks? (They should not be counted as resources — the existing script already handles this.)
- What happens when the badge URL pattern is missing or malformed in the README?
- What happens when a contributor adds multiple resources in a single change?
- What happens when the resource count goes to zero (all resources removed)?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The system MUST automatically detect when the resource count in the README changes.
- **FR-002**: The system MUST update the shields.io badge count to match the actual number of resource entries.
- **FR-003**: The system MUST only count list items (lines starting with `- `) that are outside fenced code blocks, consistent with the existing counting logic.
- **FR-004**: The system MUST not make changes when the badge count already matches the actual resource count.
- **FR-005**: The system MUST run automatically on every push to the main branch that modifies the README, and auto-commit the corrected badge count if a mismatch is detected.

### Key Entities

- **Resource Entry**: A list item in the README (line starting with `- ` outside code blocks) representing a curated resource link.
- **Badge**: The shields.io image URL in the README that displays the current resource count.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% of merged README changes result in an accurate badge count with zero manual intervention.
- **SC-002**: No false positives — list items inside code blocks, comments, or non-resource sections are never miscounted.

## Clarifications

### Session 2026-03-02

- Q: User Story 2 describes feedback "before the change is merged," but the chosen approach auto-commits fixes after push to main. How should this tension be resolved? → A: Remove US2 — auto-commit handles everything; no separate feedback step needed.

## Assumptions

- The existing `scripts/update-badge.sh` logic for counting resources and updating the badge is correct and will be reused.
- The shields.io badge URL format (`img.shields.io/badge/resources-<count>-blue`) will remain consistent.
- The README structure (resources as top-level list items under section headings) will remain consistent.
- This is a single-maintainer or small-team project hosted on GitHub.
