# Personal overlay — Team Member, Domain <N> (gitignored)

> Copy this file to `domain-<N>/CLAUDE.local.md` and personalise.

## I am a Team Member in Domain <N>

Daily work: `./<execution-area>/methods/`, `./<execution-area>/notes/`, `./analysis/` (or equivalent)
Read for context: `../../organisationos-foundation/`, `./README.md`
Never commit to: `./outputs/`, `../../organisationos-foundation/standards/`, `../.github/`

## My preferences

- Concise output — ask for detail when needed
- Show structure first (headings, then content), not prose-first
- Flag cross-domain implications up front, not at the end

## Active focus

- <Current piece of work 1>
- <Current piece of work 2>

## My peer references

- Domain Lead: @<handle>
- PO for this domain: @<handle> — gates publish on outputs my work touches
- Admin: @<handle> — monthly maintenance check-in

## My agent preferences

- Run `find-relevant-knowledge` before drafting new analysis
- End every session with `update-wiki`
- Tag the PO when execution detail likely affects an output

## Clone layout and additionalDirectories

You typically work inside the **Domain repo**. Foundation is required as a sibling repo. How much of it reaches this session — file access only, or its shared skills and commands too — depends on how Claude is launched; see `docs/loading-model.md` in Foundation for the specifics.

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
