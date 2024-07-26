return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    preset = "helix",
    delay = function(ctx)
      return ctx.plugin and 0 or 300
    end,
    win = {
      padding = { 1, 2 },
    },
    keys = {
      scroll_down = "<c-f>", -- binding to scroll down inside the popup
      scroll_up = "<c-b>",   -- binding to scroll up inside the popup
    },
    icons = {
      separator = " ",
      breadcrumb = "",
      keys = {
        Up = " ",
        Down = " ",
        Left = " ",
        Right = " ",
        C = "C-",
        M = "A-",
        D = "󰘳 ",
        S = "S-",
        CR = "󰌑 ",
        Esc = "󱊷 ",
        ScrollWheelDown = "󱕐 ",
        ScrollWheelUp = "󱕑 ",
        NL = "󰌑 ",
        BS = "󰁮",
        Space = "󱁐",
        Tab = "Tab",
        F1 = "󱊫",
        F2 = "󱊬",
        F3 = "󱊭",
        F4 = "󱊮",
        F5 = "󱊯",
        F6 = "󱊰",
        F7 = "󱊱",
        F8 = "󱊲",
        F9 = "󱊳",
        F10 = "󱊴",
        F11 = "󱊵",
        F12 = "󱊶",
      }
    }
  },
  keys = {
    {
      "<leader><F1>",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
