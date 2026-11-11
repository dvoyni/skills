---
name: check-rules
description: "Check the change against every rule the repo's agent docs set, and fix what breaks one."
disable-model-invocation: true
---

Hold the change to every rule the repo binds its agents to: the shared rules (often a `rules` submodule) and the project's own. Fix each break that needs no decision; put the rest to the user.

## 1. Pin the change

By default the change is the uncommitted work: `git diff HEAD`, plus the untracked files that belong to it (`git ls-files --others --exclude-standard`). Given a fixed point (a branch, tag or SHA), it is everything since: `git diff $(git merge-base <fixed-point> HEAD)` plus those untracked files, and the commit messages of `git log <fixed-point>..HEAD` are part of it.

The check judges only what the change introduces. A rule the code already broke before the change stays as it is, unmentioned. No change: say so and stop.

## 2. Gather the rules

A **rule** is any instruction a repo's agent docs give about how its code or its work should be. Its sources:

- The root `CLAUDE.md` / `AGENTS.md`, and every file it imports (`@path`) or says to read and follow: the rules submodule's files, wherever it sits.
- Every `CLAUDE.md` / `AGENTS.md` in a directory between a changed file and the root: project rules sit nearest the code they govern.
- A doc behind a conditional pointer ("read `docs/architecture.md` before changing threads"), when the change meets the condition.

A **potential rule** (one under `## Potential rules`) is checked like any other.

Where two rules disagree, the precedence the docs state decides; where they state none, the rule nearer the code wins.

Read every source not already in context. No source at all: say so and stop.

## 3. Judge every rule

Give every rule in every source a **verdict** against the change:

- **n/a**: the change touches nothing the rule governs.
- **holds**
- **broken**, at `file:line`.
- **unclear**: whether or how the rule reaches this change is a judgement the user owns.

A change breaks a rule by what it lacks as readily as by what it holds: the README update a new dependency owes, the CHANGELOG entry a public API change owes.

A rule about how the agent works is judged by the **trace** it leaves in the change: scope beyond what this session was asked, a commit message in the range, a doc the work should have updated. A work rule that leaves no trace is n/a.

Done when every rule in every source has a verdict.

## 4. Fix the breaks

Fix each broken rule whose fix keeps behaviour as it is and has one obvious form: a rename, code moved to the file the rule names, a helper inlined, the entry a doc is owed. Where the rule gives an example, the fix follows it.

A fix that would change behaviour (dropping unasked-for scope, changing an error a caller sees), or that has to choose between ways of meeting the rule, belongs to the user: leave the code and carry the break to the report.

Typecheck after each fix, and re-judge the rules it touches: a fix can break another rule. Once every fix is in, run the full suite; if it goes red, find the fix responsible, undo it, and carry its break to the report.

Gate: typecheck is clean and the full suite is green.

## 5. Report

- **Fixed**: one line per fix: the rule (its file and a few of its words), where, what changed. Mark a fix made under a potential rule **potential**, so the user can confirm or drop that rule.
- **For you**: each break left unfixed and each unclear verdict, with the options the user is choosing between.

A clean change gets one line: how many rules were checked, from which files, and that none was broken.
