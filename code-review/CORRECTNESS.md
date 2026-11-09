# Correctness

How the Correctness sub-agent reviews the diff. The axis asks one question: does the change work, for every input and caller it will meet? It judges the code against its own contract (its callers, its tests, the data it handles); conformance to the spec and to the style guide belongs to the other axes.

## How to hunt

Reach past the diff: for every changed function, read its callers, what it calls, and the tests that cover it. Infer intent from the commit messages and the tests.

Each finding names its **trigger** (the input, state, or call path that breaks it) and its **consequence** (what a user or the system then sees).

## What to hunt

- **Edge cases**: empty, null, zero, negative, one, the maximum, duplicates, unicode; off-by-one at every boundary.
- **Error paths**: errors swallowed (an empty `catch`), retried forever, or leaving state half-written; cleanup skipped on the failure path.
- **State and concurrency**: races, check-then-act, stale caches, ordering assumptions, retries that aren't idempotent.
- **Contract breaks**: a changed signature, return shape, default, or side effect that an unchanged caller still relies on.
- **Security**: untrusted input (requests, uploads, env, third-party responses, LLM output) reaching a query, shell, path, template, or redirect unvalidated; a missing authentication or authorization check (can one user reach another's data?); secrets in code, logs, or error messages.
- **Performance**: a query or call per row (N+1), an unbounded fetch or loop, a list endpoint without pagination, blocking I/O on a hot path, work redone on every render or iteration.
- **Dependencies**: a new dependency the existing stack already covers; a version bump whose changelog carries a breaking change; a lockfile change the manifest change doesn't explain.
- **Tests**: changed behaviour with no test through its public interface; tests that are implementation-coupled (break on a refactor while behaviour holds) or tautological (the expected value recomputed the way the code computes it); a bug fix with no regression test that fails without the fix.

## Severity

**Critical** needs a realistic trigger; a merely possible one caps the finding at **Required**. Changed behaviour no test covers is **Required**; hardening the code doesn't strictly need is **Consider**.
