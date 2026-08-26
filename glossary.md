# Glossary — cross-domain

Terms used across two or more domains in this organisation. Domain-specific terms live in each domain's own `glossary.md`.

## OrganisationOS terms

- **Admin** — role responsible for the operating contract (Steward + Engineer functions). See `CLAUDE.md` and `docs/concepts.md` → The five roles.
- **Back-flow PR** — Pattern A only. A PR carrying anonymised content from an external-work repo back into the harness. Labelled `back-flow`; requires two reviewers.
- **CDR** — Cross-Domain Decision Record. Lives in Foundation's `cross-domain-decisions/`. Distinguished from ADRs (single-domain decisions).
- **Domain Lead** — owns a domain's quality bar.
- **Drift log** — `../organisationos-leadership/steward/drift-log.md`. The Admin's harness-drift and improvement backlog: stale artefacts surfaced by the monthly DRI, improvement-loop proposals, and harness-substrate change reasoning. CDR propagation actions live separately in the propagation log.
- **Forum / Leadership Forum** — the cross-domain governance ritual. Adopters rename to fit culture.
- **Interface** — `interfaces/<name>.md` in Foundation. Describes how two or more domains co-produce something.
- **Leader** — owns cross-domain alignment and strategy.
- **Pattern A / Pattern B** — external-work boundary choice. A = harness-as-IP-layer; B = harness-as-primary-workspace.
- **Precedence block** — the top-of-file assertion in every CLAUDE.md that defends against plugin/MCP rebinding.
- **Product Owner** — owns what a domain offers.
- **Propagation action** — a propagation PR that closes a CDR clause.
- **Propagation log** — `../organisationos-leadership/cadence/propagation-log.md`. The Admin's per-CDR tracker of downstream propagation actions (open / in flight / closed). Distinct from the drift log.
- **Team Member** — owns how a domain's work is done.

## Adopter additions

Adopters add terms here that span multiple domains in their organisation. Examples:

- A shared methodology name used by multiple domains.
- A reporting cadence or artefact consumed by multiple domains.
- A regulatory or compliance term that crosses domains.

Domain-specific terms (e.g. "operating model" in an IT-strategy practice) live in each domain's `glossary.md` to keep this file small and the domain glossary authoritative for its own vocabulary.

## Domains

This list is referenced by the promotion-lint workflow to detect cross-domain mentions in ADR bodies. Adopters maintain this list as domain names change.

- domain-1
- domain-2
- domain-3
- domain-4
