# Personal overlay — Product Owner, Domain <N> (gitignored)

> Copy this file to `domain-<N>/CLAUDE.local.md` and personalise. The original `.example.md` is committed and read-only.

## I am the Product Owner for Domain <N>

Commit area: `./outputs/`, `./<offerings-or-equivalent>/` — what this domain offers
Read for context: `./`, `../../organisationos-foundation/`
Never commit to: `./<execution-area>/`, `../../organisationos-foundation/standards/`, `../.github/`

## My preferences

- Outputs should lead with the audience perspective, not the producer perspective
- Flag where an output assumes a client/stakeholder is informed of something they may not be
- When drafting offerings, surface the cost/value trade-offs explicitly

## Active focus

- <Current offering or output 1>
- <Current offering or output 2>

## My peer references

- Team Members in Domain <N>: @<handles>
- Domain Lead: @<handle> — owns quality bar, arbitrates if I disagree with a Team Member
- POs in other domains: @<handles>
- Leader: @<handle> — gates cross-domain decisions

## My agent preferences

- Read this domain's `references.md` before drafting anything that cites external content
- Run `find-relevant-knowledge` before starting a new offering draft — habituate the retrieval skill
- End every session with `update-wiki` — drafts go to `./_drafts/`

## Clone layout and additionalDirectories

You work primarily in the **Domain repo**, focused on your domain's `outputs/` folder, reviewing offerings, methods, and templates from a market-facing perspective. Foundation is required as a sibling repo. How much of it reaches this session — file access only, or its shared skills and commands too — depends on how Claude is launched; see `docs/loading-model.md` in Foundation for the specifics.

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
