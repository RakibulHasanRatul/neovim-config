return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  version = "1.*",
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      version = "2.*",
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- Remove the condition below to re-enable on windows.
        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
          return
        end
        return "make install_jsregexp"
      end)(),
      dependencies = {
        {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
      },
    },
  },
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    keymap = {
      preset = "none", -- Start from scratch to match your old keymaps
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },

      -- Snippet navigation
      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    completion = {
      menu = {
        border = "rounded",
        draw = {
          columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "rounded",
        },
      },
      ghost_text = {
        enabled = true,
      },
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    snippets = {
      preset = "luasnip",
    },

    fuzzy = {
      implementation = "lua",
    },

    signature = {
      enabled = true,
      window = {
        border = "rounded",
      },
    },
  },
}
