-- Everforest theme for WezTerm
-- Generated from template - do not edit manually

local M = {}

M.colors = {
  -- The default text color
  foreground = "{{fg}}",
  -- The default background color
  background = "{{bg}}",

  -- Overrides the cell background color when the current cell is occupied by the
  -- cursor and the cursor style is set to Block
  cursor_bg = "{{fg}}",
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = "{{bg}}",
  -- Specifies the border color of the cursor when the cursor style is set to Block,
  -- or the color of the vertical or horizontal bar when the cursor style is set to
  -- Bar or Underline.
  cursor_border = "{{fg}}",

  -- The foreground color of selected text
  selection_fg = "{{fg}}",
  -- The background color of selected text
  selection_bg = "{{bg1}}",

  -- The color of the scrollbar "thumb"; the portion that represents the current viewport
  scrollbar_thumb = "{{gray2}}",

  -- The color of the split lines between panes
  split = "{{gray2}}",

  ansi = {
    "{{bg}}",      -- black
    "{{red}}",     -- red
    "{{green}}",   -- green
    "{{yellow}}",  -- yellow
    "{{blue}}",    -- blue
    "{{purple}}",  -- magenta
    "{{aqua}}",    -- cyan
    "{{fg}}",      -- white
  },
  brights = {
    "{{gray1}}",   -- bright black
    "{{red}}",     -- bright red
    "{{green}}",   -- bright green
    "{{yellow}}",  -- bright yellow
    "{{blue}}",    -- bright blue
    "{{purple}}",  -- bright magenta
    "{{aqua}}",    -- bright cyan
    "{{fg}}",      -- bright white
  },

  indexed = {
    [16] = "{{orange}}",
    [17] = "{{red}}",
  },

  -- Arbitrary colors of the palette in the range from 16 to 255
  compose_cursor = "{{orange}}",

  -- Colors for copy_mode and quick_select
  -- available since: 20220807-113146-c2fee766
  -- In copy_mode, the color of the active text is:
  -- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
  -- 2. selection_* otherwise
  copy_mode_active_highlight_bg = { Color = "{{bg2}}" },
  -- use `AnsiColor` to specify one of the ansi color palette values
  -- (index 0-15) using the name "Black", "Maroon", "Green",
  -- "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
  -- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
  copy_mode_active_highlight_fg = { AnsiColor = "Black" },
  copy_mode_inactive_highlight_bg = { Color = "{{bg1}}" },
  copy_mode_inactive_highlight_fg = { AnsiColor = "White" },

  quick_select_label_bg = { Color = "{{yellow}}" },
  quick_select_label_fg = { Color = "{{bg}}" },
  quick_select_match_bg = { AnsiColor = "Navy" },
  quick_select_match_fg = { Color = "{{fg}}" },

  -- Tab bar colors
  tab_bar = {
    -- The color of the strip that goes along the top of the window
    background = "{{bg}}",

    -- The active tab is the one that has focus in the window
    active_tab = {
      -- The color of the background area for the tab
      bg_color = "{{bg1}}",
      -- The color of the text for the tab
      fg_color = "{{fg}}",

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
      bg_color = "{{bg}}",
      fg_color = "{{gray2}}",
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over inactive tabs
    inactive_tab_hover = {
      bg_color = "{{bg2}}",
      fg_color = "{{fg}}",
      italic = true,
    },

    -- The new tab button that let you create new tabs
    new_tab = {
      bg_color = "{{bg}}",
      fg_color = "{{gray2}}",
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over the new tab button
    new_tab_hover = {
      bg_color = "{{bg1}}",
      fg_color = "{{fg}}",
      italic = true,
    },
  },

  -- Visual bell colors
  visual_bell = "{{yellow}}",
}

return M
