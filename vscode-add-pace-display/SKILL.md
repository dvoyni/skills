---
name: vscode-add-pace-display
description: "Patch the Claude Code VS Code extension so every usage bar gets a second bar showing how much of its window has elapsed."
disable-model-invocation: true
---

Claude Code's VS Code extension shows rate-limit usage bars (Session 5hr, Weekly 7 day, per-model weekly limits) with no sense of _pace_. This skill patches the extension's minified webview bundle so each usage bar gets a thin grey **time bar** under it: the share of that window already elapsed. Usage bar shorter than time bar means under pace.

The bundle is closed source and minified; identifiers change every release, so each step finds its target by stable strings, never by the names below. Mods (`plugin-authoring`) cannot draw into this panel; the patch is the only route.

## Steps

1. **Locate the bundle.** The newest of `~/.vscode/extensions/anthropic.claude-code-*/webview/index.js` (also check `~/.vscode-insiders/extensions/` and `~/.cursor/extensions/` if the person uses those). Done when you hold one path and its version.

2. **Check for a prior patch.** `grep -c __tp index.js`. Non-zero means this version is already patched: report that and stop.

3. **Back up.** `cp -n index.js index.js.orig`. Done when `index.js.orig` exists beside it.

4. **Find the bar component.** Grep for `usageTrack` near `utilization`: the function whose props are `{label, utilization, resetText}` and whose body renders a track div (`className:<css>.usageTrack`) holding a fill div styled `width:\`${<pct>}%\``. Note its name, its CSS-module object, and its `h`-style element factory (`m(...)` / `k(...)` in 2.1.319).

5. **Find every caller.** Grep `<factory>(<bar>,{`. Each caller builds a list of windows from labels like `"Session (5hr)"` and `"Weekly (7 day)"`, then maps it to bar elements. There are several callers (2.1.319 has two: the account popup and the **Account & Usage** panel); patch them all, or the panel the person looks at stays unchanged. Done when every call site is listed with where its reset time comes from and in what unit.

6. **Patch.** Each anchor string must match exactly once; abort on any other count.
   - **Bar:** add props `resetsAt` and `windowMs`; compute `__tp`, the elapsed percent, clamped 0–100:
     `let __tp=__ra&&__wm?Math.min(100,Math.max(0,100*(1-(new Date(__ra).getTime()-Date.now())/__wm))):null;`
     Right after the usage track element, insert a second track:
     `__tp!==null&&m("div",{className:<css>.usageTrack,title:\`${Math.round(__tp)}% of time passed\`,style:{marginTop:"3px"},children:m("div",{className:<css>.usageFill,style:{width:\`${__tp}%\`,background:"var(--vscode-descriptionForeground)",opacity:.6}})})`
   - **Each caller:** pass `resetsAt` as a value `new Date()` reads correctly (milliseconds or ISO string; multiply unix **seconds** by 1000) and `windowMs`: `18e6` (5 h) for the `five_hour` window, `6048e5` (7 d) for every other window. Pass `undefined` for `resetsAt` where the caller already treats the window as reset.

   Script the edits as exact `str.replace` pairs in Python with a count check, so a mismatch fails loudly instead of half-patching.

7. **Verify.** `node --check index.js` passes, `grep -o "<factory>(<bar>,{[^}]*}" index.js` shows `resetsAt` and `windowMs` on every call site.

8. **Hand over.** Tell the person to run **Developer: Reload Window**, then reopen the usage panel. Give the undo command, `cp <dir>/index.js.orig <dir>/index.js`, and say that an extension update replaces the bundle, so the skill must be rerun after each update.

## Reference: the 2.1.319 patch

The anchors and replacements that worked on `anthropic.claude-code-2.1.319-darwin-arm64`. Use them as a template for the shape of each edit, re-deriving the names and anchors from the current bundle.

| Target | Anchor | Replacement |
| --- | --- | --- |
| Bar signature | `function dle({label:e,utilization:t,resetText:n}){` | `function dle({label:e,utilization:t,resetText:n,resetsAt:__ra,windowMs:__wm}){let __tp=…;` |
| Bar body | `` style:{width:`${i}%`}})}),n&&k("span" `` | the same with the time-track element inserted before `n&&k("span"` |
| Popup caller list (`WDn`, `resets_at` ISO) | `showDay:s!==n.five_hour}]` | `showDay:s!==n.five_hour,windowMs:s===n.five_hour?18e6:6048e5}]` |
| Popup caller call | `resetText:r.resetsAt?$Dn(r.resetsAt,t,r.showDay):void 0},r.label)` | the same with `,resetsAt:r.resetsAt,windowMs:r.windowMs` before `}` |
| Panel caller list (`UBn`, `resetsAt` unix seconds, `s` is "not five_hour") | `resetText:a\|\|r.resetsAt===void 0?void 0:Zy(r.resetsAt,n,s)}]` | the same plus `,resetsAt:a\|\|r.resetsAt===void 0?void 0:r.resetsAt*1000,windowMs:s?6048e5:18e6` before `}]` |
| Panel caller call | `m(dle,{label:o.label,utilization:o.percent,resetText:o.resetText},o.label)` | the same with `,resetsAt:o.resetsAt,windowMs:o.windowMs` before `}` |
