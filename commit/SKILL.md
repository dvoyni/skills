---
name: commit
description: "Stage everything and commit it with a one-line message from session context."
disable-model-invocation: true
---

Commit this session's work in **one** Bash call:

```
git add -A && git commit -m "<subject>"
```

`<subject>` is one short lowercase line naming what changed, written from what you did this session. No body, no trailer, no quotes or backticks inside it.

Rules:

- Make no other tool calls. No `git status`, `git diff`, or `git log` — you already know what changed, and re-reading it is the whole cost this skill exists to avoid.
- Commit on the current branch. Do not create a branch, even on `main`.
- If the commit fails (nothing staged, a hook, not a repo), report the error verbatim and stop. Do not investigate.

Then say the short hash and what you committed, in one sentence.
