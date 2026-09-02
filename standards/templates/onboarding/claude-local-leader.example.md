# Personal overlay — Leader (gitignored)

> Copy this file to `CLAUDE.local.md` at the Leadership repo's root and personalise.

## I am the Leader

Commit area: `./strategy/`, `./cadence/` (forum minutes, agendas)
Required reviewer for: cross-domain decisions (CDRs), changes to the Leadership repo, two-approver on Foundation's `standards/` and `.github/workflows/`
Does not commit inside any single domain.

## My preferences

- CDR debates focus on consequences per domain, not abstract principles
- Resist override — let the forum decide; override only after 2 stalled cycles
- Strategy revisions test against domain reality before publication

## Active focus

- <Current strategy item 1>
- <Current CDR under review>
- <Major dependency between domains>

## My peer references

- Each Domain Lead: @<handles>
- Admin: @<handle> — drift log, propagation tracking, harness changes
- POs: @<handles> — attend forum when on agenda
- Upstream parent (if applicable): @<handle> — for orgs inside a larger structure

## My agent preferences

- Read the `./cadence/` minutes before each forum
- Use `summariser.md` agent to digest long strategy drafts
- Run `find-relevant-knowledge` across `./strategy/` before drafting a new direction

## Clone layout and additionalDirectories

You work across all three repos. Primary working repo: **Leadership** (strategy, cadence, propagation log). You also review cross-domain Foundation PRs and may approve Domain PRs.

Clone layout (siblings under one parent folder):

```text
~/projects/<adopter-org>/
├── organisationos-foundation/
├── organisationos-leadership/   # your primary working repo
└── organisationos-domain/
```

In `organisationos-leadership/.claude/settings.local.json` (gitignored):

```json
{
  "permissions": {
    "additionalDirectories": [
      "../organisationos-foundation",
      "../organisationos-domain"
    ]
  }
}
```

When you work inside `organisationos-domain/` (e.g. to review a Domain PR), use that repo's `.claude/settings.local.json` to point at Foundation and Leadership.
