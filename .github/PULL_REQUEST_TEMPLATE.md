## What changed

One paragraph. What is different now?

## Why

One paragraph. What problem does this solve? What changed in the world that made this change necessary?

## Substrate area affected

- [ ] `standards/` — two-approver PR required (Admin + Leader)
- [ ] `interfaces/` — Leader + affected Domain Lead(s) required
- [ ] `cross-domain-decisions/` — Leader + affected Domain Lead(s) required
- [ ] `architectural-decisions/` — Leader + affected Domain Lead(s) required
- [ ] `nfrs/` — Leader + affected Domain Lead(s) required
- [ ] `glossary.md` — Leader + Admin required
- [ ] `.github/` or `.claude/` harness — two-approver (Admin + Leader)
- [ ] `references/` — Admin only

## Cross-domain implications

None | <list, with one line each>. If cross-domain, has a CDR been raised? (See `standards/templates/cdr-template.md`)

## Approval checklist (cross-domain / substrate PRs only)

Canonical rule (the CDR process, Leadership Forum cadence, and branch protection/CODEOWNERS all agree): the Leader + the Domain Lead of each
affected domain (+ Product Owner and Admin where the CDR template lists
them). CODEOWNERS lists the fallback superset; this checklist records the
actual affected set.

- [ ] Affected domain(s) named: <list>
- [ ] Each affected Domain Lead approved
- [ ] Leader approved
- [ ] Product Owner approved (where the CDR template lists PO for this artefact type)
- [ ] Admin approved (where the CDR template lists Admin for this artefact type)

CI verifies this checklist is complete on any PR that changes cross-domain substrate — `interfaces/`, `cross-domain-decisions/`, `architectural-decisions/`, `nfrs/`. It is detected from the changed files, not from a label, so there is no label to forget.

## Reviewer affordances

- [ ] Rendered preview opened: <link auto-posted by CI>
- [ ] Banned-string check passed locally (pre-commit + CI)
- [ ] I read the artefact, not just the agent's review

## CDR linkage (if this PR closes a propagation action)

Closes CDR-XXX

## Reviewers

- Admin: @<handle>
- Leader: @<handle>
- Domain Lead (if interfaces/CDRs/NFRs affected): @<handle>
- Second required reviewer if proposer wears multiple roles: @<handle>
