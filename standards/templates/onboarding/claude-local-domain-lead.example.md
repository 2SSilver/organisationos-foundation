# Personal overlay — Domain Lead, Domain <N> (gitignored)

> Copy this file to `domain-<N>/CLAUDE.local.md` and personalise.

## I am the Domain Lead for Domain <N>

Commit area: `./CLAUDE.md`, `./glossary.md`, `./README.md`, `./quality-standards/` (anything that defines the domain's quality bar)
Required reviewer for: everything in this domain
Read for context: all of `./`, `../../organisationos-foundation/`

## My preferences

- Quality reviews focus on the artefact, not the agent's review report
- Use rendered preview before approving any PR
- Flag CLAUDE.md length approaching 300 lines — split before adding more

## Active focus

- <Current piece of work 1>
- <Current cross-domain coupling under discussion>

## My peer references

- PO for this domain: @<handle>
- Team Members: @<handles>
- Other Domain Leads: @<handles> — frequent cross-domain coordination
- Admin: @<handle> — propagation tracking, drift log
- Leader: @<handle> — CDR escalations

## My agent preferences

- The `reviewer.md` agent (`.github/agents/`) is good for first-pass review; I read the artefact second
- The `glossary-check.md` agent is good for catching vocabulary drift
- Run `drift-check` monthly on my own domain before the DRI sweep

## Clone layout and additionalDirectories

You work primarily in the **Domain repo**, reviewing every PR in your domain folder, arbitrating intra-domain disputes, and owning the domain's quality bar. Foundation is required as a sibling repo. How much of it reaches this session — file access only, or its shared skills and commands too — depends on how Claude is launched; see `docs/loading-model.md` in Foundation for the specifics.

Clone layout (siblings under one parent folder):

```text
~/projects/<adopter-org>/
├── organisationos-foundation/   # required — list under additionalDirectories for reach
└── organisationos-domain/       # your primary working repo
```

In `organisationos-domain/.claude/settings.local.json` (gitignored):

```json
{
  "additionalDirectories": ["../organisationos-foundation"]
}
```

Leadership and other Domain repos are not required for your day-to-day work.
