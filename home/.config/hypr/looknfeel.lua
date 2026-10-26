-- niri-style workflow: windows sit on a horizontally scrolling tape (carousel)
-- and keep their width; workspaces are stacked vertically.
hl.config({
  general = {
    layout = "scrolling",
  },

  scrolling = {
    -- A lone window keeps its column width instead of filling the screen.
    fullscreen_on_one_column = false,
    -- Center the focused column when moving between windows.
    focus_fit_method = 0,
  },
})

-- Workspaces slide vertically, following the three-finger up/down swipe.
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "easeOutQuint", style = "slidevert" })
