# .claude/agents/ — Claude Code mirror

These agent definitions mirror `.github/agents/` (the Copilot-CLI-native location). Claude Code reads `.claude/agents/`, so the harness ships this mirror; `self-ci.yml`'s `agent-mirror-sync` job fails a PR if the two folders differ.

**Source of truth:** `.github/agents/`. When you edit an agent definition, edit it in `.github/agents/` and copy the change here so both stay identical. The monthly maintenance issue (docs/setup-org.md → Step 8) includes a check that the two folders have not drifted.

Adopters on Cursor / Codex CLI invoke the same agents via their tool's mechanism (skills, prompt files, etc.).
