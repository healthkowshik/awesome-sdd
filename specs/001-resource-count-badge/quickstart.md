# Quickstart: Resource Count Badge

**Feature**: 001-resource-count-badge

## Overview

The README displays a badge showing the total number of curated resources.
A script keeps the badge count accurate.

## Viewing the Badge

Open the README on GitHub. The badge appears between the tagline and the
first section heading, displaying a label ("resources") and a number.

## Updating the Badge Count

After adding or removing resource entries in the README, run:

```bash
./scripts/update-badge.sh
```

The script:
1. Counts all lines starting with `- ` (outside fenced code blocks)
2. Updates the badge URL in the README with the new count
3. Prints the old and new count for verification

Then commit the updated README.

## Verifying the Count

To manually verify the count matches:

```bash
# Quick check (does not exclude code blocks):
grep -c '^- ' README.md

# The script handles code block exclusion automatically.
```

## How It Works

The badge is a shields.io static image:

```markdown
![Resources](https://img.shields.io/badge/resources-9-blue)
```

The number in the URL (`9` in this example) is the count. The script
replaces this number with the current count each time it runs.
