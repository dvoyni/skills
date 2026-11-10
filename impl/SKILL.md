---
name: impl
description: "Implement a spec or tickets, then simplify and review the change."
disable-model-invocation: true
---

/implement, then /simplify, then /code-review, as one run. Each stage starts only once the stage before it has met its gate. A question is a pause; a missed gate is a full stop: report where the run got to and what stopped it.

`implement` is a user entry point, reserved from the Skill tool, so the run follows its document instead.

1. **Pin the fixed point.** Record `git rev-parse HEAD` before anything changes. Implement commits nothing, so the run's whole output is the uncommitted change on top of that commit. A tree that is already dirty would mix earlier work into simplify and review: ask whether that work belongs to this run before starting.
2. **Implement.** Read [`../implement/SKILL.md`](../implement/SKILL.md) and follow it for the user's spec or tickets. Gate: what it took on is built, typecheck is clean, and the full suite is green.
3. **Simplify.** Call the Skill tool with "simplify" for the uncommitted change. Keep only the simplifications the suite stays green under; undo any that turn it red. Gate: typecheck is clean and the full suite is green.
4. **Review.** Call the Skill tool with "code-review", giving it the recorded commit as the fixed point and the same spec or tickets, so it has nothing to ask. The run ends on its report and verdict: fixing findings is the user's call, and once they're done, /complete commits the work and resolves the tickets.
