# Research: Awesome Lint

**Feature**: 003-awesome-lint
**Date**: 2026-03-03

## R1: Current README Violations

**Finding**: Running `npx awesome-lint` against the current README produces 5 errors:

1. `awesome-badge` — Missing Awesome badge next to the main heading
2. `awesome-contributing` — Missing file contributing.md
3. `awesome-github` — Awesome list must reside in a valid git repository
4. `awesome-spell-check` — "github" should be "GitHub" (line 15, in `github/spec-kit` title)
5. `awesome-spell-check` — "git" should be "Git" (line 20, in `git ecosystem` description)

**Decision**: Fix all 5 violations directly rather than suppressing rules.

**Rationale**: Each violation has a straightforward fix. Suppressing rules would weaken the linter's value and leave real issues unaddressed.

## R2: Awesome Badge Handling

**Decision**: Add the standard Awesome badge alongside the existing Resources badge.

**Rationale**: The `awesome-badge` rule requires a badge linking to `https://awesome.re` next to the main heading. The project already has a custom Resources count badge. Both serve different purposes (community affiliation vs. count metric), so both should coexist. The Awesome badge signals that this list follows the awesome list community standards.

**Alternatives considered**:
- Suppress the `awesome-badge` rule: Defeats the purpose of adopting awesome-lint standards.
- Replace the Resources badge with the Awesome badge: Loses the resource count feature from 002-auto-resource-count.

## R3: Contributing.md Content

**Decision**: Create a minimal contributing.md with guidelines aligned to the project's constitution (Principles I–V) and Contribution Workflow section.

**Rationale**: The `awesome-contributing` rule requires a contributing.md file. The constitution already defines contribution standards, so contributing.md should reference and summarize those guidelines for contributors who may not read the constitution directly.

**Alternatives considered**:
- Suppress the `awesome-contributing` rule: Hides contribution guidelines from external contributors who expect them.
- Link to the constitution instead of creating contributing.md: awesome-lint requires the file to exist; a redirect-only file wouldn't satisfy the rule.

## R4: Repository Validation (`awesome-github` Rule)

**Decision**: Use `fetch-depth: 0` in the GitHub Actions checkout step to ensure the full git history is available for repository validation.

**Rationale**: The `awesome-github` rule validates that the repository is a legitimate git repository with history. Shallow clones (GitHub Actions default `fetch-depth: 1`) may cause this check to fail. Setting `fetch-depth: 0` provides the full clone needed for validation.

**Alternatives considered**:
- Suppress the `awesome-github` rule: Removes a useful validation that the list is maintained in a proper repository.
- Use a specific fetch-depth (e.g., 50): May not be sufficient for all checks the rule performs.

## R5: Spell Check Fixes

**Decision**: Fix the two spelling issues in README list entries by capitalizing "github" → "GitHub" and "git" → "Git" where they appear in entry descriptions.

**Rationale**: These are legitimate spelling corrections per the awesome-lint spell checker. "GitHub" and "Git" are proper nouns and should be capitalized.

**Details**:
- Line 15: `github/spec-kit` → `GitHub/spec-kit` (in the entry title)
- Line 20: `git ecosystem` → `Git ecosystem` (in the entry description)

## R6: Workflow Trigger Configuration

**Decision**: Trigger on `pull_request` targeting `main` branch with path filter on `README.md` and `contributing.md`.

**Rationale**: The linter only needs to run when list content changes. Filtering by path avoids unnecessary runs on PRs that only modify specs, scripts, or workflows. Including `contributing.md` ensures changes to that file are also linted contextually.

**Alternatives considered**:
- Trigger on all PRs (no path filter): Wastes CI minutes on irrelevant PRs.
- Trigger on push to main: Conflicts with the spec requirement (PRs only) and the update-badge workflow.
