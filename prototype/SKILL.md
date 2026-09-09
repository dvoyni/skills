---
name: prototype
description: Build a throwaway prototype to answer a design question. Use when the user wants to sanity-check a state model or logic, explore what a UI should look like, greybox a scene, tune how a mechanic feels, or dial in a visual effect.
---

# Prototype

A prototype is **throwaway code that answers a question**. The question decides the shape.

## Pick a branch

Read the question off the prompt and the surrounding code. The codebase usually settles it, since a backend module and a game engine ask different questions and nobody greyboxes a web app. Ask only when it is genuinely ambiguous.

- **"Does this logic / state model hold up?"** → [LOGIC.md](LOGIC.md). A single shareable HTML file that pushes a state machine, economy, or data model through the cases that are hard to reason about on paper, and that a non-developer can drive.
- **"What should this look like?"** → [UI.md](UI.md). Several radically different variations of one surface, live-switchable, so structural alternatives can be compared against each other.
- **"Does this space read?"** → [GREYBOX.md](GREYBOX.md). Untextured geometry at true scale, walked with the real camera and controller.
- **"Does this feel good to play?"** → [FEEL.md](FEEL.md). One mechanic alone in a bare scene, every number tunable mid-play.
- **"Does this effect look right?"** → [VFX.md](VFX.md). One effect isolated at near-target fidelity, its parameters exposed.

The branches produce very different artifacts, so getting this wrong wastes the whole prototype. Two pairs are worth separating carefully: a mechanic tested in a hand-built level answers about the level, not the mechanic; and a look judged in grey answers nothing at all.

## Fidelity matches what is being judged

**Grey** when the answer is about space, mechanics, or systems. Flat untextured materials, no art direction, no lighting polish, whatever the geometry came from. Stripping the look is what forces the eye onto layout, timing, and traversal instead of onto the art.

**Near-target** when the answer is about how something looks. Real lighting, representative assets, the effect sitting in the context it will ship in.

Two rules fall out of this:

- **Scale is always true**, at either fidelity. Character height, door width, jump distance, camera height. A prototype at the wrong scale answers wrongly and convincingly, which is worse than not answering.
- **Sourcing is free at grey fidelity, and asked for at near-target.** Grey work needs a stand-in of the right size, so take it from wherever is fastest: reuse what the project already has, generate it, drive Blender or Studio over MCP, or pull a public asset. Near-target work judges the actual look, so a substituted asset makes the verdict wrong rather than approximate. Ask the user for the real assets and wait.

## Rules that apply to every branch

1. **Throwaway from day one, and clearly marked.** Put the prototype next to what it is prototyping for, so its context is obvious, and name it so a casual reader sees it is not production. Follow whatever routing, scene, or module convention the project already uses.
2. **Trivial to run.** One command in the project's task runner, one double-clicked HTML file, or one already-open editor scene. No thinking required to start it.
3. **No persistence by default.** State lives in memory. Persistence is the thing the prototype is _checking_, not something it should depend on. If the question is specifically about persistence, hit a scratch store with a clear "PROTOTYPE, wipe me" name.
4. **Skip the polish.** No tests, no error handling beyond what makes it runnable, no abstractions. The point is to learn something fast.
5. **Surface the state.** After every action, render the full relevant state so the change is visible. In an engine this becomes on-screen instrumentation.

## Capture it when done

Fold the validated decision into the real code. Then capture the prototype itself as a **primary source**, and capture the answer with it: the verdict, and the question it settled.

- **Where there is a repo and the artifact is committable**: commit the prototype to a throwaway branch, out of main, and leave a context pointer to that branch wherever the implementation is tracked. The main branch keeps only the validated decision.
- **Otherwise** (no repo, or the artifact is a binary place file or an unreviewable scene): leave the prototype in place and re-runnable, with an explicit removal condition written beside it. Delete it once the user says so.

A screenshot and the written verdict get captured either way: a spatial or visual answer is unreconstructable from prose. Where there is no repo, both land in the project's `CONTEXT.md`, alongside the other hard-won facts.
