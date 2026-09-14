#!/usr/bin/env bash
# banned-scan.sh <patterns-file> <file>...
#
# The single implementation of the banned-string scan. Both enforcement points
# call it — banned-string-check.yml (the gate) and banned-string-pre-commit (the
# local convenience) — so the two cannot drift apart again.
#
# Callers decide WHICH files to scan; this script scans exactly what it is given.
# Exit 0 = clean, 1 = at least one violation.
set -u

patterns_file="$1"; shift
[ $# -gt 0 ] || exit 0
fail=0

# --- literal and regex patterns -------------------------------------------
# Read line by line: a pattern may contain spaces, and word-splitting would
# silently scan each word as its own pattern.
patterns=$(yq '.[] | select(has("pattern")) | .pattern' "$patterns_file")
while IFS= read -r p; do
  [ -z "$p" ] && continue
  for f in "$@"; do
    [ -f "$f" ] || continue
    if rg -qi "\b${p}\b" "$f"; then
      echo "$f matches banned pattern '$p'"
      fail=1
    fi
  done
done <<< "$patterns"

# --- !context-near co-occurrence directives --------------------------------
# Fails when both strings appear within `window` tokens of each other. Selected
# on the YAML tag itself, so an entry declaring the directive is never silently
# skipped for lacking a `pattern:` key.
cooc_awk='
BEGIN { na = 0; nb = 0; nt = 0 }
{
  line = tolower($0)
  gsub(/[^a-z0-9]+/, " ", line)
  n = split(line, w, " ")
  for (i = 1; i <= n; i++) if (w[i] != "") t[++nt] = w[i]
}
END {
  la = split(A, aa, " ")
  lb = split(B, bb, " ")
  for (i = 1; i <= nt; i++) {
    ok = 1
    for (j = 1; j <= la; j++) if (t[i + j - 1] != aa[j]) { ok = 0; break }
    if (ok) pa[++na] = i
    ok = 1
    for (j = 1; j <= lb; j++) if (t[i + j - 1] != bb[j]) { ok = 0; break }
    if (ok) pb[++nb] = i
  }
  for (x = 1; x <= na; x++) for (y = 1; y <= nb; y++) {
    d = pa[x] - pb[y]; if (d < 0) d = -d
    if (d <= W) exit 0
  }
  exit 1
}'

normalise() { printf '%s' "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]\{1,\}/ /g; s/^ //; s/ $//'; }

cooc=$(yq '.[] | select(tag == "!context-near") | [.a, .b, .window] | @tsv' "$patterns_file")
while IFS=$'\t' read -r a b window; do
  [ -z "${a:-}" ] && continue
  [ -z "${window:-}" ] || [ "${window:-}" = "null" ] && window=100
  na=$(normalise "$a"); nb=$(normalise "$b")
  for f in "$@"; do
    [ -f "$f" ] || continue
    if awk -v A="$na" -v B="$nb" -v W="$window" "$cooc_awk" "$f"; then
      echo "$f matches co-occurrence directive '$a' near '$b' (within $window tokens)"
      fail=1
    fi
  done
done <<< "$cooc"

exit $fail
