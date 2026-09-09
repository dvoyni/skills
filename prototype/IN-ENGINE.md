# In-engine prototypes

Shared reference for the three branches that build a scene rather than a page: [GREYBOX.md](GREYBOX.md), [FEEL.md](FEEL.md), [VFX.md](VFX.md). Read it alongside whichever one is running.

Engine-specific facts (build tags, importer quirks, coordinate conversions, asset limits) belong in the project's own `CONTEXT.md` or `AGENTS.md`, not here.

## Grip

**Grip** is how you get your hands on the scene, and it decides what you can verify for yourself. Establish it before building anything, because it changes the process far more than the engine's syntax does.

- **Scene-as-code** — the scene is source. Write it, run it, read the output. Full authorship, diffable, and re-running after an edit is the whole loop. Prefer parameters over literals so a change is a number, not a rewrite.
- **Agent-driven editor** — the editor is reachable over MCP. Build the scene through the tools, then **screenshot your own work and look at it** before handing over. This closes the loop without the user: a greybox with a floating wall is visible immediately and cheap to fix, and shipping one unlooked-at wastes a whole round trip.
- **Human-driven editor** — no tool access to the editor. Scenes and prefabs are effectively opaque, so authoring them blind produces plausible files that open broken. Work in code instead: supply the scripts, the tuning surface, the gizmos, and a short list of what to place by hand. Say plainly which parts the user has to drive.

Where a project offers both (an engine with an editor and a code path), take scene-as-code: it survives capture, and re-running beats re-clicking.

## Tuning knobs

Every number that could be wrong is editable **while the prototype runs**, without a recompile. This is the in-engine translation of surfacing the state: a knob you have to rebuild to change is a number you will try twice instead of twenty times, and the answer lives in the twentieth.

Route them through whatever the project already exposes (an inspector, a debug UI, a hot-reloaded config file, an immediate-mode panel). Group them under the thing they affect and label them in the units you think in: metres, seconds, degrees.

Give every knob a **reset**, and print the current values in a form you can paste back into code. The output of a tuning session is the numbers, so make them trivial to carry across.

## Instrumentation

Draw what you cannot see. The state you are judging is usually invisible mid-play, and reconstructing it from memory afterwards is how a wrong verdict gets made confidently.

Put on screen whatever the branch's question depends on: the current state name, velocity, timers and windows counting down, collision and trigger volumes, the camera frustum, distances between the things whose spacing is the question.

Keep it legible and switchable with a single key, so the same scene can be read and then looked at.

## Where the prototype scene lives

Beside the thing it is prototyping for, following the project's own scene and module conventions, and named so it reads as a prototype at a glance.

Keep it out of the boot path: a scratch scene wired into the main flow gets shipped by accident. Gate any debug key, knob panel, or instrumentation overlay out of release builds.
