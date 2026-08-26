-- ─────────────────────────────────────────────
--  Neovim — CachyGreen
-- ─────────────────────────────────────────────

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ── Опции ────────────────────────────────────
local o = vim.opt
o.number         = true
o.relativenumber = true      -- как в кадре: относительная нумерация
o.cursorline     = true
o.signcolumn     = "yes"
o.termguicolors  = true
o.mouse          = "a"
o.clipboard      = "unnamedplus"
o.expandtab      = true
o.shiftwidth     = 4
o.tabstop        = 4
o.softtabstop    = 4
o.smartindent    = true
o.wrap           = false
o.ignorecase     = true
o.smartcase      = true
o.incsearch      = true
o.hlsearch       = true
o.scrolloff      = 8
o.sidescrolloff  = 8
o.splitright     = true
o.splitbelow     = true
o.undofile       = true
o.swapfile       = false
o.updatetime     = 250
o.timeoutlen     = 400
o.laststatus     = 3         -- одна общая статусная строка
o.showmode       = false     -- режим показывает lualine
o.fillchars      = { eob = " " }
o.list           = true
o.listchars      = { tab = "» ", trail = "·", nbsp = "␣" }

-- ── Клавиши ──────────────────────────────────
local map = vim.keymap.set
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Снять подсветку поиска" })
map("n", "<C-h>", "<C-w>h", { desc = "Окно влево" })
map("n", "<C-j>", "<C-w>j", { desc = "Окно вниз" })
map("n", "<C-k>", "<C-w>k", { desc = "Окно вверх" })
map("n", "<C-l>", "<C-w>l", { desc = "Окно вправо" })
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Предыдущий буфер" })
map("n", "<S-l>", "<cmd>bnext<CR>",     { desc = "Следующий буфер" })
map("v", "<", "<gv", { desc = "Сдвиг влево" })
map("v", ">", ">gv", { desc = "Сдвиг вправо" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Сдвинуть строки вниз" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Сдвинуть строки вверх" })
map("n", "<leader>w", "<cmd>w<CR>",  { desc = "Сохранить" })
map("n", "<leader>q", "<cmd>bd<CR>", { desc = "Закрыть буфер" })

-- ── Подсветка при копировании ────────────────
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.hl.on_yank({ timeout = 150 }) end,
})

-- ── lazy.nvim ────────────────────────────────
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  install = { colorscheme = { "cachygreen" } },
  ui = { border = "rounded" },
  change_detection = { notify = false },
})

-- Цвета: палитру из обоев пишет Noctalia в lua/matugen.lua (её setup вызывается ниже).
-- Если файла нет — откатываемся на встроенную CachyGreen.
if not pcall(require, "matugen") then
  vim.cmd.colorscheme("cachygreen")
end

local ok, matugen = pcall(require, 'matugen')
if ok then matugen.setup() end
