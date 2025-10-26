return {
  "leafOfTree/vim-matchtag",
  ft = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte" },
  config = function()
    vim.g.vim_matchtag_enable_by_default = 1
    vim.g.vim_matchtag_files = "*.html,*.xml,*.jsx,*.tsx,*.vue,*.svelte"
  end,
}
