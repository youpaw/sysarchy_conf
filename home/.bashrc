# Omarchy environment (OMARCHY_PATH + PATH), needed even for non-interactive shells
[[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && source /usr/share/omarchy/default/bash/env-bootstrap

# If not running interactively, don't do anything else (leave this above the rc source)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source "$OMARCHY_PATH/default/bash/rc"

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'
export LIBVIRT_DEFAULT_URI=qemu:///system

# Hyprland exports the theme's gum styling (~110 GUM_* vars plus FOREGROUND,
# BACKGROUND, BORDER_*) to every process. Keep it out of the shell env and hand
# it to gum only when gum runs.
_gum_env=()
for _v in ${!GUM_@} FOREGROUND BACKGROUND BORDER_FOREGROUND BORDER_BACKGROUND; do
  [[ -v $_v ]] && _gum_env+=("$_v=${!_v}") && unset "$_v"
done
unset _v
gum() { env "${_gum_env[@]}" gum "$@"; }
