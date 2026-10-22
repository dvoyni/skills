#!/bin/sh
# Patch the Claude Code VS Code extension so that, with
# claudeCode.useCtrlEnterToSend off: Enter sends, Cmd/Ctrl+Enter inserts a newline.
# Idempotent. Usage: patch.sh [path/to/webview/index.js]  (default: newest installed extension)
set -eu

f="${1:-}"
if [ -z "$f" ]; then
  for base in "$HOME/.vscode/extensions" "$HOME/.vscode-insiders/extensions"; do
    d=$(ls -d "$base"/anthropic.claude-code-*/ 2>/dev/null | sort -V | tail -1 || true)
    [ -n "$d" ] && f="${d}webview/index.js" && break
  done
fi
[ -n "$f" ] && [ -f "$f" ] || { echo "Claude Code extension webview/index.js not found" >&2; exit 1; }
echo "Target: $f"

SEND_OLD='if(X.useCtrlEnterToSend?R0:!0)'
SEND_NEW='if(X.useCtrlEnterToSend?R0:!R0)'
NL_OLD='else o1();else if(!KD){g1.preventDefault();let y1=p1.current;'
NL_NEW='else o1();else if(R0&&KD)g1.preventDefault(),document.execCommand("insertLineBreak");else if(!KD){g1.preventDefault();let y1=p1.current;'

if grep -qF "$SEND_NEW" "$f" && grep -qF "$NL_NEW" "$f"; then
  echo "Already patched."
  exit 0
fi
if ! grep -qF "$SEND_OLD" "$f" || ! grep -qF "$NL_OLD" "$f"; then
  echo "Patterns not found: the extension's minified code changed. Re-locate the" >&2
  echo "main prompt Enter handler (search 'useCtrlEnterToSend?') and update this script." >&2
  exit 2
fi

[ -f "$f.orig" ] || cp "$f" "$f.orig"
SEND_OLD="$SEND_OLD" SEND_NEW="$SEND_NEW" NL_OLD="$NL_OLD" NL_NEW="$NL_NEW" python3 -I -c '
import os, sys
p = sys.argv[1]
s = open(p).read()
s = s.replace(os.environ["SEND_OLD"], os.environ["SEND_NEW"], 1)
s = s.replace(os.environ["NL_OLD"], os.environ["NL_NEW"], 1)
open(p, "w").write(s)
' "$f"
echo "Patched. Backup: $f.orig"
echo "Now run 'Developer: Reload Window' in VS Code."
