local actions = require("diffview.actions")
require("diffview").setup({
  keymaps = {
    disable_defaults = false, -- Disable the default key bindings
    view = {
      { "n", "q", actions.close, { desc = "Close the panel" } },
    },
    file_panel = {
      { "n", "q", actions.close, { desc = "Close the panel" } },
    },
    file_history_panel = {
      { "n", "q", actions.close, { desc = "Close the panel" } },
      -- TODO: check if that mapping is actually working
      -- by default this action is bind to "g!"
      { "n", "?", actions.options, { desc = "Open the option panel" } },
    },
    option_panel = {
      { "n", "q", actions.close, { desc = "Close the panel" } },
    }
  },
})
