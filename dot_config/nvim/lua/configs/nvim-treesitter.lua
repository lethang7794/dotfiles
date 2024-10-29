-- require("nvim-treesitter.configs").setup {
--   auto_install = true,
--   incremental_selection = {
--     enable = true,
--     keymaps = {
--       node_incremental = "v",
--       node_decremental = "V",
--     },
--   },
-- }

pcall(function()
  dofile(vim.g.base46_cache .. "syntax")
  dofile(vim.g.base46_cache .. "treesitter")
end)

return {
  ensure_installed = { "lua", "luadoc", "printf", "vim", "vimdoc", "html", "css", "javascript", "typescript", "go", "bash" },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },

  auto_install = true,
  incremental_selection = {
    enable = true,
    keymaps = {
      node_incremental = "v",
      node_decremental = "V",
    },
  },
}
