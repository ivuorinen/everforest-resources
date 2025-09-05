-- Everforest theme for WezTerm
-- Generated from template - do not edit manually

local M = {}

M.colors = {
  -- The default text color
  foreground = "#d3c6aa",
  -- The default background color
  background = "#323d43",

  -- Overrides the cell background color when the current cell is occupied by the
  -- cursor and the cursor style is set to Block
  cursor_bg = "#d3c6aa",
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = "#323d43",
  -- Specifies the border color of the cursor when the cursor style is set to Block,
  -- or the color of the vertical or horizontal bar when the cursor style is set to
  -- Bar or Underline.
  cursor_border = "#d3c6aa",

  -- The foreground color of selected text
  selection_fg = "#d3c6aa",
  -- The background color of selected text
  selection_bg = "#3a464c",

  -- The color of the scrollbar "thumb"; the portion that represents the current viewport
  scrollbar_thumb = "#859289",

  -- The color of the split lines between panes
  split = "#859289",

  ansi = {
    "#323d43",      -- black
    "#e67e80",     -- red
    "#a7c080",   -- green
    "#dbbc7f",  -- yellow
    "#7fbbb3",    -- blue
    "#d699b6",  -- magenta
    "#83c092",    -- cyan
    "#d3c6aa",      -- white
  },
  brights = {
    "#7a8478",   -- bright black
    "#e67e80",     -- bright red
    "#a7c080",   -- bright green
    "#dbbc7f",  -- bright yellow
    "#7fbbb3",    -- bright blue
    "#d699b6",  -- bright magenta
    "#83c092",    -- bright cyan
    "#d3c6aa",      -- bright white
  },

  indexed = {
    [16] = "#e69875",
    [17] = "#e67e80",
  },

  -- Arbitrary colors of the palette in the range from 16 to 255
  compose_cursor = "#e69875",

  -- Colors for copy_mode and quick_select
  -- available since: 20220807-113146-c2fee766
  -- In copy_mode, the color of the active text is:
  -- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
  -- 2. selection_* otherwise
  copy_mode_active_highlight_bg = { Color = "#434f55" },
  -- use `AnsiColor` to specify one of the ansi color palette values
  -- (index 0-15) using the name "Black", "Maroon", "Green",
  -- "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
  -- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
  copy_mode_active_highlight_fg = { AnsiColor = "Black" },
  copy_mode_inactive_highlight_bg = { Color = "#3a464c" },
  copy_mode_inactive_highlight_fg = { AnsiColor = "White" },

  quick_select_label_bg = { Color = "#dbbc7f" },
  quick_select_label_fg = { Color = "#323d43" },
  quick_select_match_bg = { AnsiColor = "Navy" },
  quick_select_match_fg = { Color = "#d3c6aa" },

  -- Tab bar colors
  tab_bar = {
    -- The color of the strip that goes along the top of the window
    background = "#323d43",

    -- The active tab is the one that has focus in the window
    active_tab = {
      -- The color of the background area for the tab
      bg_color = "#3a464c",
      -- The color of the text for the tab
      fg_color = "#d3c6aa",

      -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
      -- label shown for this tab.
      -- The default is "Normal"
      intensity = "Normal",

      -- Specify whether you want "None", "Single" or "Double" underline for
      -- label shown for this tab.
      -- The default is "None"
      underline = "None",

      -- Specify whether you want the text to be italic (true) or not (false)
      -- for this tab. The default is false.
      italic = false,

      -- Specify whether you want the text to be rendered with strikethrough (true)
      -- or not for this tab. The default is false.
      strikethrough = false,
    },

    -- Inactive tabs are the tabs that do not have focus
    inactive_tab = {
      bg_color = "#323d43",
      fg_color = "#859289",
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over inactive tabs
    inactive_tab_hover = {
      bg_color = "#434f55",
      fg_color = "#d3c6aa",
      italic = true,
    },

    -- The new tab button that let you create new tabs
    new_tab = {
      bg_color = "#323d43",
      fg_color = "#859289",
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over the new tab button
    new_tab_hover = {
      bg_color = "#3a464c",
      fg_color = "#d3c6aa",
      italic = true,
    },
  },

  -- Visual bell colors
  visual_bell = "#dbbc7f",
}

return M
