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
| `commit` | Stage everything and commit it with a one-line message from session context. |
| `complete` | Commit the session's work, then write its resolution back into the tickets it came from. |
| `domain-modeling` | Build and sharpen a project's domain model; `CONTEXT.md` and ADRs. |
| `grilling` | Interview relentlessly to stress-test a plan or idea. |
| `grill-me` / `grill-with-docs` | Grilling on demand; `grill-with-docs` also writes ADRs and glossary entries as it goes. |
| `handoff` | Compact the conversation into a handoff document for another agent. |
| `implement` | Implement a piece of work from a spec or set of tickets. |
| `implement-something` | Offer the next standalone `to-do` / `ready-for-agent` ticket; once accepted, reproduce it if it's a bug, grill out its gaps and build it. |
| `implement-all` | Build every ticket under an umbrella in parallel branches, merged back as each lands. |
| `improve-codebase-architecture` | Scan for deepening opportunities, report them as visual HTML, then grill through the one you pick. |
| `prototype` | Build a throwaway prototype to answer a design question. |
| `research` | Investigate against primary sources; capture findings as Markdown. |
| `resolving-merge-conflicts` | Resolve an in-progress merge or rebase. |
| `tdd` | Test-driven development. |
| `teach` | Teach a new skill or concept within this workspace: missions, glossaries, learning records. |
| `to-spec` / `to-tickets` | Turn intent into a spec, and a spec into tickets. |
| `wayfinder` | Plan work too big for one session as a map of decision tickets, resolve them one by one, then hand the map over as the umbrella for implementation tickets. |
| `writing-for-agents` | How to write any document an agent consumes. |

## Credit and licence

Adapted from [`mattpocock/skills`](https://github.com/mattpocock/skills) by Matt Pocock, MIT licensed. Several skills here started as his and have been reworked; the rest are new. See [LICENSE](LICENSE), which carries both copyright notices.

## Writing more

`writing-for-agents` is the reference the rest are written against: context pointers, the information hierarchy, completion criteria, leading words, pruning.
