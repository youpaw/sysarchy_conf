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

# Neovim: syslazy_conf in ~/.config/nvim. An existing clone is updated; any
# other config there is moved aside.
nvim_repo=https://github.com/youpaw/syslazy_conf.git
nvim_dir=$HOME/.config/nvim
if [[ $(git -C "$nvim_dir" remote get-url origin 2>/dev/null) == *youpaw/syslazy_conf* ]]; then
  git -C "$nvim_dir" pull --ff-only || echo "warning: could not fast-forward $nvim_dir"
  echo "updated $nvim_dir"
else
  if [[ -e $nvim_dir || -L $nvim_dir ]]; then
    mv "$nvim_dir" "$nvim_dir.bak.$stamp"
    echo "backed up $nvim_dir"
  fi
  git clone --quiet "$nvim_repo" "$nvim_dir"
  echo "installed $nvim_dir"
fi
# The first start installs missing plugins and rewrites the lockfile from
# whatever is already on disk, so put it back before restoring to its pins.
nvim --headless +qa >/dev/null 2>&1
git -C "$nvim_dir" checkout -- lazy-lock.json
nvim --headless "+Lazy! restore" +qa >/dev/null 2>&1
echo "restored nvim plugins"

systemctl --user daemon-reload
systemctl --user enable --now screensaver-inhibit-bridge.service

hyprctl reload >/dev/null && hyprctl configerrors
omarchy restart shell
