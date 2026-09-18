#!/usr/bin/env bash
# setup-check.sh [parent-dir]
#
# Verifies the four things docs/setup-org.md must leave true, in an adopter's
# own clone set. Run it as the last step of setup, from the directory holding
# the three repos as siblings (parent-dir defaults to the current directory).
#
# This runs where the placeholders should be gone. It is deliberately NOT a CI
# job: in the template repos the placeholders must remain, so an in-repo gate
# would either be permanently red or be exempted into something that cannot
# fail where it lives.
#
# Filesystem reads and `git tag` only — no network, no gh, no auth.
# Exit 0 = every check passed, 1 = at least one failed.
set -u

root="${1:-.}"
repos="organisationos-foundation organisationos-leadership organisationos-domain"
fail=0

say_fail() { echo "  FAIL  $1"; fail=1; }
say_pass() { echo "  PASS  $1"; }

echo "OrganisationOS setup check — $root"

# --- 0. the three repos are where the harness expects them -----------------
missing=""
for r in $repos; do
  [ -d "$root/$r" ] || missing="$missing $r"
done
if [ -n "$missing" ]; then
  say_fail "missing repo directories:$missing"
  echo "The three repos must be siblings in one directory. See docs/setup-org.md Step 2."
  echo "  1 check failed"
  exit 1
fi
say_pass "all three repos present as siblings"

# --- 1. Step 3's adopter-org sweep actually ran ----------------------------
hits=0
for r in $repos; do
  n=$(grep -rl '<adopter-org>' "$root/$r" --exclude-dir=.git 2>/dev/null | wc -l | tr -d ' ')
  hits=$((hits + n))
done
if [ "$hits" -gt 0 ]; then
  say_fail "$hits file(s) still carry <adopter-org> — re-run docs/setup-org.md Step 3"
else
  say_pass "no <adopter-org> placeholders remain"
fi

# --- 2. the supply-chain pins were chosen ----------------------------------
pins=0
for r in $repos; do
  f="$root/$r/.claude/settings.json"
  [ -f "$f" ] || continue
  n=$(grep -l -e 'REPLACE-WITH-AUDITED-COMMIT-SHA' -e '<pinned-version-or-ref>' "$f" 2>/dev/null | wc -l | tr -d ' ')
  pins=$((pins + n))
done
if [ "$pins" -gt 0 ]; then
  say_fail "$pins file(s) still carry an unsubstituted supply-chain pin — see docs/setup-org.md Step 3"
else
  say_pass "marketplace ref and plugin version are pinned"
fi

# --- 3. CODEOWNERS names real handles --------------------------------------
owners=0
for r in $repos; do
  f="$root/$r/.github/CODEOWNERS"
  [ -f "$f" ] || continue
  n=$(grep -c 'placeholder-' "$f" 2>/dev/null || true)
  owners=$((owners + n))
done
if [ "$owners" -gt 0 ]; then
  say_fail "$owners CODEOWNERS line(s) still name a placeholder handle — see docs/setup-org.md Step 4"
else
  say_pass "CODEOWNERS names real handles"
fi

# --- 4. Foundation carries the v1 tag every caller pins --------------------
# gh repo create --template copies no tags, so a fresh Foundation has none and
# all 21 Leadership and Domain callers fail on their first run.
if [ -z "$(git -C "$root/organisationos-foundation" tag -l v1 2>/dev/null)" ]; then
  say_fail "Foundation has no v1 tag — every Leadership and Domain workflow pins @v1. See docs/setup-org.md Step 5"
else
  say_pass "Foundation's local clone carries a v1 tag — confirm 'git push origin v1' has also run; this check cannot see the remote"
fi

if [ "$fail" -eq 0 ]; then
  echo "  setup complete"
else
  echo "  setup incomplete — fix the failures above and re-run"
fi
exit $fail
