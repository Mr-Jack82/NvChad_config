---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    ["<C-s>"] = "",
    ["<C-c>"] = "",
    ["<leader>n"] = "",
    ["<leader>rn"] = "",
  },
}

M.general = {
  n = {
    ["'"] = { ",", "swap comma to quote", opts = { nowait = true } },

    -- Make sure to go to proper indentantion level when pressing i
    -- source: https://www.reddit.com/r/neovim/comments/12rqyl8/5_smart_minisnippets_for_making_text_editing_more/
    ["i"] = {
      function()
        if #vim.fn.getline(".") == 0 then
          return [["_cc]]
        else
          return "i"
        end
      end, opts = { expr=true },
    },

    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },

    -- lazy
    ["<leader>l"] = { "<cmd>Lazy<cr>", "Lazy" }

  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },

    -- focus
    ["<leader>f"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
  },
}

-- more keybinds!

return M
