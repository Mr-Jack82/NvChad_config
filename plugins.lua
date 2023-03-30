local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- TODO: need to split this file into separate configs in plugins folder
  -- with there own settings

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require("custom.configs.null-ls")
        end,
      },
      {
        "williamboman/mason.nvim",
        config = function(_, opts)
          dofile(vim.g.base46_cache .. "mason")
          require("mason").setup(opts)
          vim.api.nvim_create_user_command("MasonInstallAll", function()
            vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
          end, {})
          require("custom.configs.lspconfig") -- Load in lsp config
        end,
      },
      "williamboman/mason-lspconfig.nvim"
    },
    config = function() end, -- Override to setup mason-lspconfig
  },

  -- overrde plugin configs
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = overrides.treesitter,
  -- },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  -- {
  --   "max397574/better-escape.nvim",
  --   event = "InsertEnter",
  --   config = function()
  --     require("better_escape").setup()
  --   end,
  -- },

  {
    "max397574/better-escape.nvim",
    enabled = false
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- Use neo-tree instead
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false
  },

  -- Uncomment if you want to re-enable which-key
  {
    "folke/which-key.nvim",
    enabled = true,
  },

  -- "Old" way to intitialize plugin like that is packer.nvim uses
  -- {
  -- "phaazon/hop.nvim",
  -- branch = "v2",
  -- keys = { "s", "f", "F", "T", "t" },
  -- config = function()
  --   require("custom/configs/hop")
  -- end
  -- }
}

return plugins
