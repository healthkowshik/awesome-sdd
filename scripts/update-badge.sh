#!/usr/bin/env bash
set -euo pipefail

# Navigate to repository root (parent of scripts/)
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
README="$REPO_ROOT/README.md"

if [ ! -f "$README" ]; then
  echo "ERROR: README.md not found at $README" >&2
  exit 1
fi

# Count resource entries: lines starting with "- " (outside fenced code blocks)
NEW_COUNT=$(awk '
  /^```/ { in_code = !in_code; next }
  !in_code && /^- / { count++ }
  END { print count+0 }
' "$README")

# Extract current badge count from the shields.io URL
OLD_COUNT=$(grep -oE 'img\.shields\.io/badge/resources-[0-9]+-blue' "$README" \
  | grep -oE '[0-9]+' | head -1)

if [ -z "$OLD_COUNT" ]; then
  echo "ERROR: Badge not found in README.md" >&2
  echo "Expected pattern: img.shields.io/badge/resources-<count>-blue" >&2
  exit 1
fi

echo "Old count: $OLD_COUNT"
echo "New count: $NEW_COUNT"

if [ "$OLD_COUNT" = "$NEW_COUNT" ]; then
  echo "Badge is already up to date."
  exit 0
fi

# Update the badge count in-place
sed -i '' "s|img\.shields\.io/badge/resources-${OLD_COUNT}-blue|img.shields.io/badge/resources-${NEW_COUNT}-blue|" "$README"

echo "Badge updated: $OLD_COUNT -> $NEW_COUNT"
