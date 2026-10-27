# omarchy-dotfiles

Personal customizations for [Omarchy](https://omarchy.org/).

## What's here

- **Keyboard layouts** (`hypr/input.lua`): US, French, Russian.
- **GNOME-style layout switching** (`hypr/bindings.lua`, `kb-layout-set`):
  tap `Super+Space` to flip to the last used layout; hold `Super` and press
  `Space` repeatedly to cycle in most-recently-used order. Each switch shows
  the layout in the Omarchy OSD. The bar's layout widget sits next to the tray.
- **Bindings**: tap `Super` alone for the Omarchy menu, `Super+A` for apps.
- **niri-style scrolling** (`hypr/looknfeel.lua`): every workspace uses the
  scrolling layout. Windows sit on a horizontal tape and keep their width, a
  lone window included, and the focused column is centered. Workspaces slide
  vertically.
- **Touchpad**: three-finger left/right scrolls between windows in the
  workspace; three-finger up/down switches workspaces.
- **Idle** (`plugins/youpaw.idle`, a clone of `omarchy.idle`): a playing video
  (Wayland idle inhibitor) blocks screensaver and lock; playing music (MPRIS)
  allows the screensaver but holds the lock until playback stops.
- **Screensaver inhibit bridge** (`~/.local/bin/screensaver-inhibit-bridge`, a
  systemd user service): owns `org.freedesktop.ScreenSaver`, so apps that ask
  to stay awake over D-Bus count too. Firefox goes through the desktop portal,
  whose GTK backend forwards to that name, and nothing owned it, so video in
  the browser never blocked the screensaver. Active inhibitors are listed in
  `$XDG_RUNTIME_DIR/screensaver-inhibit` and shown as `appInhibitors` in
  `omarchy-shell idle status`.
- **Ghostty splits** (`ghostty/config`): `Ctrl+Shift+A` splits right,
  `Ctrl+Shift+D` down, `Ctrl+Shift+X` closes, `Ctrl+Shift+S` equalizes,
  `Ctrl+Shift+Enter` zooms. `Ctrl+Shift+H/J/K/L` moves focus;
  `Ctrl+Alt+arrows` resizes, add `Shift` for a little. The stock resize keys
  (`Super+Ctrl+Shift+arrows`) are taken by Hyprland's window resize.
- **Quiet shell env** (`.bashrc`): Hyprland exports the theme's gum styling
  (~110 `GUM_*` vars) to every process; interactive bash drops them and passes
  them to `gum` only.

## Install

```bash
./install.sh
```

Replaced files are backed up as `<file>.bak.<timestamp>`.
