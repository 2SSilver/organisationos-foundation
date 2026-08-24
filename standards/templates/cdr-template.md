---
status: Proposed
affected-domains: [domain-1, domain-2]
implementation-prs: []   # companion Domain-repo PR URLs, filled after the CDR merges
---

# CDR-XXX: <Decision title>

## Status

Proposed | Accepted | Deprecated | Superseded by CDR-YYY

## Domains affected

- Domain 1 (impact: high — <reason>)
- Domain 2 (impact: medium — <reason>)
- Domain 3 (impact: low — informational)

## Context

What problem spans multiple domains? Why now? What changed?

## Decision

What is being decided. One paragraph maximum.

## Consequences per domain

### Domain 1

- Action: ...
- Owner: @<handle>
- Deadline: YYYY-MM-DD

### Domain 2

- Action: ...
- Owner: @<handle>
- Deadline: YYYY-MM-DD

## Approval

- Product Owner, Domain 1:
- Product Owner, Domain 2:
- Domain Lead, Domain 1:
- Domain Lead, Domain 2:
- Leader:
- Admin: (records propagation actions in ../../../organisationos-leadership/cadence/propagation-log.md)

## Propagation actions (Admin)

- [ ] PR in Domain 1: update <files> by YYYY-MM-DD
- [ ] PR in Domain 2: update <files> by YYYY-MM-DD
- [ ] Interface update: <interface name>, by YYYY-MM-DD
- [ ] Template / standard update: <which>, by YYYY-MM-DD

Each propagation PR includes `Closes CDR-XXX` in its description; the propagation-log entry records the merged SHA. The `propagation-sla.yml` workflow opens an issue for any item open >30 days.
