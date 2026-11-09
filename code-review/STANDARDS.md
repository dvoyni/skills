# Standards

How the Standards sub-agent reviews the diff: against the repo's documented coding standards, and against a fixed baseline of code smells.

## Rules

- **The repo overrides.** A documented repo standard always wins; where it endorses something the baseline would flag, suppress the smell.
- **Documented standards cite their source.** A breach names the file and the rule, and is **Required**; where the standard is itself phrased as a preference, it is **Consider**.
- **Smells are always judgement calls.** Name each as a labelled heuristic ("possible Feature Envy"), quote the hunk, and rate it **Consider**.
- **Leave tooling's work to tooling.** Skip anything a linter, formatter, or type checker already enforces.

## Smell baseline

Each smell reads _what it is_ → _how to fix_; match it against the diff.

Fowler's (_Refactoring_, ch.3):

- **Mysterious Name**: a function, variable, or type whose name doesn't reveal what it does or holds. → rename it; if no honest name comes, the design's murky.
- **Duplicated Code**: the same logic shape appears in more than one hunk or file in the change, or re-implements a helper or pattern the codebase already has. → extract the shared shape, or call the existing one.
- **Feature Envy**: a method that reaches into another object's data more than its own. → move the method onto the data it envies.
- **Data Clumps**: the same few fields or params keep travelling together (a type wanting to be born). → bundle them into one type, pass that.
- **Primitive Obsession**: a primitive or string standing in for a domain concept that deserves its own type. → give the concept its own small type.
- **Repeated Switches**: the same `switch`/`if`-cascade on the same type recurs across the change. → replace with polymorphism, or one map both sites share.
- **Shotgun Surgery**: one logical change forces scattered edits across many files in the diff. → gather what changes together into one module.
- **Divergent Change**: one file or module is edited for several unrelated reasons. → split so each module changes for one reason.
- **Speculative Generality**: abstraction, parameters, or hooks no current caller needs (an interface with one implementation, a flag only ever passed one value). → delete it; inline back until a real need shows.
- **Message Chains**: long `a.b().c().d()` navigation the caller shouldn't depend on. → hide the walk behind one method on the first object.
- **Middle Man**: a class or function that mostly just delegates onward. → cut it, call the real target direct.
- **Refused Bequest**: a subclass or implementer that ignores or overrides most of what it inherits. → drop the inheritance, use composition.
- **Large Class**: the change piles more onto a class or file that is already large (a file past roughly 1000 lines is the usual signal). → extract helpers or modules first, then add.

And the ones agent-written changes are most prone to:

- **Relocated Complexity**: a refactor that moves logic without reducing what a reader must hold in mind: the same branches, modes, and layers survive in a new place. → choose the restructuring that makes branches, modes, or layers disappear; delete an abstraction rather than polish it.
- **Misplaced Logic**: feature-specific logic (often a new `if`) threaded into a shared module or an unrelated flow, or a shared module now importing from a feature. → move it to the module that owns the concept, behind its own helper or policy.
- **Silent Fallback**: an `any`, a cast, a needless optional, or a quiet default (`?? ''`, `|| 0`) papering over an invariant nobody pinned down. → make the boundary's type explicit and fail loudly; downstream branching often disappears.
- **Dead Code**: code the change left unreachable or unreferenced: a superseded function, an orphaned constant, a compat shim, a `// removed` comment. → delete it.
- **Tangled Change**: the diff mixes a refactor with a behaviour change. → split it: land the refactor first, then the behaviour.
