-- remaps
local km = vim.keymap.set

vim.g.mapleader = " "

km("n", "<C-h>", "<C-w>h")
km("n", "<C-j>", "<C-w>j")
km("n", "<C-k>", "<C-w>k")
km("n", "<C-l>", "<C-w>l")

km("n", "[e", vim.diagnostic.goto_next)
km("n", "]e", vim.diagnostic.goto_next)

km("n", "[s", "]s")
km("n", "]s", "[s")

km("n", "<leader>_", ":vertical resize +5<CR>")
km("n", "<leader>*", ":vertical resize -5<CR>")
km("n", "<leader>+", ":horizontal resize +5<CR>")
km("n", "<leader>-", ":horizontal resize -5<CR>")

km("v", "J", ":m '>+1<CR>gv=gv")
km("v", "K", ":m '<-2<CR>gv=gv")
km("n", "<C-n>", ":Telescope colorscheme<CR>")

km("n", "n", "nzzzv")
km("n", "N", "Nzzzv")

km("n", "J", "mzJ`z")

km("x", "<leader>p", [["_dP]])
km("n", "Q", "<nop>")
