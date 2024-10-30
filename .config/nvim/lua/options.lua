--[[
nvchad: https://github.com/NvChad/NvChad/blob/v2.5/lua/nvchad/options.lua

nvim docs:
- vim.o:   Vim options can be accessed through vim.o, which behaves like Vimscript :set.
- vim.opt: A special interface vim.opt exists for conveniently interacting with list- and map-style option from Lua.
(It allows accessing them as Lua tables and offers object-oriented method for adding and removing entries.)
- vim.g:   Global (g:) editor variables.

See
- https://neovim.io/doc/user/lua.html#lua-vim-setlocal
- https://neovim.io/doc/user/lua.html#vim.opt
- https://neovim.io/doc/user/lua.html#vim.g
]]

require "nvchad.options"

-- add yours here!

local o = vim.o

o.number = true               -- Show line number
o.relativenumber = true       -- Show relative line number
o.cursorlineopt = "both"      -- Enable cursorline
o.mousescroll = "ver:0,hor:0" -- Disalble mousescroll
