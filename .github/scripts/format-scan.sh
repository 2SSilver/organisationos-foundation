#!/usr/bin/env bash
# format-scan.sh <allowed-extensions> <file>...
#
# The single implementation of the FORMATS.md whitelist and size-cap scan.
# format-gate.yml calls it; .github/scripts/format-scan.test.sh tests it.
#
# <allowed-extensions> is one space-separated string, passed in by the caller so
# the FORMATS.md drift check in format-gate.yml stays the single source of that
# list. Callers decide WHICH files to scan; this script scans what it is given.
# Exit 0 = clean, 1 = at least one violation.
set -u

allowed_extensions="$1"; shift
[ $# -gt 0 ] || exit 0
fail=0
aggregate_bytes=0
per_pr_cap_mb=10

for f in "$@"; do
  [ -f "$f" ] || continue
  base="${f##*/}"

  # Allow files without extensions (e.g. CODEOWNERS, .gitignore, .lycheeignore
  # handled by name)
  case "$base" in
    CODEOWNERS|.gitignore|.gitkeep|.lycheeignore) continue ;;
  esac

  # Harness machinery under .github/ — hooks and the CI scripts the workflows
  # call. FORMATS.md governs content formats; these are not content, so they are
  # exempt by path rather than by extension.
  case "$f" in .github/hooks/*) continue ;; esac
  case "$f" in .github/scripts/*) continue ;; esac

  # Shipped example files carry the role after the .example segment
  # (settings.local.json.example-admin). Strip that segment before deriving the
  # extension, so the file is checked as the .json it is and keeps its size cap.
  # Anchored at the end, and the role suffix may not contain a dot, so an
  # ordinary name like guide.example.md is untouched.
  if [[ "$base" =~ ^(.+)\.example(-[A-Za-z0-9-]+)?$ ]]; then
    stem="${BASH_REMATCH[1]}"
  else
    stem="$base"
  fi
  ext="${stem##*.}"

  if ! echo "$allowed_extensions" | grep -wq "$ext"; then
    echo "::error file=$f::extension '.$ext' is not on FORMATS.md's whitelist."
    echo "The harness keeps non-whitelisted files outside Git. Add a reference in the relevant domain's references.md with the URL where this file lives, or remove the file from the PR. See FORMATS.md."
    fail=1
    continue
  fi

  # Per-format size caps
  size=$(stat -c%s "$f" 2>/dev/null || stat -f%z "$f")
  aggregate_bytes=$((aggregate_bytes + size))
  cap=0
  case "$ext" in
    svg) cap=204800 ;;        # 200 KB
    png|pdf) cap=2097152 ;;   # 2 MB
    excalidraw|drawio) cap=512000 ;;  # 500 KB
  esac
  if [ "$cap" -gt 0 ] && [ "$size" -gt "$cap" ]; then
    echo "::error file=$f::binary exceeds the per-format size cap for .$ext (cap: $cap bytes, file: $size bytes). See FORMATS.md."
    fail=1
  fi
done

# Per-PR aggregate cap
aggregate_mb=$((aggregate_bytes / 1048576))
if [ "$aggregate_mb" -gt "$per_pr_cap_mb" ]; then
  echo "::error::PR introduces ${aggregate_mb}MB of new content (cap: ${per_pr_cap_mb}MB). Split this PR."
  fail=1
fi

exit $fail
