# Joining an organisation that runs OrganisationOS

This is the once-per-person path. Your organisation already has the three repos set up; you need your own clones, two personal files, a hook, and one test. Budget thirty minutes.

If nobody has set the organisation up yet, that comes first: [Setting up OrganisationOS for an organisation](setup-org.md).

## 1. Clone what your role needs

| Your role | Clone | Why |
| --- | --- | --- |
| Team Member, Product Owner, Domain Lead | Domain + Foundation | Your work is in Domain; Foundation supplies the rules, templates and shared commands |
| Leader | All three | Leadership is your working surface; you review Domain PRs and Foundation decisions |
| Admin | All three (plus every per-domain repo if the organisation split them) | You maintain all of it |

Clone them as **siblings under one folder**, with these exact names. Each repo's `CLAUDE.md` points at `../organisationos-foundation/CLAUDE.md`, and every cross-repo path in the harness is written from that layout, so a different one breaks them silently. The pointer does not itself load Foundation's rules. See [How a session loads the three repos](loading-model.md).

```bash
ORG=your-github-org
mkdir -p ~/projects/$ORG && cd ~/projects/$ORG
gh repo clone "$ORG/organisationos-foundation"
gh repo clone "$ORG/organisationos-domain"
gh repo clone "$ORG/organisationos-leadership"      # Leader and Admin only
```

## 2. Copy your role's two files

Foundation ships one pair of files per role in `standards/templates/onboarding/`. They are the single source of the role → configuration mapping; nothing else in the three repos duplicates it.

| Role | `settings.local.json` | `CLAUDE.local.md` | Where `CLAUDE.local.md` goes |
| --- | --- | --- | --- |
| Team Member | `settings.local.json.example-team-member` | `claude-local-team-member.example.md` | `organisationos-domain/domain-N/` |
| Product Owner | `settings.local.json.example-product-owner` | `claude-local-product-owner.example.md` | `organisationos-domain/domain-N/` |
| Domain Lead | `settings.local.json.example-domain-lead` | `claude-local-domain-lead.example.md` | `organisationos-domain/domain-N/` |
| Leader | `settings.local.json.example-leader` | `claude-local-leader.example.md` | repo root of the repo you work from |
| Admin | `settings.local.json.example-admin` | `claude-local-admin.example.md` | repo root of the repo you work from |

```bash
ROLE=team-member          # team-member | product-owner | domain-lead | leader | admin
N=1                       # your domain number (Team Member, Product Owner, Domain Lead)
cd ~/projects/$ORG
cp organisationos-foundation/standards/templates/onboarding/settings.local.json.example-$ROLE \
   organisationos-domain/.claude/settings.local.json
cp organisationos-foundation/standards/templates/onboarding/claude-local-$ROLE.example.md \
   organisationos-domain/domain-$N/CLAUDE.local.md      # Leader/Admin: organisationos-<repo>/CLAUDE.local.md instead
```

Then open your `CLAUDE.local.md` and fill in the placeholders — your peers' handles, your current focus, how you like the agent to work with you.

**Use the role file, not the generic one.** Each repo root also has a `.claude/settings.local.json.example`. It is a pointer to the onboarding folder and its `additionalDirectories` is empty. Copying it works, in the sense that Claude starts without complaint — and Foundation is then never in reach. The smoke test in step 4 catches this.

**Both files are gitignored.** `CLAUDE.local.md`, `**/CLAUDE.local.md`, `.claude/settings.local.json` and `**/.claude/settings.local.json` are in every repo's `.gitignore`. Your notes about colleagues, your preferences and your active work stay on your machine; `git add -A` will not pick them up.

## 3. Install the pre-commit hook

The banned-string hook stops identifying details from external work reaching the shared repos. It ships in Foundation; install it in each clone you will commit from:

```bash
cd ~/projects/$ORG
for r in foundation domain leadership; do
  [ -d "organisationos-$r" ] || continue
  cp organisationos-foundation/.github/hooks/banned-string-pre-commit "organisationos-$r/.git/hooks/pre-commit"
  chmod +x "organisationos-$r/.git/hooks/pre-commit"
done
```

## 4. Smoke-test the session

A wrong install is silent, so test it before you trust it. Start Claude in the folder you will actually work from — `organisationos-domain/domain-N/` for domain roles, the repo root for Leader and Admin — and ask:

> Read Foundation's CLAUDE.md and tell me what the format policy says about built outputs such as decks.

The answer should be that built outputs are referenced from a domain's `references.md` rather than committed, per `FORMATS.md`. That rule lives only in Foundation, so a correct answer proves this session can reach Foundation and read it.

It does not prove Foundation's rules are already in context. Nothing puts them there automatically, and the `@import` line near the top of your repo's `CLAUDE.md` is a pointer rather than a loader. See [How a session loads the three repos](loading-model.md). What the test does prove is that the reach is configured, which is the part people get wrong.

Two more checks while you are there:

- The session addresses you by name, from your `CLAUDE.local.md`, rather than as "your human partner".
- If you started with `claude --add-dir ../organisationos-foundation` (`../../` from inside a domain folder), `/onboard` and `/find-relevant-knowledge` appear in the command list.

If the session cannot find or read Foundation's `CLAUDE.md`, stop and fix two things before doing any work: that `../organisationos-foundation/` really is a sibling of the repo you launched in, and that your `.claude/settings.local.json` lists it under `additionalDirectories`. The commonest cause is copying a repo-root `settings.local.json.example`, whose list ships empty.

## 5. Run `/onboard`

Start Claude in your working folder with Foundation added (`claude --add-dir ../../organisationos-foundation` from a domain folder) and run `/onboard`. It asks your role, domain and start date, and writes a dated 30-day plan to `domain-N/_drafts/onboarding-<your-handle>.md`: what to read in week one, who to pair with in week two, your first draft PR in week three, your first merged PR in week four. Your Domain Lead sees the draft.

## When your role changes

Promotion, a second domain, a move to Leadership: re-copy the matching pair from `standards/templates/onboarding/` rather than editing `additionalDirectories` by hand, and re-run the smoke test. The Admin's monthly maintenance checklist asks whether anyone's role changed; tell them.
