---
name: implement
description: "Implement a piece of work based on a spec or set of tickets."
disable-model-invocation: true
---

Implement the work described by the user in the spec or tickets.

**Given an umbrella** — a ticket whose body lists child tickets, a wayfinder map included — implement **one child per session**: take the first open child whose blockers are all closed, and build that one. Say which child you took and what stays open. To burn through the whole set in one burst, use /implement-all.

Use /tdd where possible, at pre-agreed seams.

Run typechecking regularly, single test files regularly, and the full test suite once at the end.

Do not commit anything.
