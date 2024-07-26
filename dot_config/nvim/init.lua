vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },
  {
    import = "plugins",
  },
}, lazy_config)

require("nvim-treesitter.configs").setup {
  auto_install = true,
  incremental_selection = {
    enable = true,
    keymaps = {
      node_incremental = "v",
      node_decremental = "V",
    },
  },
}

-- Indent blankline
require("ibl").setup()

-- gitsigns
require('gitsigns').setup {
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gitsigns.nav_hunk('next')
      end
    end, { desc = "Next change" })

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gitsigns.nav_hunk('prev')
      end
    end, { desc = "Previous change" })

    -- Actions
    -- map('n', '<leader>hs', gitsigns.stage_hunk)
    -- map('n', '<leader>hr', gitsigns.reset_hunk)
    -- map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
    -- map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
    -- map('n', '<leader>hS', gitsigns.stage_buffer)
    -- map('n', '<leader>hu', gitsigns.undo_stage_hunk)
    -- map('n', '<leader>hR', gitsigns.reset_buffer)
    -- map('n', '<leader>hp', gitsigns.preview_hunk)
    -- map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end)
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
    -- map('n', '<leader>hd', gitsigns.diffthis)
    -- map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
    map('n', '<leader>td', gitsigns.toggle_deleted)

    -- Text object
    -- map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

--
-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)
