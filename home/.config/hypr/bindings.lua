-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- GNOME-style layout switching (SUPER+SPACE was: Omarchy menu).
-- Tap SUPER+SPACE to flip to the last used layout; hold SUPER and press SPACE
-- repeatedly to walk the layouts in most-recently-used order. The choice is
-- committed when SUPER is released. Indexes match kb_layout in input.lua.
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

hl.unbind("SUPER + SPACE")
hl.bind("SUPER + SPACE", kb_cycle, { description = "Switch keyboard layout" })

-- Tap SUPER alone to open the Omarchy menu (fires on release, so SUPER combos still work).
o.bind("SUPER + SUPER_L", "Omarchy menu", "omarchy-menu toggle", { release = true })

-- Apps menu on SUPER+A (was: SUPER+ALT+SPACE).
hl.unbind("SUPER + ALT + SPACE")
o.bind("SUPER + A", "Apps menu", "omarchy-menu toggle apps")

-- ---------------------------------------------------------------------------
-- Personal keymap rework
-- ---------------------------------------------------------------------------

-- Free the old default keys.
hl.unbind("SUPER + RETURN")              -- was: Terminal
hl.unbind("SUPER + SHIFT + RETURN")      -- was: Browser
hl.unbind("SUPER + SHIFT + B")           -- was: Browser
hl.unbind("SUPER + SHIFT + ALT + B")     -- was: Browser (private)
hl.unbind("SUPER + SHIFT + F")           -- was: File manager
hl.unbind("SUPER + ALT + SHIFT + F")     -- was: File manager (cwd)
hl.unbind("SUPER + SHIFT + N")           -- was: Editor
hl.unbind("SUPER + W")                   -- was: Close window
hl.unbind("CTRL + ALT + DELETE")         -- was: Close all windows
hl.unbind("SUPER + T")                   -- was: Toggle floating/tiling
hl.unbind("SUPER + K")                   -- was: Keybindings

-- Applications
o.bind("SUPER + T", "Terminal", { omarchy = "terminal" })
o.bind("SUPER + B", "Browser", { omarchy = "browser" })
o.bind("SUPER + ALT + B", "Browser (private)", { omarchy = "browser --private" })
o.bind("SUPER + D", "File manager", { omarchy = "nautilus" })
o.bind("SUPER + ALT + D", "File manager (cwd)", { omarchy = "nautilus-cwd" })
o.bind("SUPER + E", "Editor", { omarchy = "editor" })

-- Window actions
o.bind("SUPER + Q", "Close window", hl.dsp.window.close())
o.bind("SUPER + SHIFT + Q", "Close all windows", "omarchy-hyprland-window-close-all")
o.bind("SUPER + K", "Toggle window floating/tiling", hl.dsp.window.float({ action = "toggle" }))

-- Utilities
hl.unbind("SUPER + ALT + K")             -- was: Tmux keybindings
hl.unbind("SUPER + CTRL + K")            -- was: Herdr keybindings
o.bind("SUPER + M", "Keybindings", "omarchy-menu-keybindings")
o.bind("SUPER + ALT + M", "Tmux keybindings", "omarchy-menu-tmux-keybindings")
o.bind("SUPER + CTRL + M", "Herdr keybindings", "omarchy-menu-herdr-keybindings")

-- Resize with arrows (hold to repeat). Frees the group prev/next duplicate.
hl.unbind("SUPER + CTRL + LEFT")         -- was: Move grouped window focus left
hl.unbind("SUPER + CTRL + RIGHT")        -- was: Move grouped window focus right
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

-- Disable the old -/= resize keys (resizing lives on arrows now).
for _, mods in ipairs({ "SUPER", "SUPER + SHIFT", "SUPER + ALT", "SUPER + SHIFT + ALT", "SUPER + CTRL", "SUPER + CTRL + SHIFT" }) do
  hl.unbind(mods .. " + code:20")
  hl.unbind(mods .. " + code:21")
end

-- Scratchpad
hl.unbind("SUPER + ALT + S")             -- was: Move window to scratchpad
o.bind("SUPER + SHIFT + S", "Move window to scratchpad", hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }))

-- Clipboard history
hl.unbind("SUPER + CTRL + V")            -- was: Clipboard manager
o.bind("SUPER + Z", "Clipboard manager", "omarchy-shell shell toggle omarchy.clipboard")

-- Menus
hl.unbind("SUPER + SHIFT + code:201")    -- was: Omarchy menu (Copilot key, not present)
hl.unbind("SUPER + SHIFT + CTRL + A")    -- was: Agent
o.bind("SUPER + N", "Agent", "omarchy-agent --pick")

-- Info
hl.unbind("SUPER + CTRL + ALT + W")      -- was: Toggle weather
hl.unbind("SUPER + CTRL + Q")            -- was: Calculator
o.bind("SUPER + W", "Toggle weather", "omarchy-notification-weather")
o.bind("SUPER + R", "Calculator", "omacalc")
