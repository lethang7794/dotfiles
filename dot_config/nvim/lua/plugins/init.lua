return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre',
    cmd = { "ConformInfo" },
    config = function()
      require "configs.conform"
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server", "stylua",
        "html-lsp", "css-lsp", "prettier"
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "vim", "lua", "vimdoc", "html", "css" }
    },
    config = function()
      require "configs.nvim-treesitter"
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require "configs.gitsigns"
    end
  },
  { "junegunn/goyo.vim",                   event = "VeryLazy" },
  { 'echasnovski/mini.icons',              event = "VeryLazy", },
  { "nvim-tree/nvim-web-devicons",         event = "VeryLazy", },
  { "sindrets/diffview.nvim",              event = "VeryLazy", },
  { "preservim/vim-pencil",                event = "VeryLazy", },
  { "lukas-reineke/indent-blankline.nvim", event = "VeryLazy", main = "ibl", opts = {} },
  { "HiPhish/rainbow-delimiters.nvim",     event = "VeryLazy" }
}
