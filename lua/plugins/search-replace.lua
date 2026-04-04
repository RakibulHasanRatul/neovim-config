return {
  "MagicDuck/grug-far.nvim",
  opts = {
    -- Key mappings (avoiding conflicts with existing <leader>sr)
    keymaps = {
      close = { "q", "<esc>" },
      next = "n",
      prev = "N", 
      replace = { "<cr>", "<tab>" },
      replaceAll = { "<c-cr>", "<c-tab>" },
      openLocation = { "go", "<enter>" },
      toggleShowHelp = "g?",
      syncLocations = "gs",
      syncLine = "gx",
      toggleTidy = "gt",
      jumpToLocation = { "gj", "<c-s>" },
      jumpToLocationInSplit = { "gJ", "<c-j>" },
      jumpToLocationInTab = { "gT", "<c-t>" },
      jumpToLocationInVsplit = { "gV", "<c-v>" },
      cycleThroughViews = "<c-l>",
      toggleRespectCase = "gc",
      toggleIgnoreFiles = "gi",
      toggleIgnoreHidden = "gh",
      toggleFixedStrings = "gf",
      toggleSmartCase = "gs",
      toggleNoIgnoreFiles = "gI",
      toggleNoIgnoreHidden = "gH",
      toggleNoFixedStrings = "gF",
      toggleNoSmartCase = "gS",
    },
    -- File filtering
    files = {
      -- Use wildcards for includes (much cleaner!)
      include = {
        "*",  -- Include all files by default
      },
      -- Exclude common build/cache/directories
      exclude = {
        "*.log",
        "*.tmp",
        "*.bak",
        "*.swp",
        "*.swo",
        "node_modules/*",
        ".git/*",
        ".DS_Store",
        "dist/*",
        "build/*",
        "out/*",
        "target/*",
        "coverage/*",
        ".pytest_cache/*",
        "__pycache__/*",
        ".venv/*",
        "venv/*",
        "env/*",
        ".env*",
        "*.lock",
        "*.cache",
        ".cache/*",
        ".idea/*",
        ".vscode/*",
        "*.class",
        "*.o",
        "*.so",
        "*.dylib",
        "*.dll",
        "*.exe",
        "*.app",
        "*.dmg",
        "*.pkg",
      },
    },
    -- Search options
    search = {
      rg = {
        additional_args = {
          "--hidden",
          "--no-ignore",
          "--smart-case",
        },
      },
    },
    -- UI settings
    icons = {
      enabled = true,
      action = "󰐊",
      close = "󰅖",
      config = "",
      location = "󰓁",
      replace = "󰒋",
      search = "󰩬",
      syncLocations = "󰓊",
      toggleHelp = "󰋖",
      toggleIgnore = "󰸱",
      toggleTidy = "󰗚",
    },
    -- Transient mode settings
    transient = true,
    -- Prefills for quick access
    prefills = {
      filesFilter = "*.lua", -- Default to Lua files
      search = "",
      replace = "",
    },
  },
  keys = {
    {
      "<leader>sr",  -- Primary global search and replace
      function()
        require("grug-far").open({
          transient = true,
          prefills = {
            filesFilter = "*.lua",
          },
        })
      end,
      desc = "[S]earch [R]eplace (Global)",
    },
    {
      "<leader>sw",  -- Word search and replace (was <leader>sW)
      function()
        require("grug-far").open({
          transient = true,
          prefills = {
            search = vim.fn.expand("<cword>"),
            filesFilter = "*.lua",
          },
        })
      end,
      desc = "[S]earch [R]eplace [W]ord",
    },
  },
}