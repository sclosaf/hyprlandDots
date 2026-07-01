vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.laststatus = 2

vim.opt.showmode = false
vim.opt.showcmd = true
vim.opt.shortmess:append("I")
vim.opt.shortmess:append("c")

vim.opt.wildmenu = true
vim.opt.wildmode = { "list:longest", "full" }
vim.opt.wildoptions = "pum"
vim.opt.pumheight = 10

vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 3

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.background = "dark"
if vim.fn.has("termguicolors") == 1 then
    vim.opt.termguicolors = true
end

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.showmatch = true
vim.opt.matchtime = 5

vim.opt.linebreak = true

vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.clipboard = "unnamedplus"

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = false

vim.opt.autoread = true
vim.opt.autowrite = true

vim.opt.list = true
vim.opt.listchars = { tab = ">-", trail = "~", nbsp = "~" }

vim.opt.errorbells = false
vim.opt.visualbell = true
vim.opt.belloff = "all"

vim.opt.guicursor = ""
