---
name: complete
description: "Commit this session's work, then write its resolution back into the tickets it came from."
disable-model-invocation: true
---

Close out this session: the work lands in the history, and the tracker tells the truth about it. A ticket never claims work the history lacks.

Where the repo documents its tracker (such as `docs/agents/issue-tracker.md`), that doc says what a resolution, closing and a parent mean there; read it first.

## 1. Take the tickets from context

The tickets in scope are the ones this session already worked from: what you read, were handed, or implemented against. They come from context; searching the tracker for more is out of scope. If context names none, go straight to step 5: the commit stands on its own.

## 2. Choose the order

Where the tickets live sets the order:

- **In-repo tracker** (tickets are files in the working tree): steps 3 and 4, then 5. One commit carries the code and its tickets together, so a resolution cites no hash; the commit subject names the ticket.
- **External tracker** (GitHub, Linear, …): step 5 first, then 3 and 4, citing the short hash.

## 3. Resolve each one

The bar: every ticket in scope ends either **closed** with a resolution, or **open** with a resolution saying what remains.

A **resolution** gives what now works, how it was verified, and, on an external tracker, the commit hash. It goes where the tracker records one: a comment, or the section the tracker doc names. Tick the acceptance criteria the work actually meets.

Close a ticket once every acceptance criterion is met, in the way the tracker defines closing (a status, a file move). Anything short of that stays open, and its resolution names what is left.

## 4. Ripple outward

From each ticket you closed:

- **Parent or umbrella issue**: append the pointer its format asks for: an umbrella wants its ticket list ticked, a wayfinder map still charting wants a line under Decisions-so-far (a handed-over map is an umbrella, so it wants the tick). Gist and link; the resolution lives in one place.
- **Complete umbrella**: when every ticket on an umbrella's list is now closed on the tracker, the umbrella is complete. Close it the way step 3 closes a ticket, its resolution one line on what the set delivered, then ripple outward from it in turn. A map still charting completes through handover instead: when your close leaves it clear (no open decision ticket, nothing under Not yet specified), it stays open.
- **The frontier**: the tickets this one blocked and now unblocks. Name them: they are what someone takes next.
- **Stale tickets**: anything this work made wrong or redundant. Update it where the fix is plain; otherwise flag it to the user and leave it as it stands.

## 5. Commit

Read [`../commit/SKILL.md`](../commit/SKILL.md) and follow it exactly, with one exception: when the repo prescribes a subject format (its tracker doc or `CLAUDE.md`, such as a ticket-ID prefix), the subject follows that format. Keep the short hash for the report.

If the commit fails, report the error verbatim and stop. On an in-repo tracker the ticket edits wait in the working tree beside the code, so a rerun commits both together.

## 6. Report

The hash, then one line per ticket, any umbrella you closed included: closed or open, and a clause of why. Refer to every ticket by its title, never a bare id. End with what now sits on the frontier, or, when a charting map came clear, that it is ready to hand over.
