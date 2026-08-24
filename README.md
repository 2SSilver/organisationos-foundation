# OrganisationOS — Foundation repo

## 1. What this is

This is the **Foundation repo** of an OrganisationOS three-repo set. It is the substrate layer: every standard, interface, cross-domain decision, and shared workflow lives here and is loaded into every human↔AI-agent session across the organisation via `additionalDirectories`.

The other two repos — Leadership and Domain — reference this repo. Changes here propagate organisation-wide.

---

## 2. Substrate inventory

What lives in Foundation:

| Path | Contents |
| --- | --- |
| `standards/` | Templates (ADR, CDR, NFR, interface), banned-pattern list, coverage gaps |
| `glossary.md` | Terms used across ≥2 domains |
| `interfaces/` | Cross-domain interface contracts |
| `cross-domain-decisions/` | CDRs — records of decisions that affected multiple domains |
| `nfrs/` | Non-functional requirements applying org-wide |
| `architectural-decisions/` | ADRs with org-wide or cross-domain scope |
| `references/patterns/` | Optional methodologies adopters may layer on |
| `.github/workflows/` | Reusable (workflow_call) CI workflows called by Leadership and Domain |
| `.github/agents/` | Cross-vendor agent definitions |
| `.github/hooks/` | Pre-commit hooks (banned-string check) |
| `.claude/commands/` | Shared Claude slash commands |
| `.claude/skills/` | Shared Claude skills |

What does NOT live here: per-domain working content, Leadership strategy/cadence, steward drift log. Those belong in the Domain and Leadership repos.

---

## 3. Clone layout

Recommended layout — all three repos as siblings under one parent folder:

```text
~/projects/<adopter-org>/
  organisationos-foundation/     ← this repo
  organisationos-leadership/     ← Leadership repo
  organisationos-domain/         ← Domain repo (or one per domain if split)
```

**Critical:** do NOT nest these repos inside another project tree (e.g. not inside a PAI workspace mono-folder or another Git repo). Cross-repo `@import` in `CLAUDE.md` resolves via `../organisationos-foundation/CLAUDE.md` — the path must be a top-level sibling, not a deeply nested path.

---

## 4. Role-to-clone-set matrix

| Role | Required clones | `additionalDirectories` pattern |
| --- | --- | --- |
| Team Member / Product Owner / Domain Lead | Domain + Foundation | `["../organisationos-foundation"]` in Domain's `settings.local.json` |
| Leader | All three | `["../organisationos-foundation", "../organisationos-domain"]` from Leadership; or `["../organisationos-foundation", "../organisationos-leadership"]` from Domain |
| Admin | All three (+ per-domain if split-per-domain) | Full set in every clone's `settings.local.json` |

Foundation itself does not need `additionalDirectories` — it is the source, not a consumer.

---

## 5. Adopter onboarding sequence

