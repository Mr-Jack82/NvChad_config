-- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/821
-- with some improvements
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    cmd = { 'Neotree' },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle reveal<CR>", silent = true },
    },
    opts = {
      event_handlers = {
        {
          event = "file_opened",
          handler = function()
            --auto close
            require("neo-tree").close_all()
          end
        },
      },
      default_component_configs = {
        icon = {
          folder_empty = '',
        },
      },
      diagnostics = {
        highlights = {
          hint = 'DiagnosticHint',
          info = 'DiagnosticInfo',
          warn = 'DiagnosticWarn',
          error = 'DiagnosticError',
        },
      },
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      window = {
        width = 30,
        mappings = {
          ["o"] = "open",
          ["O"] = "system_open",
          ["h"] = "parent_or_close",
          ["l"] = "open",
          ["Y"] = "copy_selector",
        },
        position = "left",
      },
      filesystem = {
        use_libuv_file_watcher = true,
        follow_current_file = true,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          never_show = {
            ".DS_Store",
          },
        },
      },
    },
    config = function(_, opts)
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
      require("neo-tree").setup(opts)
    end,
  }
}
