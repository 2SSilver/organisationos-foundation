---
name: Monthly maintenance (Admin)
about: Auto-opened on the 1st of each month
labels: drift, harness
---

# Monthly maintenance check — YYYY-MM

For each domain, the Admin (or per-domain steward at scale) reviews:

- [ ] Stale CLAUDE.md (>90 days since last meaningful edit AND the domain has shipped work that should have changed it)
- [ ] Stale interfaces (no quarterly active-references update)
- [ ] Stalled CDR propagation (any propagation action open >30 days — cross-check `propagation-sla.yml` issues)
- [ ] Stale wiki content — files in `domain-*/<knowledge-folder>/` unmodified >180 days and not referenced from a current method or interface
- [ ] Accumulated drafts — any file in `domain-*/_drafts/` >14 days (cross-check `draft-staleness.yml` reports); decision per draft: merge, retire, or extend
- [ ] Banned-pattern list (anything new from the last month's work)
- [ ] **Corpus rescan (MR-08)** — if the banned-pattern list gained any pattern this month, re-run `banned-string-check.yml`'s scan logic over already-merged content (not just new PRs) using the updated list. A pattern added today does not retroactively re-check content merged before it existed; a merged file with a now-banned string sits undetected until this rescan finds it. Record the result (clean / findings-with-remediation-plan) in the DRI close-out summary.
- [ ] FORMATS.md (anything new on the export-target side?)
- [ ] Templates (any template not used in 6 months — retire candidate)
- [ ] Plugin / MCP version review (per v3.1 §15; pin bump needed?)
- [ ] **Re-check `settings.local.json` scope** — any role change this month (promotion, a domain added/split, someone leaving a domain)? Personal `settings.local.json` never re-syncs on its own after the one-time onboarding copy, so a stale `additionalDirectories` silently under- or over-scopes that person. For anyone who changed role, have them re-copy from the current role-specific file in `standards/templates/onboarding/` (the one canonical source — see README §5) rather than hand-editing the old one.
- [ ] **Improvement-loop proposal** — one harness change drafted as a PR (skill, CI rule, template, or none with rationale). Admin-Engineer cadence visible artefact.
- [ ] Commit-volume sanity check — any domain <3 commits/person/month after week 6 of adoption? If yes, the answer is workflow integration, not more CI rules (see v3.1 §18).

Close this issue with a one-paragraph summary linked from the Leadership repo's `steward/drift-log.md`.
