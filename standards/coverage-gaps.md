# Coverage gaps — what banned-string CI cannot detect

The `banned-patterns.yml` substring/regex check catches the careless human; it does not catch structural identifiers. Six categories of leak that CI cannot detect, and the harness defence for each:

| Gap | Example | Defence |
| --- | --- | --- |
| **Paraphrased identifiers** | A client called "Nordic Bank" written elsewhere as "the Scandinavian retail-banking group" | Back-flow review (Domain Lead + Admin), `glossary-check` agent |
| **Structural identifiers** | An industry × region × company-size triple unique to one client | Back-flow review; `context-near` patterns in `banned-patterns.yml` |
| **Numerical identifiers** | An unusual contract value, headcount, KPI baseline | Back-flow review with explicit numerical-anomaly check |
| **Co-occurrence identifiers** | Two anodyne facts that combine to identify | `context-near` directive in `banned-patterns.yml` |
| **Date identifiers** | A date correlated to a known public event for the client | Back-flow review (Domain Lead recognises the date) |
| **Near-misses** | Partial names, initial-cap codenames, CamelCase variants not yet on the list | Periodic banned-pattern review at the monthly maintenance issue (docs/setup-org.md → Step 8); near-miss detection in `reviewer.md` agent |

## When to add a category here

The Admin and Domain Leads update this file when a real near-leak surfaces during back-flow review. New categories become input to the next monthly DRI's banned-pattern list update.

## Pattern A only

This file is part of Pattern A's defence chain. Pattern B adopters may delete it or repurpose for other content-sensitivity concerns.
