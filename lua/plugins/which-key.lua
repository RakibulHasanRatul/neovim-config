return   {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({
      plugins = {
        spelling = { enabled = true },
      },
    })

      -- Register leader key groups
      wk.add({
        { "<leader>f", group = "Find (Telescope)" },
        { "<leader>b", group = "Buffer" },
        { "<leader>h", group = "Git Hunk" },
      })
    end,
  }
