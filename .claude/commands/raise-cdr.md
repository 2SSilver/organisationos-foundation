---
description: Draft a Cross-Domain Decision Record (CDR) from a session's cross-domain implications.
---

# raise-cdr

Draft a CDR from the current session's cross-domain implications.

## Steps

1. Identify the cross-domain implication. Ask the operator if not obvious.
2. List the domains affected and the impact level for each (high / medium / low).
3. Open `../organisationos-foundation/standards/templates/cdr-template.md` as the starting shape.
4. Fill in:
   - Title (one line)
   - Status: Proposed
   - Domains affected (each with one-sentence rationale)
   - Context (one paragraph)
   - Decision (one paragraph — proposed)
   - Consequences per domain (action + owner placeholder + deadline placeholder)
5. Save as `<current-domain>/_drafts/cdr-{timestamp}-{slug}.md` — the current domain's own `_drafts/` folder, matching where `update-wiki` already drafts CDRs. Do not write into `../organisationos-foundation/`: a Domain session's `settings.json` denies writes there by design (confidentiality boundary, spec §8).
6. Surface the path for the operator to review.

## What this command does NOT do

- Does not open a PR. The operator does that after review, once the draft has moved from the Domain clone into Foundation's `cross-domain-decisions/` — the boundary is crossed by a PR, not by a direct write.
- Does not assign owners or deadlines — those are operator decisions.
- Does not move the CDR to `Accepted` — that's the Leadership Forum.

## Reminder

The CDR is reviewed and gated by the Leadership Forum (v3.1 §11). Below ~20 people, use `cdr-light-template.md` instead — every decision is an ADR with an `affected-domains` field.
