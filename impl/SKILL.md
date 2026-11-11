---
name: impl
description: "Implement a spec or tickets, simplify the change, then check it against the repo's rules."
disable-model-invocation: true
---

/implement, then /simplify, then /check-rules, as one run. Each stage starts only once the one before has met its gate. A question is a pause; a missed gate is a full stop: report where the run got to and what stopped it.

`implement` and `check-rules` are user entry points, reserved from the Skill tool, so the run follows their documents instead.

1. **Implement.** Read [`../implement/SKILL.md`](../implement/SKILL.md) and follow it for the user's spec or tickets. Gate: what it took on is built, typecheck is clean, and the full suite is green.
2. **Simplify.** Call the Skill tool with "simplify" for the uncommitted change. Keep only the simplifications the suite stays green under; undo any that turn it red. Gate: typecheck is clean and the full suite is green.
3. **Check the rules.** Read [`../check-rules/SKILL.md`](../check-rules/SKILL.md) and follow it for the uncommitted change. It runs last because a simplification can break a rule. Gate: every rule has a verdict, typecheck is clean, and the full suite is green.
4. **Hand over.** Report what was built and simplified, then check-rules' report. Once the user is satisfied, /complete commits the work and resolves the tickets.
