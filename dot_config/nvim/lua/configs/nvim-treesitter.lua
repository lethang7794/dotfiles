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
