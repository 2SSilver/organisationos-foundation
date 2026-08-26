---
description: Produce a personalised 30-day onboarding plan for a new joiner based on their role and domain.
---

# onboard

Personalise this onboarding plan for the joiner. Ask:

1. Which role? (Product Owner / Team Member / Domain Lead / Leader / Admin)
2. Which domain? (or "leadership-tier" for Leader/Admin)
3. Start date (defaults to today)?

Then output a dated 30-day plan with these milestones. Save the output to `<domain>/_drafts/onboarding-<joiner-handle>.md` and ping the joiner's Domain Lead.

## Week 1 — read, install, smoke-test

- **Day 1:** Read the domain's CLAUDE.md, glossary, and the last 3 sessions in `<knowledge-folder>/`. Do not commit.
- **Day 2:** Copy the role-specific
  `../organisationos-foundation/standards/templates/onboarding/claude-local-<role>.example.md` (e.g.
  `claude-local-domain-lead.example.md`) to `CLAUDE.local.md` — at the repo
  root for Admin and Leader, or `domain-<N>/CLAUDE.local.md` for Domain Lead,
  Product Owner and Team Member, per that file's own line 3. Copy the role-specific
  `../organisationos-foundation/standards/templates/onboarding/settings.local.json.example-<role>`
  to your working repo's `.claude/settings.local.json` (gitignored).
  Install the workflow plugin per the org's `.claude/settings.json`
  pin.
- **Day 3:** Install the pre-commit banned-string hook:

  ```bash
  cp ../organisationos-foundation/.github/hooks/banned-string-pre-commit .git/hooks/pre-commit
  chmod +x .git/hooks/pre-commit
  ```

- **Day 4:** Run a smoke-test session in the joiner's working directory. Verify the Precedence block addresses the joiner as named (not "your human partner").
- **Day 5:** Read the domain's `references.md` and the relevant templates in Foundation's `standards/templates/`.

## Week 2 — pair on one PR

Pair with an existing Team Member (for TMs/POs) or Domain Lead (for DLs) on one draft PR. Observe the draft → ready → review → merge cycle. Do not own the PR.

## Week 3 — own first draft PR (deliberately draft)

Open a draft PR for a small change in the joiner's domain. Use the PR as a thinking space. Do not seek review until ready.

## Week 4 — own first merged PR

Convert the draft to ready. The Domain Lead reviews. Merge target: end of week 4.

## Week 5+ — first agent-drafted artefact

- Run the `update-wiki` command at end of session. Review the drafted ADRs / CDRs / wiki additions before merging anything.
- Run `find-relevant-knowledge` before starting any new piece of work — habituate the retrieval skill.

## Role-specific additions

- **Product Owner:** Read every offering or output the domain currently lists. Identify two that look stale.
- **Team Member:** Read every method file in the domain. Run one method end-to-end as practice.
- **Domain Lead:** Schedule a 30-minute pair with each Team Member and the PO in the first two weeks. Read every interface where this domain is providing or consuming.
- **Leader:** Read the last six Leadership Forum minutes. Sit in on three forums before chairing.
- **Admin:** Pair with the outgoing Admin if there is one (use `handover-template.md`). Read the last three monthly DRI close-outs and the full drift log.

## Output

Save the personalised plan to `<domain>/_drafts/onboarding-<joiner-handle>.md`. Ping the joiner's Domain Lead.
