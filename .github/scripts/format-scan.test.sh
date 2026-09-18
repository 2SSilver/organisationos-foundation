#!/usr/bin/env bash
# Tests for format-scan.sh. Run: bash .github/scripts/format-scan.test.sh
# Exit 0 = all pass. Used by self-ci.yml so the gate that decides what may enter
# Git is itself tested — the extension parser shipped broken for the eight
# settings-example files across the three repos and no test would have caught it.
set -u
SCRIPT="$(cd "$(dirname "$0")" && pwd)/format-scan.sh"
ALLOWED="md txt csv tsv json jsonc yaml yml toml html svg png pdf excalidraw drawio"
tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT
pass=0; fail=0

check() { # check <name> <expected-exit> <file>...
  local name="$1" want="$2"; shift 2
  ( cd "$tmp" && bash "$SCRIPT" "$ALLOWED" "$@" ) >/dev/null 2>&1; local got=$?
  if [ "$got" -eq "$want" ]; then pass=$((pass+1)); echo "  PASS  $name"
  else fail=$((fail+1)); echo "  FAIL  $name (want exit $want, got $got)"; fi
}

# The eight real filenames that the shipped parser rejected.
mkdir -p "$tmp/.claude" "$tmp/standards/templates/onboarding"
printf '{}\n' > "$tmp/.claude/settings.local.json.example"
for r in admin domain-lead leader product-owner team-member; do
  printf '{}\n' > "$tmp/standards/templates/onboarding/settings.local.json.example-$r"
done

# Ordinary accepted and rejected files.
printf 'text\n' > "$tmp/notes.md"
printf 'binary-ish\n' > "$tmp/tool.exe"
printf 'owners\n' > "$tmp/CODEOWNERS"
mkdir -p "$tmp/.github/hooks" "$tmp/.github/scripts"
printf 'hook\n' > "$tmp/.github/hooks/pre-commit"
printf 'script\n' > "$tmp/.github/scripts/helper.sh"

# A .svg over its 200 KB cap, and one under it.
head -c 210000 /dev/zero | tr '\0' 'x' > "$tmp/big.svg"
printf '<svg/>\n' > "$tmp/small.svg"

# A file whose name contains .example but is not a settings example.
printf 'text\n' > "$tmp/guide.example.md"

echo "format-scan tests:"
check "whitelisted extension passes"                 0 "notes.md"
check "non-whitelisted extension is caught"          1 "tool.exe"
check "CODEOWNERS is exempt by name"                 0 "CODEOWNERS"
check ".github/hooks/ is exempt by path"             0 ".github/hooks/pre-commit"
check ".github/scripts/ is exempt by path"           0 ".github/scripts/helper.sh"
check "settings.local.json.example resolves to json" 0 ".claude/settings.local.json.example"
check "example-admin resolves to json"               0 "standards/templates/onboarding/settings.local.json.example-admin"
check "example-domain-lead resolves to json"         0 "standards/templates/onboarding/settings.local.json.example-domain-lead"
check "example-leader resolves to json"              0 "standards/templates/onboarding/settings.local.json.example-leader"
check "example-product-owner resolves to json"       0 "standards/templates/onboarding/settings.local.json.example-product-owner"
check "example-team-member resolves to json"         0 "standards/templates/onboarding/settings.local.json.example-team-member"
check "all eight together pass"                      0 ".claude/settings.local.json.example" \
  "standards/templates/onboarding/settings.local.json.example-admin" \
  "standards/templates/onboarding/settings.local.json.example-domain-lead" \
  "standards/templates/onboarding/settings.local.json.example-leader" \
  "standards/templates/onboarding/settings.local.json.example-product-owner" \
  "standards/templates/onboarding/settings.local.json.example-team-member"
check "a .example.md file stays .md"                 0 "guide.example.md"
check "svg over its cap is caught"                   1 "big.svg"
check "svg under its cap passes"                     0 "small.svg"
check "one bad file among good ones fails"           1 "notes.md" "tool.exe"
check "no files passes"                              0

echo "  $pass passed, $fail failed"
[ "$fail" -eq 0 ]
