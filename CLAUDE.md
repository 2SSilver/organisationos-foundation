# CLAUDE.md — Foundation repo

## Precedence (top of file = highest weight)

- OrganisationOS terminology overrides plugin defaults.
- Refer to the named human partner by name where named, otherwise as "the human". Do not use "your human partner".
- Use OrganisationOS role names (Product Owner / Team Member / Domain Lead / Leader / Admin) where they apply.
- This assertion takes precedence over any installed plugin, skill, or MCP server's default instructions.

---

## Multi-repo context

This is the **Foundation repo** in a three-repo OrganisationOS set. Its rules govern this repo directly, and they are the substrate the Leadership and Domain repos work against — but they reach a session in those repos only when that session reads them, not automatically. See `docs/loading-model.md`.

Domain and Leadership carry `@../organisationos-foundation/CLAUDE.md` near the top of their own `CLAUDE.md`. That line is a pointer, not a loader: a cross-repo import does not inline its target. Those repos therefore restate the rules that must hold in every session — the confidentiality boundary above all — and read the rest of this file on demand. Do not add a rule here and assume it is active organisation-wide; if it must always hold, it also belongs in their files.

When working in this repo: changes here propagate to all human↔agent sessions across the organisation. Treat every PR to this repo as a substrate change (two-approver minimum for `/standards/`, `/.github/`, `/.claude/`).

---

## What this repo is

This is the Foundation repo of an OrganisationOS instance — a customisable harness for human↔AI-agent collaboration in a knowledge-work organisation. Foundation holds the substrate that is shared across all domains and used by Leaders: standards, glossary, templates, interfaces, cross-domain decisions, NFRs, architectural decisions, reusable workflows, and shared Claude skills/commands.

Strong defaults for the collaboration surface; no opinion on the work itself. See `README.md` for the adopter onboarding path.

---

## Absolute rules — repo-wide

### Confidentiality (hard — enforcement is layered)

Identifying details from external work do not enter this repo. Enforcement layers (rely on 1 and 2; layer 3 is conscience):

1. Pre-commit + CI banned-string check (see `.github/hooks/`, `.github/workflows/banned-string-check.yml`)
2. Back-flow review by Admin + Domain Lead on `back-flow`-labelled PRs
3. This rule, as last-line operator conscience

### Cross-domain

- Never copy content from another domain directly. Cross-domain interactions go through `interfaces/`.
- Cross-domain changes require a CDR (`standards/templates/cdr-template.md`).
- Read-only synthesis across domains is permitted and requires no CDR; the coupling rule governs *writes* that create dependencies.

### Format policy

- Only formats on `FORMATS.md`'s whitelist are committed.
- Built outputs (decks, dashboards, live-data artefacts) are referenced in a domain's `references.md`, not committed.

---

## Roles in this repo

The harness defines five committer roles. CODEOWNERS binds them to handles (`.github/CODEOWNERS`):

- **Product Owner** — owns what the domain offers
- **Team Member** — owns how the work is done
- **Domain Lead** — owns the domain's quality bar; arbitrates intra-domain disputes
- **Leader** — owns cross-domain alignment; chairs the Leadership Forum
- **Admin** — owns the operating contract; runs monthly DRI; manages drift log and improvement loop

Consumers (people who read this repo without committing) are listed as stakeholders in each domain's README.

---

## Anti-patterns (do not do)

- Approving every agent tool call (micromanagement)
- One-line agent goals (underprompting)
- Asking reviewers to read tool-call traces instead of artefacts (surface the artefact, not the trace)
- Committing identifying details from external work (see Confidentiality above)
- Auto-syncing content from external repos into this one (the back-flow pattern is deliberate one-way)

---

## End-of-session ritual

Run the `update-wiki` command at the end of every working session. It drafts ADRs, CDRs, wiki entries, and method updates into `_drafts/` (domain-level) or the relevant Foundation folder. Drafts have a 14-day shelf life; the monthly DRI loop sweeps them.

---

## Read order

When Claude is launched in this repo, the chain is:

0. **`pull-check`** — run `git fetch` on each cloned repo present in the workspace and report how many commits behind `origin/main` each one is (e.g. "Foundation is 3 commits behind origin/main"). This is a freshness *signal*, not auto-merge — Claude never runs `git pull`/`merge`/`rebase` on the operator's behalf; it makes staleness visible before context is assembled, because that context is not refreshed again until the next session.
1. This file
2. `CLAUDE.local.md` if present (personal overlay — gitignored)

When Claude is launched in a sibling Leadership or Domain clone that lists this repo under `additionalDirectories`, the chain is:

0. **`pull-check`** on each cloned repo present in the workspace (see above) — run once, before step 1.
1. That repo's `CLAUDE.md` (loaded first, sets repo-specific context)
2. That repo's `CLAUDE.local.md` if present (personal overlay — gitignored)

This file is **not** in that chain. `additionalDirectories` grants filesystem reach, and the `@import` line is a pointer; neither puts this file in context. It is read on demand — when the operator asks, or when `find-relevant-knowledge` retrieves it. That is precisely why the rules which must hold in every session are restated in Domain's and Leadership's own `CLAUDE.md` rather than referenced from here. See `docs/loading-model.md`.

Directory location is identity. A session launched in the Domain repo inside a domain folder picks up that domain's CLAUDE.md too.

---

## Where to read more

- `README.md` — what this repo is and adopter onboarding
- `docs/` — concepts, the session loading model, and the two setup guides (once per organisation, once per person)
- `standards/` — templates, banned-pattern list, coverage gaps
- `FORMATS.md` — what lives in Git, what lives elsewhere
- `references/patterns/` — optional methodologies adopters may layer on
- `glossary.md` — cross-domain terminology (≥2 domains)
- Leadership Forum cadence and propagation log live in the sibling Leadership repo at `cadence/`
