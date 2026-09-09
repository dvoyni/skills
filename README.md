# skills

Personal [Claude Code](https://claude.com/claude-code) skills.

Each directory is one skill: a `SKILL.md` with frontmatter, plus any reference files it discloses behind a pointer.

## Install

Symlink the repo into place:

```bash
ln -s /path/to/skills ~/.claude/skills
```

On Windows (PowerShell, as administrator):

```powershell
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.claude\skills" -Target "C:\path\to\skills"
```

## Skills

| Skill | What it does |
| --- | --- |
| `code-review` | Review changes since a fixed point, against standards and against spec. |
| `codebase-design` | Shared vocabulary for designing deep modules. |
| `commit` | Write a commit. |
| `complete` | Finish and verify work in progress. |
| `domain-modeling` | Build and sharpen a project's domain model; `CONTEXT.md` and ADRs. |
| `grilling` | Interview relentlessly to stress-test a plan or idea. |
| `grill-me` / `grill-with-docs` | Grilling variants. |
| `handoff` | Hand work to another session. |
| `implement` | Carry out a planned change. |
| `improve-codebase-architecture` | Survey and improve architecture. |
| `prototype` | Build a throwaway prototype to answer a design question. |
| `research` | Investigate against primary sources; capture findings as Markdown. |
| `resolving-merge-conflicts` | Resolve an in-progress merge or rebase. |
| `tdd` | Test-driven development. |
| `teach` | Structured teaching: missions, glossaries, learning records. |
| `to-spec` / `to-tickets` | Turn intent into a spec, and a spec into tickets. |
| `wayfinder` | Map work into a tree of agent-sized tickets. |
| `writing-for-agents` | How to write any document an agent consumes. |

## Credit and licence

Adapted from [`mattpocock/skills`](https://github.com/mattpocock/skills) by Matt Pocock, MIT licensed. Several skills here started as his and have been reworked; the rest are new. See [LICENSE](LICENSE), which carries both copyright notices.

## Writing more

`writing-for-agents` is the reference the rest are written against: context pointers, the information hierarchy, completion criteria, leading words, pruning.
