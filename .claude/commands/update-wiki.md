---
description: End-of-session ritual. Review the session and draft ADRs, CDRs, wiki updates, method revisions to `_drafts/`. Drafts only — never commits.
---

# update-wiki

## Pre-draft check

Before drafting any of the below, check the artefacts referenced this session against the current Foundation `glossary.md` and `interfaces/` on disk. Flag any divergence (a term used differently than the glossary defines it, an interface assumed but not present, a stale interface reference) in the session note. This is a discipline nudge, not a hard gate — it does not block drafting or require resolution before proceeding.

Review this session and identify, saving drafts to `<current-domain>/_drafts/`:

1. **Decision made and not yet recorded?**
   Draft an ADR at `_drafts/adr-{timestamp}-{slug}.md` using Foundation's `standards/templates/adr-template.md`.

2. **Cross-domain implication?**
   Only draft a CDR if a real decision was reached this session — a choice made between alternatives that binds ≥2 domains. Check: did the session decide something, or only analyse or synthesise? A read-only synthesis across domains — comparing, summarising, or reporting on ≥2 domains without committing any of them to anything — is not a CDR; it belongs in Foundation's `syntheses/` home instead (see `syntheses/README.md`). If, and only if, an actual cross-domain decision was made, draft a CDR at `_drafts/cdr-{timestamp}-{slug}.md` using `cdr-template.md`. Note in the draft that the Admin opens a `../organisationos-leadership/cadence/propagation-log.md` entry once the CDR is accepted at the Forum (the agent does not edit the propagation log directly).

3. **Insight others would benefit from?**
   Draft a wiki entry at `_drafts/wiki-{slug}.md`.

4. **Method step changed?**
   Draft an update at `_drafts/method-{slug}.md` with a dated revision.

5. **New prompt that worked?**
   Draft at `_drafts/prompt-{slug}.md` with the test result.

## Critical rules

- **Do NOT commit any of the above autonomously.** Surface a list of drafts for the operator to review.
- Drafts in `_drafts/` live 14 days. The `draft-staleness.yml` workflow surfaces drafts >14 days into the monthly DRI issue.
- Each draft has three end-states: **merged** (into the domain's wiki / methods / interfaces / CDRs), **retired** (moved to `_archive/` with reason), or **extended** (Domain Lead approves another 14 days).

## Low-ceremony merge path

This ritual is mandated every session, so merging a draft has to be cheap or the ritual gets skipped. Once the operator opens a PR for a `_drafts/` entry under a small size cap (e.g. <100 changed lines, wiki/method/prompt drafts only — not CDRs or ADRs), that PR uses the §12 **notification-only** tier: branch protection has `require-code-owner-review` off on `domain-N/_drafts/`, so it merges on proposer + green CI without waiting on a blocking review. The Domain Lead is still tagged via CODEOWNERS and can flag it after the fact. Drafts over the size cap, or CDR/ADR drafts, go through the normal single-reviewer or two-approver tier as their target path requires.

## After drafting

Write one summary line per draft to `<current-domain>/<sessions-folder>/YYYY-MM-DD.md`. This is the session note.

## What this command is NOT

- Not a commit ritual. Drafts only.
- Not a replacement for back-flow review (Pattern A). If the session involved external-work content, do not draft anonymisation here; use the `anonymisation-check` skill and the `back-flow` PR path.
