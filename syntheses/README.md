# Syntheses

The discoverable home for cross-domain synthesis artefacts — a Domain Lead or Team Member reading across two or more domains and writing up what they found.

## Why a separate folder

Read-only synthesis across domains is permitted and requires no CDR (see Foundation `CLAUDE.md`, Absolute rules — Cross-domain). But a synthesis written into one domain's own folder is invisible to the domains it is *about*, and looks like that domain's opinion rather than a cross-domain read. `syntheses/` gives the artefact a stable, neutral address any domain can find.

## What belongs here

- A write-up that reads across ≥2 domains and reports a pattern, a gap, or a comparison — without creating a dependency between domains.
- Artefacts produced by the `find-relevant-knowledge` or a similar cross-domain read; anything that started as "what does domain-2 and domain-3 both assume about X."

## What does NOT belong here

- **Not a domain-owned folder.** A synthesis about domain-2 and domain-3 does not live in either domain's tree — that would hide it from the other subject domain and imply single ownership of a joint read.
- **Not Leadership's strategy surface.** `syntheses/` is a substrate folder for cross-domain *reads*; organisation-level priorities, OKRs, and position papers live in the Leadership repo's `strategy/` (see `docs/concepts.md` → Why three repos). A synthesis may inform a strategy decision, but the synthesis itself stays here.
- **Not a CDR.** If a synthesis's conclusion leads to a decision that creates a cross-domain dependency — a shared method, a joint offering, a write that binds two domains — that decision is a CDR at `../cross-domain-decisions/`, not an edit to the synthesis file.

## How to add a synthesis

1. File name: kebab-case, descriptive (e.g. `<domain-x>-<domain-y>-<topic>-synthesis.md`).
2. State the domains read, the question asked, and the date. Placeholder names, not real ones, at template stage.
3. No CODEOWNERS gate beyond the standard Foundation review — this is a read-only artefact, not a substrate change.
4. If the synthesis surfaces a cross-domain implication worth deciding on, raise a CDR separately and link it back from the synthesis.

## Lifecycle

Syntheses do not expire on the `_drafts/` 14-day clock — they are not domain drafts. A synthesis that no longer reflects current domain state is either superseded by a newer synthesis (linked in place) or retired, at the Admin's discretion during the monthly DRI.
