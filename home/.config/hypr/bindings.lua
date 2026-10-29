-- Personal keybinding overrides on top of the Omarchy defaults.
-- See current bindings: omarchy menu keybindings --print
--
-- Every default this file takes over is unbound first, in one block, so a
-- later bind can never be undone by an unbind further down.

-- ---------------------------------------------------------------------------
-- Free the defaults we take over
-- ---------------------------------------------------------------------------

-- Applications
hl.unbind("SUPER + RETURN")              -- was: Terminal
hl.unbind("SUPER + SHIFT + RETURN")      -- was: Browser
hl.unbind("SUPER + SHIFT + B")           -- was: Browser
hl.unbind("SUPER + SHIFT + ALT + B")     -- was: Browser (private)
hl.unbind("SUPER + SHIFT + F")           -- was: File manager
hl.unbind("SUPER + ALT + SHIFT + F")     -- was: File manager (cwd)
hl.unbind("SUPER + SHIFT + N")           -- was: Editor
hl.unbind("SUPER + CTRL + Q")            -- was: Calculator

-- Menus
hl.unbind("SUPER + SPACE")               -- was: Omarchy menu
hl.unbind("SUPER + ALT + SPACE")         -- was: Apps menu
hl.unbind("SUPER + SHIFT + code:201")    -- was: Omarchy menu (Copilot key, not present)
hl.unbind("SUPER + SHIFT + CTRL + A")    -- was: Agent
hl.unbind("SUPER + K")                   -- was: Keybindings
hl.unbind("SUPER + ALT + K")             -- was: Tmux keybindings
hl.unbind("SUPER + CTRL + K")            -- was: Herdr keybindings

-- Windows
hl.unbind("SUPER + W")                   -- was: Close window
hl.unbind("CTRL + ALT + DELETE")         -- was: Close all windows
hl.unbind("SUPER + T")                   -- was: Toggle floating/tiling
hl.unbind("SUPER + O")                   -- was: Pop window out (float & pin)
hl.unbind("SUPER + P")                   -- was: Pseudo window
hl.unbind("SUPER + J")                   -- was: Toggle window split
hl.unbind("SUPER + F")                   -- was: Full screen
hl.unbind("SUPER + ALT + F")             -- was: Full width
hl.unbind("SUPER + CTRL + F")            -- was: Tiled full screen
hl.unbind("SUPER + CTRL + LEFT")         -- was: Move grouped window focus left
hl.unbind("SUPER + CTRL + RIGHT")        -- was: Move grouped window focus right
-- -/= resize keys (resizing lives on arrows; -/= become monitor scaling).
for _, mods in ipairs({ "SUPER", "SUPER + SHIFT", "SUPER + ALT", "SUPER + SHIFT + ALT", "SUPER + CTRL", "SUPER + CTRL + SHIFT" }) do
  hl.unbind(mods .. " + code:20")
  hl.unbind(mods .. " + code:21")
end

-- Workspaces
hl.unbind("SUPER + L")                   -- was: Toggle workspace layout
hl.unbind("SUPER + ALT + S")             -- was: Move window to scratchpad

-- Look
hl.unbind("SUPER + BACKSPACE")           -- was: Toggle window transparency
hl.unbind("SUPER + SHIFT + BACKSPACE")   -- was: Toggle window gaps
hl.unbind("SUPER + CTRL + BACKSPACE")    -- was: Toggle single-window square aspect
hl.unbind("SUPER + SLASH")               -- was: Monitor scaling up
hl.unbind("SUPER + ALT + SLASH")         -- was: Monitor scaling down

-- Utilities
hl.unbind("SUPER + C")                   -- was: Universal copy
hl.unbind("SUPER + V")                   -- was: Universal paste
hl.unbind("SUPER + X")                   -- was: Universal cut
hl.unbind("SUPER + CTRL + V")            -- was: Clipboard manager
hl.unbind("SUPER + CTRL + R")            -- was: Set reminder
hl.unbind("SUPER + CTRL + ALT + R")      -- was: Show reminders
hl.unbind("SUPER + SHIFT + CTRL + R")    -- was: Clear reminders
hl.unbind("SUPER + CTRL + ALT + D")      -- was: Calendar
hl.unbind("SUPER + CTRL + ALT + W")      -- was: Toggle weather (left unassigned)
hl.unbind("SUPER + CTRL + L")            -- was: Lock system

-- ---------------------------------------------------------------------------
-- Menus
-- ---------------------------------------------------------------------------

