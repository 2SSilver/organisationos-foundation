#!/usr/bin/env bash
# Tests for banned-scan.sh. Run: bash .github/scripts/banned-scan.test.sh
# Exit 0 = all pass. Used by self-ci.yml so the check that guards confidentiality
# is itself guarded.
set -u
SCRIPT="$(dirname "$0")/banned-scan.sh"
tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT
pass=0; fail=0

check() { # check <name> <expected-exit> <patterns-file> <file>...
  local name="$1" want="$2"; shift 2
  local pf="$1"; shift
  bash "$SCRIPT" "$pf" "$@" >/dev/null 2>&1; local got=$?
  if [ "$got" -eq "$want" ]; then pass=$((pass+1)); echo "  PASS  $name"
  else fail=$((fail+1)); echo "  FAIL  $name (want exit $want, got $got)"; fi
}

cat > "$tmp/patterns.yml" <<'YML'
- pattern: ExampleClientName
- pattern: "Jane Smith"
- pattern: "ACME-\\d{4}"
- !context-near
  a: "retail bank"
  b: "Stockholm"
  window: 100
YML

printf 'nothing to see here\n' > "$tmp/clean.md"
printf 'we worked with ExampleClientName last year\n' > "$tmp/plain.md"
printf 'the lead was Jane Smith, based in Oslo\n' > "$tmp/multiword.md"
printf 'Jane went to the shops. Smith is a common surname.\n' > "$tmp/halves.md"
printf 'a retail bank in Stockholm engaged us\n' > "$tmp/cooc-near.md"
{ printf 'a retail bank engaged us.\n'; for i in $(seq 1 200); do printf 'filler '; done; printf '\nlater, Stockholm hosted the summit.\n'; } > "$tmp/cooc-far.md"
printf 'project ACME-1234 shipped\n' > "$tmp/regex.md"

echo "banned-scan tests:"
check "clean file passes"                       0 "$tmp/patterns.yml" "$tmp/clean.md"
check "plain pattern is caught"                 1 "$tmp/patterns.yml" "$tmp/plain.md"
check "regex pattern is caught"                 1 "$tmp/patterns.yml" "$tmp/regex.md"
check "multi-word pattern is caught"            1 "$tmp/patterns.yml" "$tmp/multiword.md"
check "halves of a multi-word pattern pass"     0 "$tmp/patterns.yml" "$tmp/halves.md"
check "co-occurrence within window is caught"   1 "$tmp/patterns.yml" "$tmp/cooc-near.md"
check "co-occurrence beyond window passes"      0 "$tmp/patterns.yml" "$tmp/cooc-far.md"

echo "  $pass passed, $fail failed"
[ "$fail" -eq 0 ]
