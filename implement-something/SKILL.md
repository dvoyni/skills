---
name: implement-something
description: "Offer the next to-do ticket, grill out any gaps in it once accepted, then implement it."
disable-model-invocation: true
---

/implement without an argument: the ticket comes off the tracker, the user accepts it, and it has to prove it is buildable before the build starts.

The issue tracker should have been provided to you. If it wasn't, tell the user to run `/setup-matt-pocock-skills` and stop.

## 1. List the candidates

A candidate is an open ticket labelled `to-do` (locally, the file marked `**Status:** to-do`): the user's mark for a standalone ticket, outside any umbrella or map. It also has to sit on the **frontier**: every blocker closed, nobody assigned. Order the candidates oldest first.

No candidates ends the run: say so, and name what any open `to-do` tickets are waiting on.

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

## 4. Grill the gaps

A buildable ticket goes straight to step 5.

Otherwise call the Skill tool with "grilling", seeding the design tree with the gaps you named. When the user confirms shared understanding, write the decisions into the ticket (sharpen its body, add the criteria it was missing) so the ticket stays the single source of truth for what gets built.

## 5. Build it

Read [`../implement/SKILL.md`](../implement/SKILL.md) and follow it for this ticket alone. When the suite is green, report what was built and point the user at /complete to commit it and resolve the ticket.
