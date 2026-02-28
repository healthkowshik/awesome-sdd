<!--
  Sync Impact Report
  ==================
  Version change: (none) → 1.0.0 (initial ratification)

  Added principles:
    - I. Curation Quality
    - II. Consistent Formatting
    - III. Organized Categories
    - IV. Link Verification
    - V. Community Value

  Added sections:
    - Content Standards
    - Contribution Workflow
    - Governance

  Removed sections: (none)

  Templates requiring updates:
    - .specify/templates/plan-template.md        ✅ no changes needed
    - .specify/templates/spec-template.md         ✅ no changes needed
    - .specify/templates/tasks-template.md        ✅ no changes needed
    - .specify/templates/commands/*.md            ✅ no command files exist

  Follow-up TODOs: (none)
-->

# Awesome SDD Constitution

## Core Principles

### I. Curation Quality

Every entry in this list MUST meet a minimum quality bar before inclusion:

- The linked resource MUST be directly relevant to Spec-Driven Development
  (SDD) as a practice, methodology, or tooling category.
- The resource MUST originate from a credible source (established blog,
  conference talk, recognized open-source project, or peer-reviewed venue).
- Tools MUST have a public repository or landing page with clear documentation.
- Articles and videos MUST provide substantive content — link-bait, thinly
  veiled advertisements, or superficial overviews do not qualify.

**Rationale**: A curated list derives its value from selectivity. Lowering the
quality bar erodes trust and dilutes the list's usefulness.

### II. Consistent Formatting

All entries MUST follow a uniform format to ensure scannability:

- Each entry MUST use the pattern:
  `- [Title](URL)` optionally followed by ` - Description`.
- Descriptions, when present, MUST be a single sentence fragment (no trailing
  period) that conveys what the resource is or does.
- Section headings MUST use `##` level headings in the README.
- Entries within a section MUST be sorted alphabetically by title unless a
  different ordering is explicitly justified in the section.

**Rationale**: Consistency reduces cognitive load for readers scanning the list
and makes automated linting feasible.

### III. Organized Categories

Resources MUST be placed in the correct category section:

- The README MUST maintain distinct sections for resource types (e.g.,
  Articles, Tooling, Videos).
- New categories MAY be added when three or more entries justify a standalone
  section.
- An entry MUST NOT appear in multiple categories; choose the most specific
  one.
- Categories MUST be ordered logically (Articles before Tooling before Videos)
  unless the project explicitly adopts a different canonical order.

**Rationale**: Clear categorization helps users find what they need without
scrolling the entire document.

### IV. Link Verification

All links in the list MUST resolve to live, accessible content:

- Every URL MUST be checked for a 2xx HTTP response before merging.
- Paywalled content MAY be included only if clearly labeled (e.g., appending
  `(paywall)` to the description).
- Links that return 404 or redirect to unrelated content MUST be removed or
  updated promptly.
- Periodic link audits SHOULD be performed (manually or via CI) at least
  quarterly.

**Rationale**: Broken links undermine credibility and frustrate users who
follow them.

### V. Community Value

Every change to the list MUST demonstrably benefit practitioners interested
in Spec-Driven Development:

- Additions MUST help someone discover, learn, or adopt SDD practices or
  tooling.
- Self-promotional entries MUST meet the same quality bar as any other entry;
  affiliation MUST be disclosed if the contributor is the author.
- Duplicate coverage of the same topic is acceptable only when the new entry
  offers a materially different perspective or depth.

**Rationale**: The list exists to serve the SDD community, not individual
contributors' marketing goals.

## Content Standards

Entries are evaluated against the following inclusion criteria:

- **Articles**: MUST explain, analyze, or advance SDD concepts. Opinion pieces
  are acceptable if they provide actionable insight.
- **Tooling**: MUST be publicly available (open-source preferred). Proprietary
  tools are allowed if they offer a free tier or trial and are clearly labeled.
- **Videos**: MUST be freely accessible (conference talks, YouTube, etc.).
  Behind-paywall video courses MUST be labeled accordingly.
- **Other categories**: Any new category MUST be proposed with at least three
  qualifying entries and a clear rationale for why the existing categories do
  not suffice.

Entries that no longer meet these standards (e.g., a tool that goes offline
or an article that is retracted) MUST be removed during the next maintenance
pass.

## Contribution Workflow

All changes to the curated list follow this process:

1. **Propose**: Open a pull request adding or modifying entries.
2. **Verify**: Ensure all links resolve and formatting matches the standard
   defined in Principle II.
3. **Review**: At least one maintainer MUST review the PR for quality, relevance,
   and formatting compliance.
4. **Merge**: Once approved, the PR is merged into the main branch.

For bulk updates (e.g., quarterly link audits), a single PR covering all
fixes is acceptable.

## Governance

This constitution is the authoritative reference for all curation decisions
in the awesome-sdd project. It supersedes informal conventions or ad-hoc
practices.

- **Amendments**: Any change to this constitution MUST be proposed via pull
  request, reviewed by a maintainer, and documented with a version bump.
- **Versioning**: The constitution follows semantic versioning:
  - MAJOR: Removal or redefinition of a core principle.
  - MINOR: Addition of a new principle or material expansion of guidance.
  - PATCH: Clarifications, wording fixes, or non-semantic refinements.
- **Compliance**: All pull requests SHOULD be checked against these principles
  during review. Reviewers MAY reference specific principle numbers when
  requesting changes.

**Version**: 1.0.0 | **Ratified**: 2026-02-28 | **Last Amended**: 2026-02-28
