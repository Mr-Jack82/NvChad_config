-------------------------------------- Options ------------------------------------------
local opt = vim.opt
local g = vim.g

opt.cmdheight = 0
opt.autowrite = true
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3
opt.formatoptions = "jcroqlnt"
opt.diffopt:append({
  "vertical",
  "iwhite",
  "hiddenoff",
  "algorithm:histogram",
  "indent-heuristic",
  "linematch:60",
})
opt.list = true
opt.pumblend = 10
opt.pumheight = 10
opt.path:append(".**")
opt.scrolloff = 6
opt.sidescrolloff = 8
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true
opt.splitkeep = "screen"
opt.textwidth = 80
opt.colorcolumn = "81"
opt.undolevels = 10000
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
opt.wildoptions = "pum,fuzzy"
opt.wildignorecase = true
opt.winminwidth = 5
opt.wrap = false
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  -- fold = "⸱",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- Set relativenumber
opt.relativenumber = true

-- Set leader key
g.mapleader = ","

-------------------------------------- Autocmds ------------------------------------------
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Prefer creating groups and assigning autocmds to groups, because it makes it easier to clear them
--[[ Mygroup Group ]]
augroup("mygroup", { clear = true })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = "mygroup",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
  group = "mygroup",
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = "mygroup",
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = "mygroup",
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Source: https://github.com/mcauley-penney/tidy.nvim
autocmd("BufWritePre", {
  pattern = "*",
  desc = "Delete trailing white space",
  group = "mygroup",
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)

    -- delete trailing whitespace
    vim.cmd([[:keepjumps keeppatterns %s/\s\+$//e]])

    -- delete lines @ eof
    vim.cmd([[:keepjumps keeppatterns silent! 0;/^\%(\n*.\)\@!/,$d_]])

    local num_rows = vim.api.nvim_buf_line_count(0)

    --[[
            if the row value in the original cursor
            position tuple is greater than the
            line count after empty line deletion
            (meaning that the cursor was inside of
            the group of empty lines at the end of
            the file when they were deleted), set
            the cursor row to the last line.
        ]]
    if pos[1] > num_rows then
      pos[1] = num_rows
    end

    vim.api.nvim_win_set_cursor(0, pos)
  end,
})
