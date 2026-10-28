#!/bin/sh
# Patch the Claude Code VS Code extension so that, with
# claudeCode.useCtrlEnterToSend off: Enter sends, Cmd/Ctrl+Enter inserts a newline.
# Idempotent. Usage: patch.sh [path/to/webview/index.js]  (default: newest installed extension)
#
# The minified identifiers change between versions, so the pattern captures them:
#   E = keydown event, M = metaKey||ctrlKey, P = "input is plaintext-only" flag.
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

tmp="$f.patching"
# perl exits 0 when patched, 3 when already patched, 2 when the pattern is missing.
set +e
perl -0777 -e '
  my $id = qr/[A-Za-z_\$][A-Za-z0-9_\$]*/;
  my $s = <STDIN>;
  exit 3 if $s =~ /useCtrlEnterToSend\?($id):!\1\)/
         && $s =~ /else if\($id&&$id\)$id\.preventDefault\(\),document\.execCommand\("insertLineBreak"\);else if\(!/;
  my $re = qr/
    (let\s*(?<M>$id)=(?<E>$id)\.metaKey\|\|\k<E>\.ctrlKey;
     if\($id\.useCtrlEnterToSend\?\k<M>:)!0\)
    (?<mid>.{0,200}?else\s+$id\(\);?\}?)
    else\s+if\(!(?<P>$id)\)\{\k<E>\.preventDefault\(\);
  /xs;
  $s =~ s/$re/$1."!".$+{M}.")".$+{mid}
    ."else if(".$+{M}."&&".$+{P}.")".$+{E}.".preventDefault(),document.execCommand(\"insertLineBreak\");"
    ."else if(!".$+{P}."){".$+{E}.".preventDefault();"/e
    or exit 2;
  print $s;
' < "$f" > "$tmp"
rc=$?
set -e
case $rc in
  0) [ -f "$f.orig" ] || cp "$f" "$f.orig"
     mv "$tmp" "$f"
     echo "Patched. Backup: $f.orig"
     echo "Now run 'Developer: Reload Window' in VS Code." ;;
  3) rm -f "$tmp"; echo "Already patched." ;;
  2) rm -f "$tmp"
     echo "Pattern not found: the extension's minified code changed. Re-locate the" >&2
     echo "main prompt Enter handler (search 'useCtrlEnterToSend?') and update this script." >&2
     exit 2 ;;
  *) rm -f "$tmp"; echo "perl failed ($rc)" >&2; exit 1 ;;
esac
