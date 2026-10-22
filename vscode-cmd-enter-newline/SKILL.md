---
name: vscode-cmd-enter-newline
description: Re-apply the patch to the Claude Code VS Code extension that makes Enter send and Cmd/Ctrl+Enter insert a newline. Use after the extension updates, on a new machine, or when Cmd+Enter stops inserting a newline.
---

# Cmd/Ctrl+Enter newline patch for Claude Code VS Code extension

The extension only offers Enter=send / Shift+Enter=newline, or (with `claudeCode.useCtrlEnterToSend`) Enter=newline / Cmd+Enter=send. This patch makes it Enter=send, Cmd/Ctrl+Enter=newline (Shift+Enter still works). Extension updates overwrite it.

## Apply

1. Make sure `claudeCode.useCtrlEnterToSend` is **off** (the default) in VS Code settings.
2. Run `sh ~/.claude/skills/vscode-cmd-enter-newline/patch.sh` (optionally pass the path to a specific `webview/index.js`).
3. Tell the user to run **Developer: Reload Window**.

Exit code 2 means the minified code changed in a new extension version. In that case, open `webview/index.js`, find the main prompt's Enter handler (search for `useCtrlEnterToSend?`), and redo the two edits below with the new identifiers. Then update `patch.sh`.

## What the patch changes (in `webview/index.js`)

1. Send condition: `X.useCtrlEnterToSend?R0:!0` → `X.useCtrlEnterToSend?R0:!R0`, where `R0` = metaKey||ctrlKey. With the setting off, only an unmodified Enter sends.
2. Newline branch: the input is a `contenteditable="plaintext-only"` box (`KD` true), where the extension relies on the browser's native Enter, which does nothing when Cmd is held. So we add `else if(R0&&KD)g1.preventDefault(),document.execCommand("insertLineBreak")` before the existing `else if(!KD){...}`.

Verified on extension version 2.1.304 (darwin-arm64). To undo, restore `webview/index.js.orig` or reinstall the extension.
