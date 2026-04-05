return {
  "nickjvandyke/opencode.nvim",
  version = "*", -- Latest stable release
  event = "VeryLazy",
  dependencies = {
    {
      -- `snacks.nvim` integration is recommended, but optional
      ---@module "snacks" -- Loads `snacks.nvim` types for configuration intellisense
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {}, -- Enhances `ask()`
        picker = { -- Enhances `select()`
          actions = {
            opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
          },
          win = {
            input = {
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Enable LSP integration (experimental)
      lsp = {
        enabled = false, -- Set to true to enable LSP features
      },
      -- Server configuration
      server = {
        -- Use embedded terminal by default
        embedded_terminal = true,
        -- Optional: Custom server startup
        -- start = function()
        --   require('snacks.terminal').open('opencode --port', { win = { position = 'right' } })
        -- end,
      },
    }

    vim.o.autoread = true -- Required for `opts.events.reload`

    -- Keymaps have been removed as requested

    -- Statusline integration (optional - if using lualine)
    -- require("lualine").setup({
    --   sections = {
    --     lualine_z = {
    --       {
    --         require("opencode").statusline,
    --       },
    --     }
    --   }
    -- })
  end,
}