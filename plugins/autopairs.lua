return {
  -- auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local autopairs = require("nvim-autopairs")

      autopairs.setup({
        check_ts = true,
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
          rust = { "string", "template_string", "source" },
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        fast_wrap = {
          map = "<C-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
          offset = 0, -- Offset from pattern match
          end_key = "$",
          keys = "arstneio",
          check_comma = true,
          highlight = "PmenuSel",
          highlight_grey = "LineNr",
        },
      })

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local ok, cmp = pcall(require, "cmp")
      if not ok then
        return
      end
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")

      for _, bracket in ipairs({ ")", "]", "}" }) do
        autopairs.add_rules({
          Rule("", " " .. bracket)
            :with_pair(cond.none())
            :with_move(function(opts)
              return opts.char == bracket
            end)
            :with_cr(cond.none())
            :with_del(cond.none())
            :use_key(bracket),
        })
      end
      autopairs.add_rules({
        Rule(" ", " ")
          :with_pair(cond.done())
          :replace_endpair(function(opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            if vim.tbl_contains({ "()", "{}", "[]" }, pair) then
              return " "
            end
            return ""
          end)
          :with_move(cond.none())
          :with_cr(cond.none())
          :with_del(function(opts)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local context = opts.line:sub(col - 1, col + 2)
            return vim.tbl_contains({ "(  )", "{  }", "[  ]" }, context)
          end),
      })
      require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
    end,
  },
}
