# Greybox

Untextured geometry at true scale, walked with the real camera and the real controller. Use this when the question is **spatial**: whether a room reads, whether a gap is jumpable, whether a sightline works, whether the walk between two fights is the right length.

If the question is about a mechanic, use [FEEL.md](FEEL.md); if it is about how something looks, use [VFX.md](VFX.md). Read [IN-ENGINE.md](IN-ENGINE.md) alongside this one for grip, knobs, and instrumentation.

## When this is the right shape

- "Is this arena too big?"
- "Can you see the objective from the entrance?"
- "Does the approach to this fight have enough build-up?"
- "Is that a jump or a fall?"
- Anything answered by walking around and looking.

## Process

### 1. Fix the scale before the geometry

Write down the numbers the space has to be true to, and put them where the scene can read them: character height, eye height, walk and run speed, jump height and distance, camera height and FOV. Take them from the real controller wherever one exists.

Everything downstream is measured against these, so a scale error here invalidates the whole greybox while still looking convincing. Where the project already derives dimensions from a named constant, derive from that same one.

### 2. Get the controller in first, on an empty plane

Before any level geometry: the real character controller and the real camera, on a flat plane. Walk it, jump on it, confirm the numbers from step 1 are what the character actually does.

A greybox judged with a flycam is a lie. The camera height, the walk speed, and what the controller can and cannot climb are most of what makes a space read, so they have to be present from the first block placed.

### 3. Block the massing, then the circulation

Volumes first: the big shapes, the floor plan, the heights. Then how you move through them: doors, ramps, cover, ledges, the routes between the volumes.

Detail only where it changes traversal. A pillar you can hide behind earns its place; a pillar you walk past does not.

**Grey means grey**: one flat untextured material across everything, no lighting pass, no art direction, regardless of where the geometry came from. Reuse project assets, generate them, drive Blender or Studio over MCP, or pull a public asset, and then strip whatever you get to a single colour. A second colour is worth spending only on a functional distinction you must read at a glance, like walkable versus blocking.

### 4. Draw the measurements you are judging

The spacing *is* the question, so put it on screen: distances between the volumes that matter, the character's own dimensions as a reference stick in the scene, jump arc, sightlines as drawn rays from the positions you care about.

### 5. Walk it, from the positions that matter

Enter the space the way a player enters it, from every entrance. Stand where a player stands and look at what they would look at. Fly only to check the plan, never to reach a verdict.

The useful moments are "this is much bigger than it felt on paper" and "you can see the whole fight from the door" — those are the answers.

### 6. Capture

Screenshot from the positions you judged from, write the verdict, and capture the prototype the way the [SKILL](SKILL.md) describes. The greybox-specific mapping: the numbers from step 1 are the part that lifts into the real level, and the screenshots carry the spatial verdict that prose cannot.

## Anti-patterns

- **Flying through it.** A flycam makes every space feel fine. The controller is half the answer.
- **Texturing or lighting it.** The moment it looks like something, you start judging the art. Keep it grey until the spatial question is settled.
- **Building past the question.** Two rooms answer a two-room question. A finished level answers nothing and takes a week.
- **Placing by eye at "about right" scale.** A door that is roughly a door is exactly the failure mode this branch exists to catch.
- **Prototyping a mechanic inside it.** A mechanic tested in a hand-built level tells you about the level. Use [FEEL.md](FEEL.md), on a flat plane.
