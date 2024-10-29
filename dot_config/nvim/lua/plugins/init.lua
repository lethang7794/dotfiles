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
  { "HiPhish/rainbow-delimiters.nvim",     event = "VeryLazy" },

  --  [markdown markmap]
  --  https://github.com/Zeioth/markmap.nvim
  {
    "Zeioth/markmap.nvim",
    build = "yarn global add markmap-cli",
    cmd = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
    opts = {
      html_output = "/tmp/markmap.html", -- (default) Setting a empty string "" here means: [Current buffer path].html
      hide_toolbar = false, -- (default)
      grace_period = 3600000 -- (default) Stops markmap watch after 60 minutes. Set it to 0 to disable the grace_period.
    },
    config = function(_, opts) require("markmap").setup(opts) end
  },
}
