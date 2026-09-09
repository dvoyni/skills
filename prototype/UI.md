# UI Prototype

Generate **several radically different variations** of one surface, switchable live. Flip between variants, pick one (or steal bits from each), then throw the rest away.

The surface can be a web route or an in-engine screen: a settings page, a battle HUD, an inventory, a menu. The variants and the switcher work the same way either way; only the delivery differs, which is [step 4](#4-build-the-switcher).

If the question is about logic or state rather than what something looks like, use [LOGIC.md](LOGIC.md). If it is about the image itself (a shader, a post effect, a particle system) rather than the arrangement of elements, use [VFX.md](VFX.md).

## When this is the right shape

- "What should this page look like?"
- "I want to see a few options for this dashboard before committing."
- "Try a different layout for the settings screen."
- "Where should the ability bar go?"
- Any time the alternative is spending a day picking between three vague mockups in your head.

## Two sub-shapes: strongly prefer sub-shape A

A UI prototype is much easier to judge when it is **butting up against the rest of the app**: real surrounding chrome, real data, real density. A throwaway surface on its own is a vacuum, where every variant looks fine. Default to sub-shape A whenever there is a plausible existing surface to host the variants.

### Sub-shape A: adjustment to an existing surface (preferred)

The surface already exists. Variants render **in place**, gated by the variant selector. Existing data fetching, params, and auth all stay; only the rendering swaps. This is the default; pick it unless there is a specific reason not to.

If the prototype is for something that does not yet have a surface but *would naturally live inside one* (a new section of the dashboard, a new panel in the HUD, a new step in an existing flow), it is still sub-shape A. Mount the variants inside the host.

### Sub-shape B: a new surface (last resort)

Only when the thing being prototyped genuinely has nowhere to live inside (an entirely new top-level surface, or a flow that cannot be embedded anywhere sensible).

Create a throwaway route or scene following whatever convention the project already uses, named so it is obviously a prototype. Same variant selector.

Before committing to sub-shape B, sanity-check: is there really no existing surface this could be embedded in? An empty one hides design problems a populated one would expose.

## Process

### 1. State the question and pick N

Default to **3 variants**. Past 5 they stop being radically different and start being noise, so cap there.

Write the plan in one line, in the prototype's location or a top-of-file comment:

> "Three variants of the settings page, switchable via `?variant=`, on the existing `/settings` route."

### 2. Generate radically different variants

Draft each one. Hold each to:

- The surface's purpose and the data it has access to.
- The project's component library or styling system (Tailwind, shadcn, MUI, an immediate-mode UI package, plain CSS, whatever it uses).
- A clear name, e.g. `VariantA`, `VariantB`, `VariantC`.

Variants must be **structurally different**: different layout, different information hierarchy, different primary affordance. Three slightly-tweaked card grids is not a UI prototype, it is wallpaper. If two drafts come out too similar, redo one with explicit "no card grid" guidance.

### 3. Wire them together

One switch point on the surface, selecting between the variants, with everything shared above it:

```
// pseudo-code, adapt to the project
variant = currentVariant()      // from URL param, or debug state
render(variants[variant])
render(switcher(variants, variant))
```

For sub-shape A, keep all the existing data fetching above the switch; only the rendered subtree changes per variant.

### 4. Build the switcher

The contract is the same in both mediums:

- **Previous** and **next** cycle through the variants, wrapping around at both ends.
- A visible **label** shows the current key and, where the variant has a name, that too: `B (Sidebar layout)`.
- The current variant is **stable across a reload**, so a session is not lost by restarting.
- It is **visually distinct** from the surface itself (high contrast, a hard edge) so it is obviously not part of the design being judged.
- It is **gated out of release builds**, so a stray merge cannot ship it to players.

Put it in one shared component so both sub-shapes reuse it.

**Web delivery**: a fixed floating bar at bottom-centre with arrows either side of the label. Cycling updates a `?variant=` search param through the framework's router (`router.replace`, `navigate`, etc.) so the variant is shareable as a URL and survives reload. `←` and `→` also cycle, except while an `<input>`, `<textarea>`, or `[contenteditable]` is focused. Gate on `process.env.NODE_ENV !== 'production'` or the project's equivalent.

**In-engine delivery**: a single debug key cycles forward and shift-key cycles back, with the label drawn as an overlay in a corner. Persist the current variant to the project's debug or scratch config so a restart comes back where you left off. Gate behind whatever development-build flag the project already uses.

### 5. Hand it over

Surface how to switch: the URL and its `?variant=` keys, or the debug key. Flip through it.

The interesting feedback is usually **"I want the header from B with the sidebar from C"**, which is the actual design.

### 6. Capture the answer and clean up

Once a variant has won, capture which one and why, then capture the prototype the way the [SKILL](SKILL.md) describes. Fold the winner into the real code and move the rest out of main:

- **Sub-shape A**: fold the winner into the existing surface; drop the losing variants and the switcher from main.
- **Sub-shape B**: promote the winner to a real surface; drop the throwaway one and the switcher.

The full set of variants is the primary source, so it lands on the throwaway branch rather than the bin. Variants and a switcher left behind in main rot fast and confuse the next reader.

## Anti-patterns

- **Variants that differ only in colour or copy.** That is a tweak. Real variants disagree about structure.
- **Sharing too much code between variants.** A shared header is fine; a shared layout defeats the point. Each variant should be free to throw the layout out.
- **Wiring variants to real mutations.** Read-only is fine. If a variant needs to mutate, point it at a stub: the question is what this should look like, not whether the backend works.
- **Promoting the prototype straight to production.** The variant was written under prototype constraints, with no tests and minimal error handling. Rewrite it properly when folding it in.
