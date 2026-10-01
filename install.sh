#!/usr/bin/env bash
set -e
here="$(cd "$(dirname "$0")" && pwd)"
ff="$HOME/.config/fastfetch"
kd="$HOME/.local/share/konsole"
ts="$(date +%s)"
mkdir -p "$ff" "$kd"

for f in config.jsonc lain.ans; do
  if [ -f "$ff/$f" ]; then cp "$ff/$f" "$ff/$f.bak-$ts"; fi
done
if [ -f "$kd/Lain.profile" ]; then cp "$kd/Lain.profile" "$kd/Lain.profile.bak-$ts"; fi

cp "$here/fastfetch/lain.ans" "$ff/lain.ans"
sed "s|/home/[^/\"]*/\.config/fastfetch|$ff|g" "$here/fastfetch/config.jsonc" > "$ff/config.jsonc"
cp "$here/konsole/Lain.profile" "$kd/Lain.profile"

if [ -f /usr/share/applications/org.kde.konsole.desktop ]; then
  mkdir -p "$HOME/.local/share/applications"
  cp /usr/share/applications/org.kde.konsole.desktop "$HOME/.local/share/applications/"
  sed -i '0,/^Exec=konsole/ s|^Exec=konsole.*|Exec=konsole --profile Lain|' \
    "$HOME/.local/share/applications/org.kde.konsole.desktop"
  command -v kbuildsycoca6 >/dev/null 2>&1 && kbuildsycoca6 >/dev/null 2>&1 || true
fi

if command -v kwriteconfig6 >/dev/null 2>&1; then
  kwriteconfig6 --file konsolerc --group "Desktop Entry" --key DefaultProfile "Lain.profile"
fi

echo "Done. Backups end in .bak-$ts"
echo "Next: install fonts-cascadia-code, add fish/snippet.fish to your fish config,"
echo "run 'tmux kill-server' once, then open Konsole from the app menu."
