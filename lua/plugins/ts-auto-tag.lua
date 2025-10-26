return {
  "windwp/nvim-ts-autotag",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-ts-autotag").setup({
      opts = {
        -- Enable closing tags for these filetypes
        enable_close = true,
        -- Enable renaming tags for these filetypes
        enable_rename = true,
        -- Enable close on slash (type </ and it auto-completes)
        enable_close_on_slash = true,
      },
      -- Per-filetype overrides
      per_filetype = {
        ["html"] = {
          enable_close = true,
        },
        ["javascript"] = {
          enable_close = true,
        },
        ["typescript"] = {
          enable_close = true,
        },
        ["javascriptreact"] = {
          enable_close = true,
        },
        ["typescriptreact"] = {
          enable_close = true,
        },
        ["svelte"] = {
          enable_close = true,
        },
        ["vue"] = {
          enable_close = true,
        },
        ["xml"] = {
          enable_close = true,
        },
      },
    })
  end,
}
