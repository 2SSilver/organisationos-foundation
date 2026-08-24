# Vocabulary workshop — pre-adoption diagnostic

## Purpose

Surface domain-boundary disagreements before they encode into folders. "Bounded contexts that are not bounded will produce drift no harness can prevent" (v3.1 §19).

## Attendees

Prospective Domain Leads (one per proposed domain), Product Owners, Leader, Admin.

## Format — 4 hours

### Round 1 (45 min) — independent drafting

Each Domain Lead writes:

- The proposed domain name
- 3-sentence description of what this domain does
- 5 artefacts they expect the domain to own
- 3 dependencies on other proposed domains

### Round 2 (60 min) — pairwise reads

Pairs of Domain Leads swap drafts. Each pair surfaces:

- **Vocabulary clashes** (same word, different meaning across domains)
- **Ownership overlaps** (one artefact claimed by two domains)
- **Missing interfaces** (a dependency neither domain expected)

### Round 3 (60 min) — plenary

Leader chairs. Each clash, overlap, or missing interface is named in a 4-quadrant artefact:

- **Resolved** — vocabulary tightened, ownership agreed
- **Renamed** — one domain renames itself
- **Merged** — two proposed domains collapse to one
- **Deferred** — the conflict survives this workshop; flag as risk

### Round 4 (75 min) — write the output

The Leader and Admin draft a `vocabulary-YYYY-MM-DD.md` committed to `../../../organisationos-leadership/cadence/`. Output includes:

- Final domain names and one-paragraph charters
- Glossary additions (terms with their resolved meanings)
- A list of Round-3 "Deferred" items, each with a named owner and a review date

## Exit criteria

- **≥2 unresolved "Deferred" items:** do not adopt yet. The bounded contexts are not bounded; fix the vocabulary before the folders.
- **0–1 Deferred items:** adopt with the Deferred items as the first CDR candidates in the new harness.

## Re-running

Run again at any major reorganisation (new domain added, domain merged or split, role re-defined). The workshop is the cheapest diagnostic available; do not skip it.
