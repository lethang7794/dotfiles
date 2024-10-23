local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}

--[[
COLORS & APPEARANCE
https://wezfurlong.org/wezterm/config/appearance.html
]]
config.color_scheme = "Catppuccin Mocha" -- or Macchiato, Frappe, Latte
config.font = wezterm.font 'JetBrains Mono'
config.window_background_opacity = 0.9
-- config.cursor_blink_rate = 800

-- Remove the title bar from the window
config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"

--[[
FONTS
https://wezfurlong.org/wezterm/config/fonts.html
]]
config.font_size = 13.5

--[[
KEY BINDINGS
https://wezfurlong.org/wezterm/config/keys.html
https://wezfurlong.org/wezterm/config/default-keys.html
]]
config.leader = { mods = 'CTRL', key = 'a', }
config.keys = {
  -- F11 to toggle fullscreen mode
  { mod = '',                key = 'F11',        action = wezterm.action.ToggleFullScreen },

  -- This will create a new vertical pane on the right
  { mods = 'CTRL|SHIFT',     key = 'Enter',      action = wezterm.action.SplitPane { direction = 'Right', size = { Percent = 50 } }, },
  -- This will create a new vertical pane on the bottom
  { mods = 'CTRL|SHIFT|ALT', key = 'Enter',      action = wezterm.action.SplitPane { direction = 'Down', size = { Percent = 50 } }, },

  -- Show pane selection mode with the default alphabet (labels are "a", "s", "d", "f" and so on)
  { mods = 'CTRL',           key = '`',          action = act.PaneSelect },
  -- Show pane selection mode, but have it swap the active and selected panes
  { mods = 'CTRL|ALT',       key = '`',          action = act.PaneSelect { mode = 'SwapWithActive', }, },

  { mods = 'CTRL|ALT',       key = 'z',          action = wezterm.action.TogglePaneZoomState, },

  -- AdjustPaneSize
  { mods = 'SHIFT|ALT',      key = 'LeftArrow',  action = act.AdjustPaneSize { 'Left', 1 }, },
  { mods = 'SHIFT|ALT',      key = 'DownArrow',  action = act.AdjustPaneSize { 'Down', 1 }, },
  { mods = 'SHIFT|ALT',      key = 'UpArrow',    action = act.AdjustPaneSize { 'Up', 1 } },
  { mods = 'SHIFT|ALT',      key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 }, },

  -- Rotate panes
  { mods = 'LEADER',         key = 's',          action = act.RotatePanes 'CounterClockwise', },
  { mods = 'LEADER',         key = 'd',          action = act.RotatePanes 'Clockwise' },

  -- Closes the current pane.
  -- If that was the last pane in the tab, closes the tab. If that was the last tab, closes that window. If that was the last window, wezterm terminates.
  { mods = 'CTRL|SHIFT',     key = 'w',          action = wezterm.action.CloseCurrentPane { confirm = true }, },
}

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local pane = tab.active_pane
    local icon = ''

    if pane.is_zoomed then
      icon = "'"
    end

    local title = tab_title(tab)
    if tab.is_active then
      return {
        -- { Background = { Color = 'blue' } },
        { Text = ' ' .. title .. ' ' .. icon },
      }
    end
    return title
  end
)

return config
