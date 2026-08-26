# References — Domain <N>

External documents, dashboards, decks, and live systems this domain depends on but does not store in Git.

The Admin verifies the `Last verified` column at the monthly DRI review (see `.github/ISSUE_TEMPLATE/monthly-dri.md`).

| Title | URL | Owner | Retention | Last verified |
| --- | --- | --- | --- | --- |
| Q1 board deck | <url> | @<lead> | 12 months | YYYY-MM-DD |
| Customer-health dashboard | <url> (Looker) | @<analyst> | indefinite | YYYY-MM-DD |
| Vendor contract (PDF stored in Drive) | <url> | @<admin> | 7 years | YYYY-MM-DD |

## Retention policy (adopter-defined)

Set defaults per domain. Examples:

- **Consulting work:** per-engagement (cleared when the engagement closes)
- **Research lab:** until grant audit + 7 years
- **Product team:** 12 months for analytics dashboards, indefinite for active product docs
- **Marketing team:** until campaign ends + 6 months for analysis

When `Retention` expires, the row is moved to `_archive/references-archived.md` and the row in this file is deleted.

## Splitting this file (append-hotspot option)

`references.md` is a single-file append surface — every contributor citing an external artefact writes to it, and at high write volume it becomes a merge-conflict hotspot. If that happens, split it **per-subfolder or per-entry** instead of keeping one flat file:

- `references/<topic>.md` — one file per subject area (e.g. `references/vendor-contracts.md`, `references/dashboards.md`)
- One file per reference under `references/`, named for the artefact

This is an option for domains with heavy external-artefact traffic, not a default — small domains keep the single-file form above.
