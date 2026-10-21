#!/bin/bash
# Copy these Omarchy customizations into $HOME, backing up any file they replace.
set -euo pipefail

src="$(cd "$(dirname "$0")" && pwd)/home"
stamp=$(date +%s)

while IFS= read -r -d '' file; do
  rel=${file#"$src"/}
  dest="$HOME/$rel"
  mkdir -p "$(dirname "$dest")"
  if [[ -e $dest ]] && ! cmp -s "$file" "$dest"; then
    cp -a "$dest" "$dest.bak.$stamp"
    echo "backed up $dest"
  fi
  cp -a "$file" "$dest"
  echo "installed $dest"
done < <(find "$src" -type f -print0)

systemctl --user daemon-reload
systemctl --user enable --now screensaver-inhibit-bridge.service

hyprctl reload >/dev/null && hyprctl configerrors
omarchy restart shell
