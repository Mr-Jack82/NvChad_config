return {
  'kylechui/nvim-surround',
  version = '*',
  -- opt for sandwitch for now until some issue been addressed
  event = { 'CursorMoved', 'CursorMovedI' },
  config = function()
    require('nvim-surround').setup({
      -- Configuration here, or leave empty to use defaults
    })
  end,
}
