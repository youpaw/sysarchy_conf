# omarchy-dotfiles

Personal customizations for [Omarchy](https://omarchy.org/).

## What's here

- **Keyboard layouts** (`hypr/input.lua`): US, French, Russian.
- **GNOME-style layout switching** (`hypr/bindings.lua`, `kb-layout-set`):
  tap `Super+Space` to flip to the last used layout; hold `Super` and press
  `Space` repeatedly to cycle in most-recently-used order. Each switch shows
  the layout in the Omarchy OSD. The bar's layout widget sits next to the tray.
- **Bindings**: tap `Super` alone for the Omarchy menu, `Super+A` for apps.
- **Touchpad**: three-finger horizontal swipe switches workspaces.
- **Idle** (`plugins/youpaw.idle`, a clone of `omarchy.idle`): a playing video
  (Wayland idle inhibitor) blocks screensaver and lock; playing music (MPRIS)
  allows the screensaver but holds the lock until playback stops.

## Install

```bash
./install.sh
```

Replaced files are backed up as `<file>.bak.<timestamp>`.
