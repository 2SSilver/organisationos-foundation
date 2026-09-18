#!/usr/bin/env bash
# Tests for setup-check.sh. Run: bash .github/scripts/setup-check.test.sh
# Exit 0 = all pass. Used by self-ci.yml. setup-check.sh gates nothing in an
# adopter's org — nothing compels them to run it — so its own correctness is the
# only thing that can be enforced here, and this is where that happens.
set -u
SCRIPT="$(cd "$(dirname "$0")" && pwd)/setup-check.sh"
pass=0; fail=0

check() { # check <name> <expected-exit> <parent-dir>
  local name="$1" want="$2" dir="$3"
  bash "$SCRIPT" "$dir" >/dev/null 2>&1; local got=$?
  if [ "$got" -eq "$want" ]; then pass=$((pass+1)); echo "  PASS  $name"
  else fail=$((fail+1)); echo "  FAIL  $name (want exit $want, got $got)"; fi
}

# build_org <dir> <org-token> <marketplace-ref> <plugin-version> <codeowner> <make-tag>
build_org() {
  local d="$1" org="$2" ref="$3" ver="$4" owner="$5" tag="$6"
  rm -rf "$d"; mkdir -p "$d"
  for r in foundation leadership domain; do
    local repo="$d/organisationos-$r"
    mkdir -p "$repo/.github" "$repo/.claude"
    git init -q "$repo"
    printf 'uses: %s/organisationos-foundation/.github/workflows/format-gate.yml@v1\n' "$org" > "$repo/.github/workflows-sample.yml"
    printf '%s\n' "$owner" > "$repo/.github/CODEOWNERS"
    printf '{"marketplaces":[{"ref":"%s"}],"plugins":{"superpowers":{"version":"%s"}}}\n' "$ref" "$ver" > "$repo/.claude/settings.json"
    git -C "$repo" add -A >/dev/null 2>&1
    git -C "$repo" -c user.email=t@t -c user.name=t commit -qm init >/dev/null 2>&1
  done
  if [ "$tag" = "tag" ]; then
    git -C "$d/organisationos-foundation" tag v1 >/dev/null 2>&1
  fi
}

tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT
SHA="a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2"

build_org "$tmp/good"       "acme-corp"     "$SHA"                            "2.1.0"                    "@real-admin"        "tag"
build_org "$tmp/no-tag"     "acme-corp"     "$SHA"                            "2.1.0"                    "@real-admin"        "notag"
build_org "$tmp/org-left"   "<adopter-org>" "$SHA"                            "2.1.0"                    "@real-admin"        "tag"
build_org "$tmp/ref-left"   "acme-corp"     "REPLACE-WITH-AUDITED-COMMIT-SHA" "2.1.0"                    "@real-admin"        "tag"
build_org "$tmp/ver-left"   "acme-corp"     "$SHA"                            "<pinned-version-or-ref>"  "@real-admin"        "tag"
build_org "$tmp/owner-left" "acme-corp"     "$SHA"                            "2.1.0"                    "@placeholder-admin" "tag"

echo "setup-check tests:"
check "a fully substituted, tagged org passes"  0 "$tmp/good"
check "missing v1 tag is caught"                1 "$tmp/no-tag"
check "leftover <adopter-org> is caught"        1 "$tmp/org-left"
check "leftover marketplace ref is caught"      1 "$tmp/ref-left"
check "leftover plugin version is caught"       1 "$tmp/ver-left"
check "leftover placeholder- owner is caught"   1 "$tmp/owner-left"
check "a missing repo directory is caught"      1 "$tmp/does-not-exist"

echo "  $pass passed, $fail failed"
[ "$fail" -eq 0 ]
