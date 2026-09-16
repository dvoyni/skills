---
name: implement-something
description: "Offer the next standalone ticket, reproduce it if it's a bug, grill out any gaps in it, then implement it."
disable-model-invocation: true
---

/implement without an argument: the ticket comes off the tracker, the user accepts it, and it has to prove it is buildable before the build starts.

The issue tracker should have been provided to you. If it wasn't, tell the user to run `/setup-matt-pocock-skills` and stop.

## 1. List the candidates

A candidate is an open **unparented** ticket — nothing above it, no umbrella and no wayfinder map — carrying either mark: `to-do`, the user's hand-picked next job, or `ready-for-agent`, what /to-tickets and /to-spec publish. Locally both marks are the file's `**Status:**` line and the parent is its `**Parent:**` line. A candidate also has to sit on the **frontier**: every blocker closed, nobody assigned. Order the candidates oldest first.

No candidates ends the run: say so, and for every open `to-do` or `ready-for-agent` ticket name what holds it back — a blocker, an assignee, or the umbrella it hangs under.

## 2. Judge the next candidate

Read the ticket, the resolutions on its closed blockers, and the code it touches. A ticket is **buildable** when an agent can build it without guessing at a decision:

- what to build is stated as behaviour, and the codebase shows where it lands;
- every acceptance criterion is checkable: you can say what test or observation proves it;
- every decision the build hinges on (a seam, a data shape, an edge case's outcome) is settled in the ticket, the domain docs, or the code.

A **gap** is a decision that is settled nowhere and belongs to the user. A fact you can look up is legwork, never a gap. The judgement is done when each criterion and each hinge decision is either traced to where it is settled or named as a gap.

## 3. Offer it

Put the ticket to the user and wait for their answer:

```
🎫 **<number>** - **<title>**

<two or three lines: what it builds and why>

<✅ Buildable as written | ❓ Needs grilling: <the gaps, one line each>>

Proceed, or take the next one?
```

**Next**: go to step 2 with the next candidate. Past the last one, say the list is exhausted and stop.

**Proceed**: **claim** the ticket by assigning it to the user where the tracker has assignees, so a parallel session skips it, then go to step 4.

## 4. Reproduce the bug

A ticket that reports existing behaviour as wrong is a **bug**; any other ticket goes straight to step 5.

Make the bug go **red**: drive the reported steps through the most direct observation available (a failing test, a scratch script, the running app) until you see the wrong behaviour yourself. The conditions the ticket leaves implicit (inputs, config, data state) are legwork; vary them before calling it.

The step ends on one of two outcomes:

- **Red**: write the reproduction into the ticket (the steps, what you observed, what should happen instead) so step 6 starts from a known failure. Anything the reproduction reveals that unsettles a hinge decision joins the gaps.
- **Not red** once every condition the ticket names or implies has been tried: add a gap, "doesn't reproduce: <what you tried>". Whether the ticket needs detail, is already fixed, or gets built anyway is the user's call.

Reproduction only observes: the fix waits for step 6.

## 5. Grill the gaps

A ticket with no gaps goes straight to step 6.

Otherwise call the Skill tool with "grilling", seeding the design tree with the gaps you named. When the user confirms shared understanding, write the decisions into the ticket (sharpen its body, add the criteria it was missing) so the ticket stays the single source of truth for what gets built.

## 6. Build it

Read [`../implement/SKILL.md`](../implement/SKILL.md) and follow it for this ticket alone. When the suite is green, report what was built and point the user at /complete to commit it and resolve the ticket.
