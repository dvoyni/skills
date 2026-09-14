---
name: implement-all
description: Burn through every ticket nested under an umbrella in one run: dependency order, the whole frontier built in parallel on branches, each merged back as it lands, pausing only on a question a builder can't answer.
disable-model-invocation: true
---

A **burst**: every ticket under one umbrella, built by fresh agents, one per ticket, each on its own branch. It is /implement in a loop; what the loop adds is the dependency order, a clean context and worktree per ticket, a merge per landing, and a rule for where to stop.

The argument is the umbrella: a ticket whose body lists child tickets (a to-tickets umbrella, a handed-over wayfinder map). A child that is itself an umbrella expands into its own children.

`implement`, `complete` and `commit` are user entry points, reserved from the Skill tool. The burst follows their documents instead, the way complete itself follows commit.

## The loop

1. **Read the tree.** Fetch the umbrella and every ticket beneath it, recursively, with each ticket's blocking edges. Report the running order before you build anything: the **frontier** (open, every blocker closed), and what each ticket unblocks.
2. **Dispatch the whole frontier**, one fresh subagent per ticket, in a single message so they build concurrently. Each gets a worktree of its own, branched from the current HEAD: the harness's worktree isolation where it has one, else `git worktree add <temp dir outside the repo> -b burst/<ticket>`. Tell each builder, passing resolved paths since it isn't sitting in the skills directory:
   - Read [`../implement/SKILL.md`](../implement/SKILL.md) and follow it for that ticket alone.
   - A fresh worktree has none of the untracked state (installed dependencies, env files); set it up the way the repo does before building.
   - Once the suite is green, follow [`../commit/SKILL.md`](../commit/SKILL.md) on its branch. A branch lands only what's committed, so this overrides implement's no-commit rule.
   - Stay off the tracker. Every ticket update goes through the burst, so parallel builders never race on the umbrella's tick list.
   - Return the branch name and worktree path.

   The subagent cannot reach the user: a builder that needs a human answer (a seam to agree, an ambiguity the spec never settled) returns the question rather than guessing at it. Put it to the user, then re-dispatch the ticket with the answer. A question pauses its ticket while the rest build on; a burst left running alone simply waits there.
3. **Land each builder as it returns**, one at a time, in this worktree:
   1. `git merge --no-ff --no-commit <branch>`. Resolve a conflict with /resolving-merge-conflicts.
   2. Run the full suite on the merged tree: a clean textual merge can still break.
   3. **Green**: read [`../complete/SKILL.md`](../complete/SKILL.md) and follow it exactly for that ticket; its commit concludes the merge, and the tracker tells the truth mid-burst. Then remove the worktree and delete the branch.
      **Red**: `git merge --abort` and keep the branch. The ticket hasn't landed.
4. **Roll the frontier.** After each landing, re-read the tree and dispatch whatever it unblocked, from the new HEAD. The burst is over when no ticket under the umbrella is open.

## Where the burst stops

Stop at the first ticket that doesn't land: the merged suite stays red, a conflict has no plain resolution, the work is blocked on something absent, or the ticket turns out to need a decision rather than an implementation. A question is a pause, this is a full stop: dispatch nothing more. Builders already in flight finish and land through the same gate, since each merge proves itself green. Leave every unlanded ticket open with a resolution naming what stopped it and its branch, then report where the burst got to, what landed, and what remains. A run that pushes past a red suite spreads the damage across every ticket after it.
