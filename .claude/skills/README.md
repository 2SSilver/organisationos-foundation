# .claude/skills/

Org-wide skills authored by the adopter. Skills here apply across all domains.

## Indicative shape (adopter populates)

- `deliverable-review/` — review an output against the domain's quality bar.
- `anonymisation-check/` — verify an artefact is safe to back-flow from external work (Pattern A only). Reviewer-shaped (read-only).
- `joint-output-drafting/` — draft an interface for a cross-domain output.
- `method-refresh/` — read recent session notes, propose updates to a named method.
- `output-design/` — draft a new output from a problem statement.

## Skill anatomy

Each skill is a folder with at least a `SKILL.md` file:

```yaml
---
name: <kebab-case-name>
description: Use this when <specific situation>. Returns <artefact shape>.
---

# <Skill name>

<Body — instructions for Claude when this skill is invoked>
```

## Routing around superpowers skills

When an OrganisationOS skill overlaps with a `superpowers:` skill, the OrganisationOS skill's `description:` opens with an explicit routing prefix — description-based routing is the mechanism the Skill tool actually consults:

```yaml
---
name: requesting-deliverable-review
description: Use this instead of superpowers:requesting-code-review when the artefact is a markdown/docx/pptx deliverable, not source code. Request a structured review of a knowledge-work deliverable by a peer Domain Lead.
---
```

The Domain Lead approves any routing declaration; the Admin tracks them in `../../../organisationos-leadership/steward/skill-registry.md`.