1. **Clone all three repos** as siblings (see §3 above).
2. **Substitute the org placeholder** — replace `<adopter-org>` with the GitHub owner of your Foundation repo in every caller workflow: `.github/workflows/*.yml` in the **Domain and Leadership** repos (12 and 9 files respectively). Each caller resolves to `<adopter-org>/organisationos-foundation/.github/workflows/<name>.yml@v1`, so until this is substituted the workflow file is invalid and the run fails. Foundation itself has no `<adopter-org>` reference in its workflows — `self-ci.yml` calls its reusables by local path. Also substitute it in `AGENTS.md` in both Domain and Leadership — each carries a functional pointer, `<adopter-org>/organisationos-foundation/.github/agents/`, that Claude resolves via `additionalDirectories`; left unsubstituted, that pointer is dead in both repos.
3. **Bind CODEOWNERS** — replace the `@placeholder-admin`, `@placeholder-leader`, and `@placeholder-domain-N-lead` handles in `.github/CODEOWNERS` with real GitHub handles, in all three repos. These handles appear only in CODEOWNERS, never in the workflows.
4. **Install the pre-commit hook** — the hook ships in Foundation only, as `.github/hooks/banned-string-pre-commit`. Install it in each clone that needs it: `cp <path-to-foundation>/.github/hooks/banned-string-pre-commit .git/hooks/pre-commit && chmod +x .git/hooks/pre-commit`.
5. **Apply label taxonomy** — the taxonomy ships in Foundation as `.github/labels.yml` (§12), together with a `label-sync` workflow that applies it. Copy both into any repo that lacks them, then run label-sync there. Run `gh workflow run label-sync.yml` once per repo (or trigger it from the Actions tab). It is idempotent, so re-run it whenever `labels.yml` changes. Labels are for triage and for the workflows that apply them programmatically — since AR-09 no CI gate depends on a label being present, so a missing label costs searchability, not enforcement.
6. **Enable Actions** — do this only after step 2. Actions are disabled on the published Domain and Leadership template repos precisely because the unsubstituted `<adopter-org>` placeholder makes every caller invalid; a repo created from the template starts with Actions enabled, so substitute first or expect a wave of invalid-workflow failures. Foundation's `self-ci.yml` triggers on `pull_request` only, so pushing to `main` produces no runs — that is expected, not a misconfiguration.
7. **Configure personal context** — the role→`additionalDirectories` mapping has one canonical source: the 5 role-specific files in `standards/templates/onboarding/`. Copy the file matching your role (`settings.local.json.example-<role>` — e.g. `settings.local.json.example-domain-lead`) to `.claude/settings.local.json` in each clone you will work from. Also copy the matching `claude-local-<role>.example.md` to `CLAUDE.local.md`. Do not use a bare repo-root `.claude/settings.local.json.example` — where one exists it is a pointer to this onboarding folder, not a second source of the mapping. On a role change (promotion, a domain added), re-copy from the updated onboarding file rather than hand-editing `additionalDirectories` — see the monthly-DRI checklist.
8. **First onboard** — run the Foundation onboard command: `/onboard` from a Claude session launched in this repo.

---

## 6. Repository structure

```text
organisationos-foundation/
  CLAUDE.md                        ← canonical substrate rules (loaded by all three repos)
  AGENTS.md                        ← cross-vendor agent baseline
  FORMATS.md                       ← format whitelist
  README.md                        ← this file
  glossary.md                      ← cross-domain terminology
  .gitignore
  standards/
    templates/
      adr-template.md
      cdr-template.md
      nfr-template.md
      interface-template.md
      back-flow-template.md
    banned-patterns.yml
    coverage-gaps.md
  interfaces/                      ← cross-domain interface contracts
  cross-domain-decisions/          ← CDRs
  nfrs/                            ← org-wide non-functional requirements
  architectural-decisions/         ← org-wide / cross-domain ADRs
  references/
    patterns/                      ← optional methodology overlays
  .github/
    CODEOWNERS
    PULL_REQUEST_TEMPLATE.md
    ISSUE_TEMPLATE/
    workflows/                     ← reusable (workflow_call) CI definitions
    hooks/                         ← pre-commit hooks
    agents/                        ← cross-vendor agent definitions
  .claude/
    commands/                      ← shared slash commands
    skills/                        ← shared skills
    settings.json
    settings.local.json.example
```

---

## 7. Generic worked example — GreenLeaf Research Lab

GreenLeaf Research Lab runs four domains: **research**, **operations**, **fundraising**, and **compliance**. Each domain has a Domain Lead, plus one Leader and one Admin.

A researcher on the research domain proposes a shared anonymisation standard — a method for removing identifying details from published datasets before they enter any domain's working folder. This is a cross-domain concern (research produces data, operations stores it, compliance signs off, fundraising references outcomes).

The researcher drafts a CDR using `standards/templates/cdr-template.md` and opens a PR in Foundation. The PR triggers the `cdr-review` CI check. One Leader plus the Domain Lead of each affected domain (research, operations, compliance) review the PR. On merge, Admin opens a propagation log entry in the Leadership repo (`cadence/propagation-log.md`) and opens implementation PRs in the Domain repo for the three affected domains. Each Domain Lead merges their domain's implementation PR independently.

The anonymisation standard is now in `standards/`, referenced by domain-level ADRs, and enforced by the banned-string check.

---

## 8. Where to find a worked instance

No worked instance is currently committed in this workspace. Once your organisation's concrete instance is instantiated, replace this pointer with a link to it.
