# Tasks: Resource Count Badge

**Input**: Design documents from `/specs/001-resource-count-badge/`
**Prerequisites**: plan.md (required), spec.md (required), research.md, data-model.md, quickstart.md

**Tests**: Not requested in the feature specification. No test tasks included.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2)
- Include exact file paths in descriptions

## Path Conventions

- Script: `scripts/` at repository root
- Data: `README.md` at repository root

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Create the project directory structure for the script

- [x] T001 Create `scripts/` directory at repository root

**Checkpoint**: Directory structure ready for script creation

---

## Phase 2: User Story 1 - View Total Resource Count at a Glance (Priority: P1) MVP

**Goal**: A visitor sees a shields.io badge near the top of the README displaying the total number of curated resources.

**Independent Test**: Open README.md and verify the badge appears between the tagline and the first section, displaying the correct total resource count.

### Implementation for User Story 1

- [x] T002 [US1] Insert badge markdown into README.md — add `![Resources](https://img.shields.io/badge/resources-0-blue)` on a new line after the tagline blockquote (`> ...`) and before the first `## ` section heading
- [x] T003 [US1] Create `scripts/update-badge.sh` — write a bash script that: (1) counts lines starting with `- ` in README.md using grep, (2) updates the badge URL count in-place using sed, (3) prints old and new count to stdout for verification
- [x] T004 [US1] Make `scripts/update-badge.sh` executable (`chmod +x`) and run it to set the initial badge count in README.md

**Checkpoint**: Badge is visible in README.md with accurate count. Running `scripts/update-badge.sh` updates the count correctly when resources are added or removed.

---

## Phase 3: User Story 2 - Accurate Count Across All Sections (Priority: P2)

**Goal**: The badge count excludes `- ` lines inside fenced code blocks, ensuring only real resource entries are counted.

**Independent Test**: Add a `- ` line inside a fenced code block in README.md, run the script, and verify the count does NOT increase.

### Implementation for User Story 2

- [x] T005 [US2] Enhance counting logic in `scripts/update-badge.sh` — replace simple grep with awk that tracks fenced code block state (toggle on lines matching `` ``` ``), only counting `- ` lines when outside a code block
- [x] T006 [US2] Verify script accuracy by running `scripts/update-badge.sh` against README.md and comparing the output count to a manual count of resource entries

**Checkpoint**: Script correctly counts only `- ` lines outside fenced code blocks. Badge count in README.md is accurate.

---

## Phase 4: Polish & Cross-Cutting Concerns

**Purpose**: Final validation and documentation alignment

- [x] T007 Validate quickstart.md instructions by running each documented command from specs/001-resource-count-badge/quickstart.md and confirming output matches expectations

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies — can start immediately
- **User Story 1 (Phase 2)**: Depends on Setup (T001 creates `scripts/` directory)
- **User Story 2 (Phase 3)**: Depends on User Story 1 (T005 modifies script created in T003)
- **Polish (Phase 4)**: Depends on User Story 2 completion

### User Story Dependencies

- **User Story 1 (P1)**: Depends only on Phase 1 Setup — creates badge and script from scratch
- **User Story 2 (P2)**: Depends on US1 — enhances the script created in US1

### Within Each User Story

- T002 before T003 (badge must exist in README before script can update it)
- T003 before T004 (script must exist before it can be run)
- T005 before T006 (logic must be enhanced before verification)

### Parallel Opportunities

- T002 and T003 touch different files (README.md vs scripts/update-badge.sh) but T003's sed replacement targets the badge line inserted by T002, so they MUST be sequential

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup (T001)
2. Complete Phase 2: User Story 1 (T002 → T003 → T004)
3. **STOP and VALIDATE**: Badge displays correct count on GitHub
4. Merge if acceptable — code block exclusion (US2) can follow

### Incremental Delivery

1. T001 → directory ready
2. T002 → T003 → T004 → badge working with basic count (MVP)
3. T005 → T006 → code-block-aware counting (full accuracy)
4. T007 → documentation validated

---

## Notes

- All tasks are sequential for this feature (no parallelizable tasks)
- The script uses POSIX-compatible bash with grep, sed, and awk — no external dependencies
- Badge URL pattern: `https://img.shields.io/badge/resources-COUNT-blue`
- Commit after T004 (MVP) and again after T006 (full feature)
