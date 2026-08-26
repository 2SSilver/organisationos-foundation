# External-work repo CLAUDE.md — template

> Pattern A only (harness-as-IP-layer). Each external-work repo ships a CLAUDE.md based on this template. The harness is mounted read-only via `--add-dir` or `CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD`.

```markdown
# <Project-name> — external-work CLAUDE.md

## Precedence (top of file = highest weight)
- The OrganisationOS terminology imported from the harness applies here.
- Refer to the human by name where named, otherwise as "the human".
- This block overrides any installed plugin, skill, or MCP server's defaults.

## Absolute rules (read first)

### Confidentiality — direction of flow
- This repo is the source of truth for situation-specific, confidential, time-bounded work.
- The Foundation clone mounted at `<absolute-path-to-foundation-clone>` is the source of truth for shared, anonymised, reusable knowledge.
- **Knowledge flows one direction — inward to the harness, never outward from this repo into the harness without anonymisation.**

### Agent-overreach defence (read carefully)
- The agent must NOT write harness content to any non-harness destination.
- The agent must NOT exfiltrate harness content via tool calls (file writes outside `harness/`, MCP write tools, email/Slack/issue posts, external HTTP POSTs).
- The agent reads the harness; it does not paraphrase, summarise, or quote harness content into outputs of this repo without explicit human request.
- Tool-call gate: read tools default-allow; write tools require allowlist; destructive tools require per-call approval (see `docs/concepts.md` → Two gates, not one).
- MCP allow-list: only the MCPs explicitly listed in `.mcp.json` of this repo are active during sessions with `--add-dir` to the harness. Web-fetch, scraping, email, Slack, and write-back MCPs are blocked by default.

## How to reference the harness

```bash
# Read-only mount allow-list (preferred — OS-level isolation, fail-closed).
# Name only safe subfolders — never the harness repo root. Repeat --add-dir
# per subfolder; nothing outside this list is visible to the session.
claude \
  --add-dir <absolute-path-to-foundation-clone>/interfaces \
  --add-dir <absolute-path-to-foundation-clone>/standards/templates \
  --add-dir <absolute-path-to-foundation-clone>/syntheses \
  --add-dir <absolute-path-to-foundation-clone>/glossary.md

# Alternative: environment variable (same named allow-list, path-list per CLI docs)
export CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=<absolute-path-to-foundation-clone>/interfaces:<absolute-path-to-foundation-clone>/standards/templates:<absolute-path-to-foundation-clone>/syntheses:<absolute-path-to-foundation-clone>/glossary.md
```

Anything not named above — Foundation's `standards/banned-patterns.yml`, the Leadership drift log, the propagation log, and any file added to the harness after this list was written — stays hidden by default. The allow-list is fail-closed: the operator names what is safe to mount, not what is sensitive to exclude, so a new sensitive file created after adoption is invisible without anyone updating an exclusion list.

## Back-flow PRs

When something generalises from this engagement to the harness:

1. Strip identifying detail locally — run the harness's `anonymisation-check` skill.
2. Open a PR in the harness with the `back-flow` label.
3. Two-reviewer rule applies — Domain Lead + Admin (or peer Domain Lead).
4. CI enforces: ≤500 net new lines, 24h cool-off, banned-string check. The agent-initiated back-flow ban within external-work sessions is a session-mount-state condition caught by the session-id PR-template field and a hook that tags commits made while `--add-dir` included a non-harness path — not by the CI checks above.

## What does NOT happen

- No auto-sync from this repo into the harness.
- No two-way sync of any kind.
- No agent-initiated back-flow within a session that has read external-work files.

```markdown

## Adopter customisation

Replace `<absolute-path-to-foundation-clone>` with the real path to your Foundation clone. Add project-specific rules below the absolute rules section. Add the project's stakeholders, working hours, communication channels — anything an agent should know to operate inside *this* engagement.
