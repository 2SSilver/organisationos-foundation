---
description: Search the harness for relevant existing knowledge before drafting a new piece of work. Retrieval-on-demand for the semantic and episodic memory layers.
---

# find-relevant-knowledge

Before drafting a new piece of work, search the harness for relevant existing knowledge.

## When to run this

On session start for any non-trivial task, run this command against the folders you will touch — `additionalDirectories` gives filesystem reach, not automatic context; substrate only enters context when you retrieve it.

## Steps

1. Take the task description from the operator (or the current session's working context if no description supplied).
2. Extract 3–7 key terms.
3. Grep across:
   - `../organisationos-foundation/` (all subfolders)
   - The current domain's wiki/knowledge folder
   - Any interfaces in `../organisationos-foundation/interfaces/` mentioning the current domain
4. Surface the top 10 matches with a one-line summary each, ranked by recency and relevance.
5. Note any matches in `_archive/` separately, with a banner — archived content is not current and should be verified before reuse.
6. Read the most recent entries of the Foundation `CHANGELOG.md` (the announcement surface for merged non-CDR substrate changes) and surface them alongside the grep results — so an operator whose session started before a recent merge still sees what changed.

## Output

A markdown report with:

```markdown
## Relevant existing knowledge for: <task description>

### Active matches (top 10)
1. [path/to/file.md](path) — one-line summary; last modified YYYY-MM-DD
2. ...

### Archived matches (verify before reuse)
1. [path/_archive/file.md](path) — retired YYYY-MM-DD, reason: <reason>

### No matches?
If none of the matches are relevant, this is a candidate for a new method / pattern. After drafting, run `update-wiki` to flag for promotion consideration.
```

## What this command is NOT

- Not a generative tool. It does not write the draft; it surfaces what already exists.
- Not a replacement for talking to a Domain Lead. If the search returns nothing and the operator is unsure, ask a peer before drafting from scratch.
