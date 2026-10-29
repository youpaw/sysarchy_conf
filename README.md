# omarchy-dotfiles

Personal customizations for [Omarchy](https://omarchy.org/).

## What's here

- **Keyboard layouts** (`hypr/input.lua`): US, French, Russian.
- **GNOME-style layout switching** (`hypr/bindings.lua`, `kb-layout-set`):
  tap `Super+Space` to flip to the last used layout; hold `Super` and press
  `Space` repeatedly to cycle in most-recently-used order. Each switch shows
  the layout in the Omarchy OSD. The bar's layout widget sits next to the tray.
- **Bindings**: tap `Super` alone for the Omarchy menu, `Super+A` for apps,
  `Super+Ctrl+M` for Ghostty keybindings (`ghostty-keybindings`, in place of
  Herdr's), `` Super+` `` for Sidra (opens popped out, focuses the open window). fcitx5's
  QuickPhrase trigger on `` Super+` `` is cleared (`fcitx5/conf/quickphrase.conf`).
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
- **Ghostty splits** (`ghostty/config`): `Ctrl+Alt+A` splits right,
  `Ctrl+Alt+D` down, `Ctrl+Alt+X` closes, `Ctrl+Alt+S` equalizes,
  `Ctrl+Alt+Z` zooms. `Ctrl+Alt+H/J/K/L` moves focus;
  `Ctrl+Alt+arrows` resizes, add `Shift` for a little. The stock resize keys
  (`Super+Ctrl+Shift+arrows`) are taken by Hyprland's window resize.
  fcitx5's word-hint toggles on `Ctrl+Alt+H/J` are cleared
  (`fcitx5/conf/keyboard.conf`) so those keys reach Ghostty.
- **Ghostty tabs**: `Ctrl+Shift+[` / `]` switch tabs, add `Alt` to move the
  current tab left/right; `Ctrl+Shift+X` closes it.
- **Quiet shell env** (`.bashrc`): Hyprland exports the theme's gum styling
  (~110 `GUM_*` vars) to every process; interactive bash drops them and passes
  them to `gum` only.
- **Neovim**: [syslazy_conf](https://github.com/youpaw/syslazy_conf), a
  LazyVim config built on Omarchy's. `install.sh` clones it into
  `~/.config/nvim`, or pulls it if it's already there, and pins the plugins
  to its lockfile. On Omarchy it follows the system theme and hot-reloads it.

## Install

```bash
./install.sh
```

Replaced files are backed up as `<file>.bak.<timestamp>`.
