--[[
nvchad: https://github.com/NvChad/NvChad/blob/v2.5/lua/nvchad/mappings.lua

nvim docs: vim.keymap.set({mode}, {lhs}, {rhs}, {opts})

See:
- https://neovim.io/doc/user/lua.html#vim.keymap.set()
]]

require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- not nvim, but make things more lazy
map("n", ";", ":", { desc = "Enter command mode without press Shift" })
map("i", "jk", "<ESC>", { desc = "Quickly exit insert mode (back to normal mode) with right hand" })

-- make nvim acts as other text editor
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Save file" })

-- menu
map("n", "<C-t>", function()
  require("menu").open("default", { border = true })
end, { desc = "Open menu with keyboard" })

map("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'
  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true, border = true })
end, { desc = "nvimtree: Open menu with right mouse" })

map("n", "<A-b>", function()
  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { border = true })
end, { desc = "nvimtree: Open menu with keyboard" })
