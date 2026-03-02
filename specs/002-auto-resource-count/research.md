# Research: Automatic Resource Count

**Feature**: 002-auto-resource-count
**Date**: 2026-03-02

## R1: sed Portability (macOS vs Linux)

**Decision**: Use `sed -i.bak` followed by `rm` of the backup file for cross-platform compatibility.

**Rationale**: The existing script uses `sed -i ''` which is macOS (BSD sed) syntax. GitHub Actions runners use Ubuntu Linux (GNU sed), where the equivalent is `sed -i` (no empty string argument). Using `sed -i.bak` works on both BSD and GNU sed, and the `.bak` file can be removed immediately after.

**Alternatives considered**:
- OS detection (`if [[ "$OSTYPE" == "darwin"* ]]`): Works but adds branching complexity for a one-liner fix.
- Inline replacement in workflow YAML (avoid calling the script): Duplicates logic, harder to maintain.
- Use `perl -pi -e` instead of sed: Adds a dependency, not needed for this simple case.

## R2: Preventing Infinite Workflow Loops

**Decision**: Use `[skip ci]` in the auto-commit message to prevent the workflow from re-triggering on its own commit.

**Rationale**: When the workflow pushes an auto-commit, that push event would normally re-trigger the same workflow, creating an infinite loop. GitHub Actions respects `[skip ci]` in commit messages to suppress workflow runs. This is the standard, well-documented approach.

**Alternatives considered**:
- Path filter on the workflow trigger (only run when README.md changes): Insufficient alone — the auto-commit also changes README.md.
- Use a GitHub App token with limited permissions: Over-engineered for this use case.
- Check if the last commit was made by the bot: Adds fragile logic; `[skip ci]` is simpler and universally understood.

## R3: Git Commit Identity for Auto-Commits

**Decision**: Use `github-actions[bot]` as the commit author with GitHub's standard bot email.

**Rationale**: This is the conventional identity for GitHub Actions automated commits. It clearly signals the commit was machine-generated, doesn't impersonate a human contributor, and requires no PAT or special token setup — the default `GITHUB_TOKEN` is sufficient.

**Alternatives considered**:
- Use a dedicated bot account: Requires creating and managing a separate GitHub account with a PAT.
- Use the pushing user's identity: Misleading — the auto-commit isn't their work.

## R4: Workflow Trigger Configuration

**Decision**: Trigger on `push` to `main` branch with a path filter on `README.md`.

**Rationale**: The badge only needs updating when `README.md` changes. Path filtering avoids unnecessary workflow runs on pushes that don't touch the README (e.g., spec changes, script edits). Combined with `[skip ci]` on auto-commits, this gives precise triggering.

**Alternatives considered**:
- Trigger on all pushes to `main` (no path filter): Wastes CI minutes on irrelevant pushes.
- Trigger on `workflow_dispatch` only: Defeats the "automatic" requirement.