-- Tap SUPER alone for the Omarchy menu (fires on release, so SUPER combos still work).
o.bind("SUPER + SUPER_L", "Omarchy menu", "omarchy-menu toggle", { release = true })
o.bind("SUPER + A", "Apps menu", "omarchy-menu toggle apps")
o.bind("SUPER + N", "Agent", "omarchy-agent --pick")
o.bind("SUPER + M", "Keybindings", "omarchy-menu-keybindings")
o.bind("SUPER + ALT + M", "Tmux keybindings", "omarchy-menu-tmux-keybindings")
o.bind("SUPER + CTRL + M", "Ghostty keybindings", "ghostty-keybindings")

-- ---------------------------------------------------------------------------
-- Applications
-- ---------------------------------------------------------------------------

o.bind("SUPER + T", "Terminal", { omarchy = "terminal" })
o.bind("SUPER + B", "Browser", { omarchy = "browser" })
o.bind("SUPER + ALT + B", "Browser (private)", { omarchy = "browser --private" })
o.bind("SUPER + D", "File manager", { omarchy = "nautilus" })
o.bind("SUPER + ALT + D", "File manager (cwd)", { omarchy = "nautilus-cwd" })
o.bind("SUPER + E", "Omawrite", { launch = "omawrite" })
o.bind("SUPER + C", "Calculator", "omacalc")
o.bind("SUPER + GRAVE", "Music (Sidra)", { launch = "sidra", focus = "^[Ss]idra$" })

-- TUIs: focus the running instance instead of opening another one.
hl.unbind("SUPER + CTRL + T")            -- was: Activity (new btop every press)
o.bind("SUPER + CTRL + T", "Activity", { tui = "btop", focus = true })
o.bind("SUPER + CTRL + ALT + A", "Audio mixer", { tui = "wiremix", focus = true })

-- ---------------------------------------------------------------------------
-- Windows
-- ---------------------------------------------------------------------------

-- Some layout dispatchers only exist on one layout and error on the other;
-- wrap them so the key does nothing elsewhere.
local function on_layout(layout, dispatcher)
  return function()
    local workspace = hl.get_active_workspace()
    if workspace and workspace.tiled_layout == layout then
      hl.dispatch(dispatcher)
    end
  end
end

o.bind("SUPER + Q", "Close window", hl.dsp.window.close())
o.bind("SUPER + SHIFT + Q", "Close all windows", "omarchy-hyprland-window-close-all")

-- State: float on O, pop out on P, pseudo on U.
o.bind("SUPER + O", "Toggle window floating/tiling", hl.dsp.window.float({ action = "toggle" }))
o.bind("SUPER + P", "Pop window out (float & pin)", "omarchy-hyprland-window-pop")
o.bind("SUPER + U", "Pseudo window", hl.dsp.window.pseudo())

-- niri-style sizing: full width, tiled full screen, true full screen.
o.bind("SUPER + F", "Full width", hl.dsp.window.fullscreen({ mode = "maximized" }))
o.bind("SUPER + ALT + F", "Tiled full screen", "omarchy-hyprland-window-tiled-fullscreen-toggle")
o.bind("SUPER + CTRL + F", "Full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

-- Resize with arrows (hold to repeat).
local resize_steps = {
  { mods = "SUPER + CTRL", size = 100, label = "" },
  { mods = "SUPER + CTRL + SHIFT", size = 25, label = " a little" },
}
for _, step in ipairs(resize_steps) do
  local s = step.size
  o.bind(step.mods .. " + RIGHT", "Grow window width" .. step.label, hl.dsp.window.resize({ x = s, y = 0, relative = true }), { repeating = true })
  o.bind(step.mods .. " + LEFT", "Shrink window width" .. step.label, hl.dsp.window.resize({ x = -s, y = 0, relative = true }), { repeating = true })
  o.bind(step.mods .. " + DOWN", "Grow window height" .. step.label, hl.dsp.window.resize({ x = 0, y = s, relative = true }), { repeating = true })
  o.bind(step.mods .. " + UP", "Shrink window height" .. step.label, hl.dsp.window.resize({ x = 0, y = -s, relative = true }), { repeating = true })
end

-- Dwindle: toggle the split direction.
o.bind("SUPER + W", "Toggle window split (dwindle)", on_layout("dwindle", hl.dsp.layout("togglesplit")))

-- Scrolling, niri-style consume/expel: pull the window into the column on its
-- left/right, or out into its own column if it shares one.
o.bind("SUPER + BRACKETLEFT", "Merge window into left column / split out (scrolling)", on_layout("scrolling", hl.dsp.layout("consume_or_expel prev")))
o.bind("SUPER + BRACKETRIGHT", "Merge window into right column / split out (scrolling)", on_layout("scrolling", hl.dsp.layout("consume_or_expel next")))

-- ---------------------------------------------------------------------------
-- Workspaces
-- ---------------------------------------------------------------------------

-- Vertical workspaces, niri-style: J goes down (next), K goes up (previous).
o.bind("SUPER + J", "Workspace below", hl.dsp.focus({ workspace = "r+1" }))
o.bind("SUPER + K", "Workspace above", hl.dsp.focus({ workspace = "r-1" }))
o.bind("SUPER + SHIFT + J", "Move window to workspace below", hl.dsp.window.move({ workspace = "r+1" }))
o.bind("SUPER + SHIFT + K", "Move window to workspace above", hl.dsp.window.move({ workspace = "r-1" }))
o.bind("SUPER + SHIFT + ALT + J", "Move window silently to workspace below", hl.dsp.window.move({ workspace = "r+1", follow = false }))
o.bind("SUPER + SHIFT + ALT + K", "Move window silently to workspace above", hl.dsp.window.move({ workspace = "r-1", follow = false }))

o.bind("SUPER + Y", "Toggle workspace layout", "omarchy-hyprland-workspace-layout-toggle")
o.bind("SUPER + SHIFT + S", "Move window to scratchpad", hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }))

