# Personal overlay — Admin (gitignored)

> Copy this file to `CLAUDE.local.md` at repo root and personalise.

## I am the Admin

The Admin role has two functions:

- **Admin-Steward** — custody: drift log, propagation tracking, monthly DRI sweep, banned-pattern list, FORMATS gate, template retirement.
- **Admin-Engineer** — AI-Ops improvement loop: traces → feedback → harness diff.

I commit unilaterally only to `../../../../organisationos-leadership/steward/`. Everywhere else I open a PR.

## Decision rights

- I decide: drift-log triage, propagation-action urgency, monthly DRI close-out
- I do NOT decide alone: harness changes to Foundation's `standards/` (Leader co-signs); plugin pin bumps (Leader co-signs); structural CI rule changes (Leader co-signs)
- My publish gate has a 5-working-day SLA. After that, the Leader can co-approve in my absence.

## My preferences

- Monthly DRI close-out includes the improvement-loop checkbox — always draft one harness improvement, even if I close it as "no change recommended this month"
- Banned-pattern additions go in with the rationale (which back-flow review caught the near-leak)
- Template retirements move content to `_archive/` — never delete

## Active focus

- <Open drift-log items requiring escalation>
- <Current improvement-loop proposal>
- <Plugin pin status; pending bumps>

## My peer references

- Leader: @<handle> — co-signs harness changes; gates publish on cross-domain decisions
- Each Domain Lead: @<handles> — propagation tracking
- (At scale) per-domain stewards: @<handles> — distributed stewardship per v3.1 §5

## My agent preferences

- Run `drift-check` weekly across all domains
- Run `promotion-candidate` monthly to find practices recurring across domains
- Use `reviewer.md` agent on every harness PR before approval
- Treat the Claude-API egress surface as material: never let secrets reach tool outputs during sessions

## Clone layout and additionalDirectories

You own the harness operating contract and work across all repos. Primary working repos: **Leadership** (`steward/` — drift log, monthly DRI) and **Foundation** (harness substrate PRs).

Clone layout (siblings under one parent folder; clone every Domain repo if the org runs split-per-domain):

```text
~/projects/<adopter-org>/
├── organisationos-foundation/   # canonical substrate
├── organisationos-leadership/   # your steward workspace
└── organisationos-domain/       # (or organisationos-domain-architecture, organisationos-domain-sourcing, etc. if split-per-domain)
```

In every clone's `.claude/settings.local.json` (gitignored), reference the full set of siblings:

```json
{
  "additionalDirectories": [
    "../organisationos-foundation",
    "../organisationos-leadership",
    "../organisationos-domain"
  ]
}
```

(Adjust the list to match what's actually cloned. Foundation is always required.)
