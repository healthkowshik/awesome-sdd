# Tasks: Automatic Resource Count

**Input**: Design documents from `/specs/002-auto-resource-count/`
**Prerequisites**: plan.md (required), spec.md (required), research.md, data-model.md

**Tests**: Not requested in the feature specification. No test tasks included.

**Organization**: Tasks are grouped by phase. This feature has a single user story (US1) and a small scope (2 files).

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1)
- Include exact file paths in descriptions

---

## Phase 1: Setup

**Purpose**: Create the directory structure needed for the GitHub Actions workflow

- [x] T001 [P] Create `.github/workflows/` directory at repository root

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Fix the existing script to work on Linux (GitHub Actions runners) before the workflow can call it

**CRITICAL**: The workflow (Phase 3) calls this script, so it must work on Ubuntu Linux first

- [x] T002 [P] Fix sed portability in `scripts/update-badge.sh` — replace `sed -i ''` with `sed -i.bak` followed by `rm "$README.bak"` so the script works on both macOS (BSD sed) and Linux (GNU sed)

**Checkpoint**: `scripts/update-badge.sh` runs correctly on both macOS and Linux

---

## Phase 3: User Story 1 - Resource Count Stays Accurate After Edits (Priority: P1) MVP

**Goal**: When a contributor pushes a README change to `main`, a GitHub Actions workflow automatically detects badge count mismatches and commits the fix.

**Independent Test**: Add a resource line to README.md, push to `main`, and verify a follow-up auto-commit updates the badge count within ~30 seconds.

### Implementation for User Story 1

- [x] T003 [US1] Create GitHub Actions workflow file at `.github/workflows/update-badge.yml` with trigger configuration: `on: push` to `main` branch, path filter on `README.md` (per research decision R4)
- [x] T004 [US1] Add checkout step using `actions/checkout@v4` in `.github/workflows/update-badge.yml`
- [x] T005 [US1] Add step to run `scripts/update-badge.sh` and capture output in `.github/workflows/update-badge.yml`
- [x] T006 [US1] Add step to check for changes using `git diff --quiet README.md` in `.github/workflows/update-badge.yml`
- [x] T007 [US1] Add auto-commit step in `.github/workflows/update-badge.yml` — configure git user as `github-actions[bot]` with email `github-actions[bot]@users.noreply.github.com`, commit message includes `[skip ci]` to prevent infinite loops (per research decisions R2, R3)
- [x] T008 [US1] Add `git push` step in `.github/workflows/update-badge.yml`, conditional on changes detected in T006

**Checkpoint**: User Story 1 is fully functional — pushing a README change to `main` triggers the workflow which auto-fixes the badge count

---

## Phase 4: Polish & Cross-Cutting Concerns

**Purpose**: Validation and documentation

- [x] T009 Run quickstart.md validation — verify end-to-end by adding a test resource, pushing, and confirming auto-commit appears *(verified: workflow run 22600418391 updated badge 11→12)*
- [x] T010 Verify no-op behavior — push a README change that doesn't affect resource count and confirm no auto-commit is created *(verified: commit 6081387 did not touch README.md, workflow correctly skipped via path filter)*

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies — can start immediately
- **Foundational (Phase 2)**: No dependency on Phase 1 (different file), but logically ordered first
- **User Story 1 (Phase 3)**: Depends on Phase 1 (directory must exist) and Phase 2 (script must be portable)
- **Polish (Phase 4)**: Depends on Phase 3 completion — requires pushing to `main` on GitHub

### Within User Story 1

Tasks T003–T008 are sequential edits to the same file (`.github/workflows/update-badge.yml`). They build on each other and cannot be parallelized. However, they can be implemented as a single workflow file in one pass.

### Parallel Opportunities

- T001 (create directory) and T002 (fix script) can run in parallel — different files, no dependencies

---

## Parallel Example: Setup + Foundational

```bash
# These can run in parallel (different files):
Task T001: "Create .github/workflows/ directory"
Task T002: "Fix sed portability in scripts/update-badge.sh"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Create directory (T001)
2. Complete Phase 2: Fix script portability (T002)
3. Complete Phase 3: Create workflow (T003–T008)
4. **STOP and VALIDATE**: Push a README change to `main` and verify auto-commit
5. Complete Phase 4: Polish validation (T009–T010)

This feature has only one user story, so MVP = complete feature.

### Practical Note

Tasks T003–T008 describe incremental steps for building the workflow file, but in practice they will be implemented as a single `.github/workflows/update-badge.yml` file written in one pass. The task breakdown exists for traceability to spec requirements, not to suggest six separate commits.

---

## Notes

- No test tasks included (not requested in spec)
- T003–T008 target the same file — implement as one logical unit
- The `[skip ci]` in the auto-commit message (T007) is critical to prevent infinite workflow loops
- Phase 4 (Polish) requires the branch to be merged to `main` and pushed to GitHub to validate end-to-end
- Total scope: 1 new file, 1 modified file
