# Feel

One mechanic, alone in a bare scene, with every number tunable while it runs. Use this when the question is **kinesthetic**: whether the grapple feels good, whether the coyote time is right, whether the dash cancel window is fair, whether the jump is floaty.

If the question is about the space the mechanic runs in, use [GREYBOX.md](GREYBOX.md); if it is about how something looks, use [VFX.md](VFX.md). Read [IN-ENGINE.md](IN-ENGINE.md) alongside this one for grip, knobs, and instrumentation.

## When this is the right shape

- "Does this jump feel floaty?"
- "Is the dash cancel window fair?"
- "Should the grapple be aim-assisted?"
- "How long should the hit-stun be?"
- Anything only answerable by the person holding the controller.

## Process

### 1. State the question and name the feeling

One line, written beside the scene: the mechanic, and the feeling you are chasing. "Does the dash read as committed rather than twitchy" is checkable later; "make the dash good" is not.

Feel questions decay into fiddling without a named target, because every number can always be nudged. The named feeling is what tells you when to stop.

### 2. Strip the scene to nothing

A flat plane and whatever single obstacle the mechanic needs: one wall to grapple, one ledge to coyote-time off, one dummy to hit. Grey, per the [SKILL](SKILL.md)'s fidelity rule.

Everything else is noise that changes the answer. A level makes a mechanic feel good or bad for reasons that are about the level, and you will carry the wrong number into the real game.

### 3. Isolate the mechanic behind a tuning surface

Write the mechanic so every number that could be wrong is a **named parameter**, not a literal buried in the update loop: durations, curves, thresholds, windows, impulses, decay rates. Then expose all of them as live knobs.

This is the load-bearing step. Feel is found by sweeping a number until it flips from wrong to right, so the cost of changing one decides how many you actually try. A recompile per change means you test three values; a live knob means you test thirty and find the edge.

Keep the mechanic itself liftable: a self-contained module the real code can take whole once the numbers are settled. The scene around it is throwaway; this is not.

### 4. Draw the state

Feel lives in windows and transitions you cannot see mid-play. Put on screen: the current state, velocity, every timer counting down, input buffer contents, the active window (coyote, cancel, i-frames) as it opens and closes.

Half of "that felt wrong" turns out to be a window closing a frame earlier than it looks, and you find that by watching it, not by remembering it.

### 5. Play it, sweep the knobs, record the numbers

Play. Change one number. Play again. Push each knob until it is obviously too much and obviously too little, because the bounds are what locate the right value between them.

When it lands, write the numbers down immediately, with the named feeling from step 1 beside them. The numbers are the entire output of this prototype.

### 6. Capture

Capture the way the [SKILL](SKILL.md) describes. The feel-specific mapping: the parameter block and the isolated module lift into the real code together, since the numbers only mean anything against the implementation they were tuned on. A short screen capture is worth more than a screenshot here, because the verdict is about motion.

## Anti-patterns

- **Tuning inside a real level.** The level's geometry, enemies, and pacing all move the answer.
- **Constants buried in the update loop.** Every one of them is a number you will not try.
- **Tuning two mechanics at once.** When both are moving you cannot tell which one is wrong.
- **Adding feedback to fix the feel.** Particles, screenshake, and sound make anything feel better, which is exactly why they hide whether the mechanic underneath is right. Settle the numbers grey first; the effect is [VFX.md](VFX.md)'s question.
- **Trusting the verdict from someone who has not played it.** A recording shows what happened, not what it felt like.
