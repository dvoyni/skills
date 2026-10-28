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

The script uses perl, not python, and captures the minified identifiers by regex, so it survives identifier renames between versions. Exit code 2 means the handler's structure changed. In that case, open `webview/index.js`, find the main prompt's Enter handler (search for `useCtrlEnterToSend?`; grep it with `grep -bo` plus `tail -c`/`head -c`, since the file is one huge line), redo the two edits below by hand, and update the regex in `patch.sh`.

## What the patch changes (in `webview/index.js`)

Identifiers below are from 2.1.304; in 2.1.306 they were `w0`, `h1`, `FD`.

1. Send condition: `X.useCtrlEnterToSend?R0:!0` → `X.useCtrlEnterToSend?R0:!R0`, where `R0` = metaKey||ctrlKey. With the setting off, only an unmodified Enter sends.
2. Newline branch: the input is a `contenteditable="plaintext-only"` box (`KD` true), where the extension relies on the browser's native Enter, which does nothing when Cmd is held. So we add `else if(R0&&KD)g1.preventDefault(),document.execCommand("insertLineBreak")` before the existing `else if(!KD){...}`.

Verified on extension versions 2.1.304 (darwin-arm64), 2.1.306 and 2.1.311 (win32-x64). In 2.1.311 the send branch gained braces (`...else t1()}else if(!SP)`), so the regex allows an optional `;` and `}` there. To undo, restore `webview/index.js.orig` or reinstall the extension.
