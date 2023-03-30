return {
  "numToStr/Comment.nvim",
  keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
  init = require("core.utils").load_mappings "comment",
  config = function()
    require("Comment").setup()
  end,
}
