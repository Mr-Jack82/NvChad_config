local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
-- local cmd = vim.api.nvim_create_user_command
-- local namespace = vim.api.nvim_create_namespace

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

-- Taken from AstroNvim config
local view_group = augroup("auto_view", { clear = true })
autocmd({ "BufWinLeave", "BufWritePost", "WinLeave" }, {
  desc = "Save view with mkview for real files",
  group = view_group,
  callback = function(event)
    if vim.b[event.buf].view_activated then vim.cmd.mkview { mods = { emsg_silent = true } } end
  end,
})
autocmd("BufWinEnter", {
  desc = "Try to load file view if available and enable view saving for real files",
  group = view_group,
  callback = function(event)
    if not vim.b[event.buf].view_activated then
      local filetype = vim.api.nvim_get_option_value("filetype", { buf = event.buf })
      local buftype = vim.api.nvim_get_option_value("buftype", { buf = event.buf })
      local ignore_filetypes = { "gitcommit", "gitrebase", "svg", "hgcommit" }
      if buftype == "" and filetype and filetype ~= "" and not vim.tbl_contains(ignore_filetypes, filetype) then
        vim.b[event.buf].view_activated = true
        vim.cmd.loadview { mods = { emsg_silent = true } }
      end
    end
  end,
})

autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = augroup("highlightyank", { clear = true }),
  pattern = "*",
  callback = function() vim.highlight.on_yank() end,
})

-- Leader key is ','
vim.g.mapleader = ","

-- My options
local o, opt = vim.o, vim.opt

o.relativenumber = true
o.signcolumn = 'yes:1'
o.cmdheight = 0
o.textwidth = 80
o.colorcolumn = "81"
o.scrolloff = 8
o.sidescrolloff = 8
o.breakindent = true
o.history = 100
o.infercase = true
o.linebreak = true
o.pumheight = 15
o.writebackup = false
o.virtualedit = "block"
opt.guicursor = {
  [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]],
  [[a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor]],
  [[sm:block-blinkwait175-blinkoff150-blinkon175]],
}
