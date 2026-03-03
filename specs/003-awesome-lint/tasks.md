# Tasks: Awesome Lint

**Input**: Design documents from `/specs/003-awesome-lint/`
**Prerequisites**: plan.md (required), spec.md (required), research.md

**Tests**: Not requested in the feature specification. No test tasks included.

**Organization**: Tasks are grouped by user story. US1 (workflow) and US2 (violation fixes) target different files and can be implemented in parallel.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2)
- Include exact file paths in descriptions

---

## Phase 1: User Story 1 - Lint Catches Formatting Issues on Pull Requests (Priority: P1)

**Goal**: Every pull request that modifies the README receives an automated awesome-lint check as a visible status check.

**Independent Test**: Open a PR with a malformed list entry and verify the lint check fails with specific error details.

### Implementation for User Story 1

- [x] T001 [P] [US1] Create GitHub Actions workflow file at `.github/workflows/awesome-lint.yml` with trigger: `on: pull_request` targeting `main` branch, path filter on `README.md` and `contributing.md` (per research decision R6)
- [x] T002 [US1] Add checkout step using `actions/checkout@v4` with `fetch-depth: 0` in `.github/workflows/awesome-lint.yml` (per research decision R4, required for `awesome-github` rule)
- [x] T003 [US1] Add Node.js setup step using `actions/setup-node@v4` in `.github/workflows/awesome-lint.yml`
- [x] T004 [US1] Add lint step running `npx awesome-lint` in `.github/workflows/awesome-lint.yml`

**Checkpoint**: Workflow file is complete — will run awesome-lint on PRs that touch README.md or contributing.md

---

## Phase 2: User Story 2 - README Conforms to Awesome List Standards (Priority: P2)

**Goal**: Fix all 5 existing awesome-lint violations so the linter passes cleanly from day one.

**Independent Test**: Run `npx awesome-lint` locally and verify zero errors are reported.

### Implementation for User Story 2

- [x] T005 [P] [US2] Create `contributing.md` at repository root with contribution guidelines aligned to the project constitution (Principles I–V and Contribution Workflow) to resolve the `awesome-contributing` rule violation (per research decision R3)
- [x] T006 [P] [US2] Add the standard Awesome badge (`[![Awesome](https://awesome.re/badge.svg)](https://awesome.re)`) to `README.md` next to the main heading, alongside the existing Resources badge, to resolve the `awesome-badge` rule violation (per research decision R2)
- [x] T007 [P] [US2] Fix spelling in `README.md` line 15: capitalize "github/spec-kit" to "GitHub/spec-kit" in the entry title to resolve the `awesome-spell-check` rule violation (per research decision R5)
- [x] T008 [P] [US2] Fix spelling in `README.md` line 20: capitalize "git ecosystem" to "Git ecosystem" in the entry description to resolve the `awesome-spell-check` rule violation (per research decision R5)
- [x] T009 [US2] Run `npx awesome-lint` locally to verify all 5 violations are resolved and zero errors remain

**Checkpoint**: `npx awesome-lint` returns 0 errors against the updated README

---

## Phase 3: Polish & Cross-Cutting Concerns

**Purpose**: End-to-end validation after merge

- [ ] T010 Verify the awesome-lint workflow triggers on a PR that modifies README.md and reports pass/fail as a status check
- [ ] T011 Verify the awesome-lint workflow does NOT trigger on a PR that only modifies non-README files

---

## Dependencies & Execution Order

### Phase Dependencies

- **User Story 1 (Phase 1)**: No dependencies — can start immediately
- **User Story 2 (Phase 2)**: No dependencies — can start immediately, runs in parallel with US1
- **Polish (Phase 3)**: Depends on both US1 and US2 being merged to `main`

### Cross-Story Dependencies

- US1 and US2 are **independent** — they modify different files and can be implemented in parallel
- Both must be complete before the feature works end-to-end (the workflow needs a clean README to pass)

### Within User Story 1

Tasks T001–T004 are sequential edits to the same file (`.github/workflows/awesome-lint.yml`). They will be implemented as a single file in one pass.

### Within User Story 2

- T005, T006, T007, T008 are all `[P]` — they modify different files or different lines and can run in parallel
- T009 depends on T005–T008 (must run after all fixes are applied)

### Parallel Opportunities

- US1 (T001–T004) and US2 (T005–T008) can run fully in parallel — different files
- Within US2: T005 (contributing.md), T006 (badge), T007 (spelling fix 1), T008 (spelling fix 2) — all parallelizable

---

## Parallel Example: Full Feature

```bash
# US1 and US2 can run in parallel:

# US1 (workflow file):
Task T001-T004: "Create .github/workflows/awesome-lint.yml"

# US2 (violation fixes, all parallel):
Task T005: "Create contributing.md"
Task T006: "Add Awesome badge to README.md"
Task T007: "Fix 'github' → 'GitHub' in README.md"
Task T008: "Fix 'git' → 'Git' in README.md"

# Then sequentially:
Task T009: "Verify npx awesome-lint passes"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Create workflow (T001–T004)
2. **Note**: The workflow will fail on PRs until US2 fixes are also merged

### Full Feature (Recommended)

1. Implement US1 (T001–T004) and US2 (T005–T008) in parallel
2. Verify locally (T009)
3. Merge both together so the first PR after merge gets a clean lint check
4. Validate end-to-end (T010–T011)

### Practical Note

Tasks T001–T004 target the same workflow file and will be written as a single file in one pass. Tasks T006–T008 are small edits to README.md that can be done in one editing session. The task breakdown exists for traceability to spec requirements and research decisions.

---

## Notes

- No test tasks included (not requested in spec)
- T001–T004 target the same file — implement as one logical unit
- T006–T008 all modify README.md — implement together to avoid merge conflicts
- `fetch-depth: 0` in T002 is critical for the `awesome-github` rule
- Phase 3 (Polish) requires the branch to be merged to `main` and a test PR opened
- Total scope: 1 new workflow, 1 new contributing.md, README fixes (badge + 2 spelling)
