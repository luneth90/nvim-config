-- ========================================================================== --
-- ==                           GLOBAL SETTINGS                          == --
-- ========================================================================== --

-- 基本设置

vim.g.clipboard = {
  name = 'myClipboard',
  copy = {
    ['+'] = { 'pbcopy' },
    ['*'] = { 'pbcopy' },
  },
  paste = {
    ['+'] = { 'pbpaste' },
    ['*'] = { 'pbpaste' },
  },
  cache_enabled = 1,
}
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4 
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.expandtab = false
vim.opt.breakindent = true
vim.opt.cursorline = true
vim.o.background = "dark"


-- Some servers have issues with backup files, see #649
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "yes"

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local opts = { noremap=true, silent=true }

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 全局 leader
vim.g.mapleader = ","
--vim.g.maplocalleader = ","

-- 全局键映射
vim.keymap.set("n", "<leader>cf", ":RustFmt<CR>", { desc = "Format Rust Code" })

-- 连续缩进
vim.keymap.set("v", ">", ">gv", { noremap = true })
vim.keymap.set("v", "<", "<gv", { noremap = true })

vim.keymap.set({'n', 'x'}, 'gy', '"+y') -- copy
vim.keymap.set({'n', 'x'}, 'gp', '"+p') -- paste
vim.keymap.set("n", "Y", "yy")

vim.keymap.set({'n', 'x', 'o'}, '<C-j>', '<C-W>j')
vim.keymap.set({'n', 'x', 'o'}, '<C-k>', '<C-W>k')
vim.keymap.set({'n', 'x', 'o'}, '<C-h>', '<C-W>h')
vim.keymap.set({'n', 'x', 'o'}, '<C-l>', '<C-W>l')
vim.opt.splitright = true


-- ========================================================================== --
-- ==                           LAZY PLUGINS                            == --
-- ========================================================================== --

require("config.lazy")
