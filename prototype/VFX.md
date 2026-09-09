# Visual effect

One effect, isolated at **near-target fidelity**, with its parameters exposed. Use this when the question is about how something looks: whether the fog reads, whether the hit flash lands, whether the water sells at distance.

If the question is about the space, use [GREYBOX.md](GREYBOX.md); if it is about how a mechanic plays, use [FEEL.md](FEEL.md). Read [IN-ENGINE.md](IN-ENGINE.md) alongside this one for grip, knobs, and instrumentation.

## When this is the right shape

- "Does this fog-of-war read as unexplored, or just dark?"
- "Is the hit flash strong enough without being cheap?"
- "Does this water hold up at distance?"
- "Should the outline be per-object or post-process?"
- Anything where the answer is a judgement of the image.

## Process

### 1. State the question and what "right" would look like

One line beside the scene: the effect, and what it has to communicate. "Unexplored territory should read as unknown rather than empty" is checkable; "make the fog nicer" is not.

### 2. Build near-target, and ask for the real assets

This branch is the exception to grey. The image *is* the question, so a grey stand-in answers nothing: the effect needs the lighting, materials, post-processing chain, and camera it will actually ship under.

Where the real assets are needed and not to hand, **ask the user for them and wait**. Substituting an approximation makes the verdict wrong rather than approximate, which is worse than being blocked for a message.

Everything not under judgement stays minimal. Near-target means the effect's *context* is real, not that the scene is finished.

### 3. Expose the parameters, and an A/B against the current look

Every value that shapes the image becomes a live knob: colours, ramps, densities, radii, blend weights, noise scales, animation rates.

Then wire a **single-key A/B** between the effect and what ships today (or nothing at all). Judging an image against a memory of the previous image is unreliable in exactly the direction that flatters new work; toggling in place removes the guesswork.

Keep the effect self-contained (one shader, one material, one pass) so the winning version lifts into the real render path whole.

### 4. Look at it under the conditions it has to survive

Effects that hold up in one frame fall apart across the range the game actually spans. Step through the ones the question implies: near and far, still and moving, bright and dark lighting, against the busiest and the emptiest background, at the lowest supported settings, in every colour scheme the project ships.

Where cost is part of the question, put frame time on screen next to the knobs and read it while sweeping them.

### 5. Capture screenshots and the parameter values

Screenshot every condition from step 4, with the A/B pair side by side, and write the verdict against the sentence from step 1. Capture the way the [SKILL](SKILL.md) describes.

The VFX-specific mapping: the shader or effect lifts into the real render path along with its final parameter values, and the screenshot set is the primary source — a visual verdict cannot be reconstructed from prose, and "we tried a denser version and it read as muddy" is only meaningful with the image attached.

## Anti-patterns

- **Judging it in grey.** The fidelity rule inverts here. An effect evaluated on untextured boxes tells you nothing about the shipped image.
- **Judging one frame, still, at one distance.** Most effects fail in motion or at range, which is where the player sees them.
- **A showcase scene built to flatter it.** A bespoke camera angle and a hand-picked backdrop hide every case that matters. Use the context it will ship in.
- **Approximating a missing asset rather than asking.** The whole branch rests on the image being real.
- **Tuning it to fix a mechanic that feels wrong.** Feedback makes anything feel better without making it better; settle that in [FEEL.md](FEEL.md) first.
