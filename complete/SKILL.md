---
name: complete
description: "Commit this session's work, then write its resolution back into the tickets it came from."
disable-model-invocation: true
---

Close out this session: commit the work, then leave the tracker telling the truth about it.

## 1. Commit

Read [`../commit/SKILL.md`](../commit/SKILL.md) and follow it exactly. Keep the short hash — the resolution cites it.

If the commit fails, report the error and stop here. A ticket must never claim work that isn't in the history.

## 2. Take the tickets from context

The tickets in scope are the ones this session already worked from: what you read, were handed, or implemented against. They come from context; searching the tracker for more is out of scope. If context names none, say so and stop — the commit stands on its own.

## 3. Resolve each one

The bar: every ticket in scope ends either **closed** with a resolution, or **open** with a resolution saying what remains.

A **resolution** is a comment on the ticket giving what now works, how it was verified, and the commit hash. Tick the acceptance criteria the work actually meets.

Close a ticket once every acceptance criterion is met. Anything short of that stays open, and its resolution names what is left.

## 4. Ripple outward

From each ticket you closed:

- **Parent or map issue** — append the pointer its format asks for (a wayfinder map wants a line under Decisions-so-far). Gist and link; the resolution lives in one place.
- **The frontier** — the tickets this one blocked and now unblocks. Name them: they are what someone takes next.
- **Stale tickets** — anything this work made wrong or redundant. Update it where the fix is plain; otherwise flag it to the user and leave it as it stands.

## 5. Report

The hash, then one line per ticket: closed or open, and a clause of why. Refer to every ticket by its title, never a bare id. End with what now sits on the frontier.
