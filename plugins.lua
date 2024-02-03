local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    enabled = false,
  },

  {
    "stevearc/conform.nvim",
    --  for users those who want auto-save conform + lazyloading!
    -- event = "BufWritePre"
    config = function()
      require "custom.configs.conform"
    end,
  },
  {
    "smoka7/hop.nvim",
    version = "*",
    keys = { "s", "f", "F", "t", "T" },
    opts = {
      keys = "etovxqpdygfblzhckisuran",
    },
    config = function()
      require "custom.configs.hop"
    end
  },
  {
    "romainl/vim-cool",
    event = "BufReadPost",
  },
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    config = function()
      require "custom.configs.diffview"
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    event = function()
      if vim.fn.exists("$TMUX") == 1 then
        return "VeryLazy"
      end
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("plugins.configs.others").luasnip(opts)
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        config = function()
          require "custom.configs.autopairs"
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require "custom.configs.cmp"
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },
  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