-- ---------------------------------------------------------------------------
-- Look
-- ---------------------------------------------------------------------------

o.bind("SUPER + SLASH", "Toggle window transparency", "omarchy-hyprland-window-transparency-toggle")
o.bind("SUPER + SHIFT + SLASH", "Toggle window gaps", "omarchy-hyprland-window-gaps-toggle")
o.bind("SUPER + CTRL + SLASH", "Toggle single-window square aspect", "omarchy-hyprland-window-single-square-aspect-toggle")

-- Monitor scaling on -/= (code:20 is minus, code:21 is equal).
o.bind("SUPER + code:20", "Monitor scaling down", "omarchy-hyprland-monitor-scaling down")
o.bind("SUPER + code:21", "Monitor scaling up", "omarchy-hyprland-monitor-scaling up")

-- ---------------------------------------------------------------------------
-- Utilities
-- ---------------------------------------------------------------------------

o.bind("SUPER + V", "Clipboard manager", "omarchy-shell shell toggle omarchy.clipboard")
o.bind("SUPER + I", "Calendar", "omarchy-shell shell toggle omarchy.clock")
o.bind("SUPER + H", "Toggle weather", "omarchy-notification-weather")
o.bind("SUPER + L", "Lock system", "omarchy-system-lock")

-- Reminders on R: set, +CTRL show, +CTRL+ALT clear.
o.bind("SUPER + R", "Set reminder", "omarchy-menu toggle reminder-set")
o.bind("SUPER + CTRL + R", "Show reminders", "omarchy-reminder show")
o.bind("SUPER + CTRL + ALT + R", "Clear reminders", "omarchy-reminder clear")

-- ---------------------------------------------------------------------------
-- Keyboard layout
-- ---------------------------------------------------------------------------

-- GNOME-style layout switching. Tap SUPER+SPACE to flip to the last used
-- layout; hold SUPER and press SPACE repeatedly to walk the layouts in
-- most-recently-used order. The choice is committed when SUPER is released.
-- Indexes match kb_layout in input.lua.
local kb_mru = { 0, 1, 2 }
local kb_pos = nil
local kb_timer = nil

local function kb_super_down()
  return hl.is_key_down("Super_L") or hl.is_key_down("Super_R")
end

local function kb_watch_release()
  if kb_pos and not kb_super_down() then
    table.insert(kb_mru, 1, table.remove(kb_mru, kb_pos))
    kb_pos = nil
    kb_timer:set_enabled(false)
  end
end

local function kb_cycle()
  kb_pos = kb_pos and (kb_pos % #kb_mru + 1) or 2
  hl.exec_cmd("~/.local/bin/kb-layout-set " .. kb_mru[kb_pos])

  if kb_timer then
    kb_timer:set_enabled(true)
  else
    kb_timer = hl.timer(kb_watch_release, { timeout = 50, type = "repeat" })
  end
end

hl.bind("SUPER + SPACE", kb_cycle, { description = "Switch keyboard layout" })
