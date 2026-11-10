---
name: impl
description: "Implement a spec or tickets, then simplify the change."
disable-model-invocation: true
---

/implement, then /simplify, as one run. Simplify starts only once implement has met its gate. A question is a pause; a missed gate is a full stop: report where the run got to and what stopped it.

`implement` is a user entry point, reserved from the Skill tool, so the run follows its document instead.

1. **Implement.** Read [`../implement/SKILL.md`](../implement/SKILL.md) and follow it for the user's spec or tickets. Gate: what it took on is built, typecheck is clean, and the full suite is green.
2. **Simplify.** Call the Skill tool with "simplify" for the uncommitted change. Keep only the simplifications the suite stays green under; undo any that turn it red. Gate: typecheck is clean and the full suite is green.
3. **Hand over.** Report what was built and simplified. Once the user is satisfied, /complete commits the work and resolves the tickets.
